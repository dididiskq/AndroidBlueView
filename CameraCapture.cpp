#include "CameraCapture.h"
#include <QDebug>
#include <QThread>
#include<QMediaDevices>
#include <QtConcurrent/QtConcurrentRun>
#include <QZXing.h>
#include <cstring> // 添加头文件

CameraCapture::CameraCapture(QObject *parent)
    : QObject(parent)
{
    selfObj = (CHMModule *)parent;
    m_videoSink = new QVideoSink(this);
    m_captureSession.setVideoSink(m_videoSink);

    connect(m_videoSink, &QVideoSink::videoFrameChanged,
            this, &CameraCapture::handleVideoFrame);
}

CameraCapture::~CameraCapture()
{
    stopCamera();
}

QList<QCameraDevice> CameraCapture::availableCameras()
{
    return QMediaDevices::videoInputs();
}

bool CameraCapture::startCamera()
{
    auto cameras = availableCameras();
    if (cameras.isEmpty()) {
        qWarning() << "No cameras found!";
        return false;
    }

    stopCamera(); // 确保先停止之前的摄像头

    m_camera = new QCamera(cameras.first());
    // 选择支持 640x480 的格式
    QList<QCameraFormat> formats = cameras.first().videoFormats();
    for (const QCameraFormat &format : formats) {
        if (format.pixelFormat() == QVideoFrameFormat::Format_NV21 ||
            format.pixelFormat() == QVideoFrameFormat::Format_YUV420P) {
            m_camera->setCameraFormat(format);
            break;
        }
    }

    m_captureSession.setCamera(m_camera);
    m_camera->start();

    return true;
}

void CameraCapture::stopCamera()
{
    if (m_camera) {
        m_camera->stop();
        delete m_camera;
        m_camera = nullptr;
    }
}

void CameraCapture::setMaxFPS(int fps)
{
    m_maxFPS = (fps > 0) ? fps : 30;
}
// CameraCapture.cpp
void CameraCapture::handleVideoFrame(const QVideoFrame &frame) {
    // 帧率控制
    const qint64 now = QDateTime::currentMSecsSinceEpoch();
    if ((now - m_lastProcessTime) < (1000 / m_maxFPS)) return;
    m_lastProcessTime = now;

    // 直接处理帧
    QString base64 = convertFrameToBase64(frame);
    if (!base64.isEmpty()) {
        emit frameBase64Ready(base64);
    }
}

QString CameraCapture::convertFrameToBase64(const QVideoFrame &frame) {
    QVideoFrame localFrame(frame);
    if (!localFrame.map(QVideoFrame::ReadOnly)) {
        qWarning() << "Failed to map video frame";
        return "";
    }

    // 转换为 QImage（确保在主线程）
    QImage image = localFrame.toImage();
    localFrame.unmap();

    // 压缩为 JPEG（降低质量）
    QByteArray byteArray;
    QBuffer buffer(&byteArray);
    buffer.open(QIODevice::WriteOnly);
    if (!image.save(&buffer, "JPEG", 50)) {
        return "";
    }

    return QString::fromLatin1(byteArray.toBase64());
}

void CameraCapture::cameraOperaSlot(const int type)
{
    if(type == 1)
    {
        // startCamera();
    }
    else if(type == 0)
    {
        // stopCamera();
    }
}
void CameraCapture::parseCode(const QImage&  img)
{

        QZXing decoder;
        //QR Code二维码
        decoder.setDecoder(QZXing::DecoderFormat_QR_CODE);

        decoder.setSourceFilterType(QZXing::SourceFilter_ImageNormal);
        decoder.setTryHarderBehaviour(QZXing::TryHarderBehaviour_ThoroughScanning |
                                      QZXing::TryHarderBehaviour_Rotate);
        QString info = decoder.decodeImage(img);
        if(info == "")
        {

        }
        else
        {
            int randNum = rand()% 100 + 1;
            QString t =QString::number(randNum);
            info += t;

            // selfObj->selfViewCommand->selfView.context("HMStmView")->setFieldValue("codeData", info);
        }
}
// CameraCapture.cpp

