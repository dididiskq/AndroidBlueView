#include <QDebug>
#include <QTimer>
#include <QDebug>
#include <QJsonDocument>
#include "hmutils.h"
#include "hmviewcommand.h"
// #include <qrencode.h>
#include <QUrl>
#include <QScreen>

CHMViewCommand::CHMViewCommand(QObject *parent, const QString &name)
    : CHMCommand(parent)

{
    selfObj = (CHMModule *)parent;
    selfName = name;
    initCommands();
    this->selfView.setName(selfName);

    QObject::connect(&this->selfView, SIGNAL(updateCommand(QVariantMap&, QVariant&)), selfObj, SLOT(test(QVariantMap&, QVariant&)));
}

CHMViewCommand::~CHMViewCommand()
{
    this->close();
}

bool CHMViewCommand::initView()
{

    initViewVariable(); //  初始化客显界面变量
#ifdef Q_OS_LINUX

    QVariantMap OSType;
    OSType["type"] = 0;//WINDOWS
    selfView.context("HMMaintenance")->setFieldValue("OSType", OSType);

#else
    //    HmLog << "OSType===Windows" << HmLogEnd;
#endif
    //    HMUtils::log() << "initViews()" <<HMLog::endl;
    if (!selfView.initViews())
    {
        HMUtils::log() << "初始化界面失败" <<HMLog::endl;
        return false;
    }
    return true;
}

bool CHMViewCommand::initViewVariable()
{
    HMUtils::log() <<"initViewVariable:" << QGuiApplication::applicationDirPath() <<HMLog::endl;
    QString absPath = "../";


    selfView.context("HMStmView")->setFieldValue("soh", 0);
    selfView.context("HMStmView")->setFieldValue("soc", 0);
    int width = QGuiApplication::primaryScreen()->geometry().width();
    int height = QGuiApplication::primaryScreen()->geometry().height();
    selfView.context("HMStmView")->setFieldValue("winWidth", width);
    selfView.context("HMStmView")->setFieldValue("winHeight", height);
    qDebug()<<height<<width;
    //    selfView.context("HMStmView")->setFieldValue("codeUrl", "D:/svn_chanpin/tai_zhou/pro/HMStorageView/views/image/QRCode.png");
    return true;
}

void CHMViewCommand::processCommand(const QString& command, const QVariantMap &op, QVariant &result)
{
    Q_UNUSED(command);
    processOp(op);
    result = true;
}

//注册回调
void CHMViewCommand::initCommands()
{
    selfCommands["start.search.blue"] = &CHMViewCommand::onStartSearchBlue;
    selfCommands["send.to.blue"] = &CHMViewCommand::onSendToBlue;
    selfCommands["send.codeData"] = &CHMViewCommand::onSendCodeData;
    selfCommands["connect.blue"] = &CHMViewCommand::onConnectBlue;
    selfCommands["get.protectMsg"] = &CHMViewCommand::onGetProtectMsg;
}

bool CHMViewCommand::isCommand(const QString &command)
{
    bool ret = selfCommands.contains(command);
    return  ret;
}

void CHMViewCommand::processOp(const QVariantMap &op)
{
    QString command = op.value("command").toString();
    CHMViewCommand::func f = selfCommands.value(command);
    bool result = false;
    Q_UNUSED(result);
    //    if (f != NULL)
    //    {
    //        result = (this->*f)(op);
    //    }
    try
    {
        if (f != NULL)
        {
            result = (this->*f)(op);
        }

    }
    catch (const std::exception& e)
    {
        qDebug()<<command + e.what();
    }
    catch (...)
    {
        qDebug()<<command + "未知异常";
    }
}

void CHMViewCommand::sendOp(const QVariantMap &op)
{
    Q_UNUSED(op);
    HMUtils::log()<<"void CHMViewCommand::sendOp(const QVariantMap &op)"<<HMLog::endl;
}

void CHMViewCommand::clearBuf()
{
    HMUtils::log()<<"clearBuf" << HMLog::endl;
}

void CHMViewCommand::onHeartbeatTimer()
{

}

void CHMViewCommand::disConnect()
{

}

void CHMViewCommand::connect()
{

}

void CHMViewCommand::appendCommand(const QVariantMap &op)
{

    sendOp(op);
}


bool CHMViewCommand::onStartSearchBlue(const QVariantMap &op)
{
    emit startBle();
    return true;
}


void CHMViewCommand::render_image(const QString &base64)
{
    if (!base64.isEmpty())
    {
        selfView.context("HMStmView")->setBase64Image(base64);
    }
}



