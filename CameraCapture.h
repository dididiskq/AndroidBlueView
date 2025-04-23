#pragma once
#include <QObject>
#include <QCamera>
#include <QMediaCaptureSession>
#include <QVideoSink>
#include <QCameraDevice>
#include <QVideoFrame>
#include <QImage>
#include <QBuffer>
#include <QDateTime>

class CHMModule;
class CameraCapture : public QObject
{
    Q_OBJECT
public:
    explicit CameraCapture(QObject *parent = nullptr);
    ~CameraCapture();

    // 获取所有可用摄像头设备
    static QList<QCameraDevice> availableCameras();

    // 启动摄像头（默认使用第一个可用摄像头）
    Q_INVOKABLE bool startCamera();

    // 停止摄像头
    Q_INVOKABLE void stopCamera();

    // 设置帧率限制（单位：FPS）
    Q_INVOKABLE void setMaxFPS(int fps);
    void parseCode(const QImage&  img);


    void cameraOperaSlot(const int type);
    int convert_yuv_to_rgb_pixel(int y, int u, int v);
    int convert_yuv_to_rgb_buffer(unsigned char *yuv, unsigned char *rgb,
                                  unsigned int width, unsigned int height);
    QImage convertYUVToRGB(const QVideoFrame &frame);
signals:
    // 发送 Base64 编码的视频帧信号
    void frameBase64Ready(const QString &base64);

private slots:
    void handleVideoFrame(const QVideoFrame &frame);

private:
    CHMModule *selfObj;
    QCamera *m_camera = nullptr;
    QMediaCaptureSession m_captureSession;
    QVideoSink *m_videoSink = nullptr;
    qint64 m_lastProcessTime = 0;
    int m_maxFPS = 10; // 默认最大 30 FPS

    QString convertFrameToBase64(const QVideoFrame &frame);
};