// YUV → RGB 像素级转换
int CameraCapture::convert_yuv_to_rgb_pixel(int y, int u, int v) {
    unsigned int pixel32 = 0;
    unsigned char *pixel = (unsigned char *)&pixel32;
    int r, g, b;
    r = y + (1.370705 * (v-128));
    g = y - (0.698001 * (v-128)) - (0.337633 * (u-128));
    b = y + (1.732446 * (u-128));
    if(r > 255) r = 255;
    if(g > 255) g = 255;
    if(b > 255) b = 255;
    if(r < 0) r = 0;
    if(g < 0) g = 0;
    if(b < 0) b = 0;
    pixel[0] = r * 220 / 256;
    pixel[1] = g * 220 / 256;
    pixel[2] = b * 220 / 256;
    return pixel32;

}

// YUV → RGB 缓冲区转换
int CameraCapture::convert_yuv_to_rgb_buffer(unsigned char *yuv, unsigned char *rgb,
                                             unsigned int width, unsigned int height) {
    // ...（直接使用用户提unsigned int in, out = 0;
    unsigned int in, out = 0;
    unsigned int pixel_16;
    unsigned char pixel_24[3];
    unsigned int pixel32;
    int y0, u, y1, v;
    for(in = 0; in < width * height * 2; in += 4) {
        pixel_16 = yuv[in + 3] << 24 | yuv[in + 2] << 16 | yuv[in + 1] <<  8 | yuv[in + 0];
        y0 = (pixel_16 & 0x000000ff);
        u  = (pixel_16 & 0x0000ff00) >>  8;
        y1 = (pixel_16 & 0x00ff0000) >> 16;
        v  = (pixel_16 & 0xff000000) >> 24;
        pixel32 = convert_yuv_to_rgb_pixel(y0, u, v);
        pixel_24[0] = (pixel32 & 0x000000ff);
        pixel_24[1] = (pixel32 & 0x0000ff00) >> 8;
        pixel_24[2] = (pixel32 & 0x00ff0000) >> 16;
        rgb[out++] = pixel_24[0];
        rgb[out++] = pixel_24[1];
        rgb[out++] = pixel_24[2];
        pixel32 = convert_yuv_to_rgb_pixel(y1, u, v);
        pixel_24[0] = (pixel32 & 0x000000ff);
        pixel_24[1] = (pixel32 & 0x0000ff00) >> 8;
        pixel_24[2] = (pixel32 & 0x00ff0000) >> 16;
        rgb[out++] = pixel_24[0];
        rgb[out++] = pixel_24[1];
        rgb[out++] = pixel_24[2];
    }
    return 0;
}

// 封装为QImage生成函数
QImage CameraCapture::convertYUVToRGB(const QVideoFrame &frame) {
    // 仅处理特定YUV格式
    const auto pixelFormat = frame.pixelFormat();
    if (pixelFormat != QVideoFrameFormat::Format_NV21 &&
        pixelFormat != QVideoFrameFormat::Format_YUV420P) {
        return frame.toImage(); // 非YUV格式使用默认转换
    }

    // 映射帧数据
    QVideoFrame localFrame(frame);
    if (!localFrame.map(QVideoFrame::ReadOnly)) {
        qWarning() << "Failed to map YUV frame";
        return QImage();
    }

    // 准备RGB缓冲区
    const int width = frame.width();
    const int height = frame.height();
    unsigned char *rgbData = new unsigned char[width * height * 3];
    memset(rgbData, 0, width * height * 3);

    // 执行转换
    convert_yuv_to_rgb_buffer(localFrame.bits(0), rgbData, width, height);

    // 生成QImage
    QImage image(rgbData, width, height, QImage::Format_RGB888,
                 [](void *data) { delete[] static_cast<unsigned char*>(data); }, rgbData);

    localFrame.unmap();
    return image;
}