bool CHMViewCommand::onSendToBlue(const QVariantMap &op)
{
    int type = op.value("type", -1).toInt();
    if(type >= 0x200)
    {
        emit writeBlueSlot(op);
    }
    else
    {
        emit sendBlueSlot(abs(type));
    }
    return true;
}
// 转换 NV12 到 RGB 的函数
QImage convertNV12ToRGB(const QVideoFrame &frame) {
    QVideoFrame cloneFrame(frame);
    if (!cloneFrame.map(QVideoFrame::ReadOnly)) {
        qWarning() << "Failed to map video frame";
        return QImage();
    }

    const int width = cloneFrame.width();
    const int height = cloneFrame.height();

    // NV12 数据指针
    const uchar *yData = cloneFrame.bits(0);
    const uchar *uvData = cloneFrame.bits(1);

    // 创建目标 RGB 图像
    QImage rgbImage(width, height, QImage::Format_RGB888);
    uchar *rgbData = rgbImage.bits();

    // YUV420（NV12）到 RGB 转换算法
    for (int y = 0; y < height; ++y) {
        for (int x = 0; x < width; ++x) {
            const int yIndex = y * cloneFrame.bytesPerLine(0) + x;
            const int uvIndex = (y / 2) * cloneFrame.bytesPerLine(1) + (x / 2) * 2;

            const uchar Y = yData[yIndex];
            const uchar U = uvData[uvIndex];
            const uchar V = uvData[uvIndex + 1];

            // YUV 转 RGB 公式
            int R = Y + 1.402 * (V - 128);
            int G = Y - 0.34414 * (U - 128) - 0.71414 * (V - 128);
            int B = Y + 1.772 * (U - 128);

            R = qBound(0, R, 255);
            G = qBound(0, G, 255);
            B = qBound(0, B, 255);

            rgbData[(y * width + x) * 3] = R;
            rgbData[(y * width + x) * 3 + 1] = G;
            rgbData[(y * width + x) * 3 + 2] = B;
        }
    }

    cloneFrame.unmap();
    return rgbImage;
}
QImage convertNV21ToRGB(const QVideoFrame &frame, bool isRGB = true) {
    // 映射视频帧到内存
    QVideoFrame cloneFrame(frame);
    if (!cloneFrame.map(QVideoFrame::ReadOnly)) {
        qWarning() << "Failed to map video frame";
        return QImage();
    }

    // 获取基础参数
    const int width = cloneFrame.width();
    const int height = cloneFrame.height();
    const int frameSize = width * height;

    // 获取 Y 和 UV 平面数据指针
    const uchar* yPlane = cloneFrame.bits(0);
    const uchar* uvPlane = cloneFrame.bits(1);

    // 创建目标图像（默认RGB888格式）
    QImage rgbImage(width, height, QImage::Format_RGB888);
    uchar* rgbData = rgbImage.bits();

    // 核心转换逻辑
    for (int y = 0; y < height; ++y) {
        for (int x = 0; x < width; ++x) {
            // Y 分量索引
            const int yIndex = y * cloneFrame.bytesPerLine(0) + x;
            const uchar Y = yPlane[yIndex];

            // UV 分量索引（NV21的UV交错排列）
            const int uvRow = y / 2;
            const int uvCol = x - x % 2;
            const int uvIndex = uvRow * cloneFrame.bytesPerLine(1) + uvCol;

            const uchar V = uvPlane[uvIndex];
            const uchar U = uvPlane[uvIndex + 1];

            // YUV 转 RGB 计算（整数优化版）
            int R = Y + ((351 * (V - 128)) >> 8);
            int G = Y - ((179 * (V - 128) + 86 * (U - 128)) >> 8);
            int B = Y + ((443 * (U - 128)) >> 8);

            // 饱和处理
            R = qBound(0, R, 255);
            G = qBound(0, G, 255);
            B = qBound(0, B, 255);

            // 写入目标缓冲区
            const int rgbIndex = (y * width + x) * 3;
            if (isRGB) {
                rgbData[rgbIndex]     = uchar(R);
                rgbData[rgbIndex + 1] = uchar(G);
                rgbData[rgbIndex + 2] = uchar(B);
            } else { // BGR 模式
                rgbData[rgbIndex]     = uchar(B);
                rgbData[rgbIndex + 1] = uchar(G);
                rgbData[rgbIndex + 2] = uchar(R);
            }
        }
    }

    cloneFrame.unmap();
    return rgbImage;
}

bool CHMViewCommand::onSendCodeData(const QVariantMap &op)
{


    QVariant imageVar = op.value("codeData");

    if (!imageVar.canConvert<QImage>())
    {
        qDebug() << "无效的 QImage 数据";
        return true;
    }

    QImage image = imageVar.value<QImage>();
    if (image.isNull())
    {
        qDebug() << "图像为空";
        return true;
    }

    if (image.isNull())
    {
        qCritical() << "Error: Image file not loaded!";
        return -1;
    }

    //opengl
    // QVideoFrame frame = imageVar.value<QVideoFrame>();
    // QImage rgbImage = convertNV12ToRGB(frame);


    emit parseCodeSlot(image);
    return true;
}

bool CHMViewCommand::onConnectBlue(const QVariantMap &op)
{
    QString addr = op.value("addr").toString();
    emit connectBlueSlot(addr);
    return true;
}
bool CHMViewCommand::onGetProtectMsg(const QVariantMap &op)
{
    int type = op.value("type", -1).toInt();
    emit protectMsgSignal(type);
    return true;
}
