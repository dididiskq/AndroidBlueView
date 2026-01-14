#include <QDebug>
#include <QTimer>
#include <QDebug>
#include <QJsonDocument>
#include "hmutils.h"
#include "hmviewcommand.h"
#include <qrencode.h>
#include <QUrl>
#include <QScreen>
#include "ZXing/src/ReadBarcode.h"
CHMViewCommand::CHMViewCommand(QObject *parent, const QString &name)
    : CHMCommand(parent)

{
    selfObj = (CHMModule*)parent;
    selfName = name;
    initCommands();
    this->selfView.setName(selfName);

    QObject::connect(&this->selfView, SIGNAL(updateCommand(QVariantMap&, QVariant&)), selfObj, SLOT(test(QVariantMap&, QVariant&)));
    decoder.setSourceFilterType(QZXing::SourceFilter_ImageNormal);
    decoder.setTryHarderBehaviour(QZXing::TryHarderBehaviour_ThoroughScanning |
                                  QZXing::TryHarderBehaviour_Rotate);
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
        HMUtils::log() << "初始化界面失败" << HMLog::endl;
        return false;
    }
    return true;
}

bool CHMViewCommand::initViewVariable()
{
    HMUtils::log() << "initViewVariable:" << QGuiApplication::applicationDirPath() << HMLog::endl;
    QString absPath = "../";
    selfView.context("HMStmView")->setFieldValue("SampleRValue", "0");
    selfView.context("HMStmView")->setFieldValue("version", selfObj->version);
    selfView.context("HMStmView")->setFieldValue("soh", 0);
    selfView.context("HMStmView")->setFieldValue("soc", 0);
    int width = QGuiApplication::primaryScreen()->geometry().width();
    int height = QGuiApplication::primaryScreen()->geometry().height();
    selfView.context("HMStmView")->setFieldValue("winWidth", width);
    selfView.context("HMStmView")->setFieldValue("winHeight", height);
    qDebug() << height << width;
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
    selfCommands["close.app"] = &CHMViewCommand::onCloseApp;
    selfCommands["get.timerData"] = &CHMViewCommand::onTimerData;
    selfCommands["init.ble"] = &CHMViewCommand::onInitBle;
    selfCommands["read.table1"] = &CHMViewCommand::onReadTable1;
    selfCommands["read.table2"] = &CHMViewCommand::onReadTable2;
    selfCommands["read.table3"] = &CHMViewCommand::onReadTable3;
    selfCommands["scan.codeble"] = &CHMViewCommand::onScanCodeBle;
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
        qDebug() << command + e.what();
    }
    catch (...)
    {
        qDebug() << command + "未知异常";
    }
}

void CHMViewCommand::sendOp(const QVariantMap &op)
{
    Q_UNUSED(op);
    HMUtils::log() << "void CHMViewCommand::sendOp(const QVariantMap &op)" << HMLog::endl;
}

void CHMViewCommand::clearBuf()
{
    HMUtils::log() << "clearBuf" << HMLog::endl;
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
    int inputData = op.value("inputData", 0).toInt();
    if(inputData == 10000)
    {
        emit writeBlueSlot(op);
        return true;
    }
    else if(type >= 0x200)
    {
        emit writeBlueSlot(op);
    }
    else
    {
        emit sendBlueSlot(abs(type));
    }
    return true;
}

QImage enhanceForQR(const QImage &src)
{
    QImage gray = src.convertToFormat(QImage::Format_Grayscale8);

    // 简单对比度拉伸
    for (int y = 0; y < gray.height(); ++y)
    {
        uchar *line = gray.scanLine(y);
        for (int x = 0; x < gray.width(); ++x)
        {
            uchar v = line[x];
            line[x] = (v > 128) ? 255 : 0;   // 简单二值化
        }
    }
    return gray;
}

bool CHMViewCommand::onSendCodeData(const QVariantMap &op)
{

    int type = op.value("type", -1).toInt();
    QVariant imageVar = op.value("codeData");

    if (!imageVar.canConvert<QImage>())
    {
        qDebug() << "无效的 QImage 数据";
        return true;
    }

    QImage image = enhanceForQR(imageVar.value<QImage>());

    if (image.isNull())
    {
        qDebug() << "图像为空";
        return true;
    }

    // 转为灰度图像
    QImage gray = image.convertToFormat(QImage::Format_Grayscale8);

    // 创建 ZXing 的图像视图
    ZXing::ImageView zxingImage(
        static_cast<const uint8_t*>(gray.constBits()),
        gray.width(),
        gray.height(),
        ZXing::ImageFormat::Lum,
        gray.bytesPerLine()
    );

    // 设置识别参数
    ZXing::ReaderOptions options;
    options.setFormats(ZXing::BarcodeFormat::Any);
    options.setTryHarder(true);

    // 解码二维码（支持多码）
    auto results = ZXing::ReadBarcodes(zxingImage, options);
    QString info = "";
    // 输出结果
    for (const auto& result : results)
    {
        if (result.isValid())
        {
            qDebug() << "格式:" << QString::fromStdString(ZXing::ToString(result.format()));
            qDebug() << "内容:" << QString::fromStdString(result.text());
            info = QString::fromStdString(result.text());
            if(info.contains("http"))
            {
                continue;
            }
            else
            {
                break;
            }
        }
    }

    // QString info = decoder.decodeImage(image);
    // qDebug() << "QZXing扫码结果：" << info;
#if defined(Q_OS_IOS)
    //iOS
    QStringList parts = info.split('|');
    if (parts.size() >= 2)
    {
        info = parts[1].trimmed(); // UUID
    }
    else
    {
        info = ""; // 格式错误，返回空
    }
#elif defined(Q_OS_ANDROID)
    // Android
    QStringList parts = info.split('|');
    if (!parts.isEmpty())
    {
        info = parts[0].trimmed(); // MAC
    }
    else
    {
        info = "";
    }
#else
    // 其他平台处理
    QStringList parts = info.split('|');
    if (!parts.isEmpty())
    {
        info = parts[0].trimmed(); // MAC
    }
    else
    {
        info = "";
    }
#endif
    // QString info = "";
    if(info == "")
    {

    }
    else
    {
        // if(info.contains("http"))
        // {
        //     return true;
        // }
        scanName = info;
        emit selfObj->selfViewCommand->selfView.context("HMStmView")->codeImageReady("connecting", 1);
        return true;
        if(type == 1)
        {
            // emit parseCodeSlot(image);
            QString cleaned = info.trimmed();

            // 定义 MAC 地址正则表达式（兼容大小写和不同分隔符）
            QRegularExpression regex(
                "^"                          // 字符串开始
                "([0-9A-Fa-f]{2}"           // 第一个十六进制字节
                "([:-])){5}"                // 分隔符重复5次（冒号或短横线）
                "[0-9A-Fa-f]{2}"            // 最后一个字节
                "$"                         // 字符串结束
            );
            regex.setPatternOptions(QRegularExpression::CaseInsensitiveOption);

            // 执行正则匹配
            QRegularExpressionMatch match = regex.match(cleaned);

            // 验证结果有效性
            bool res = match.hasMatch() &&
                       cleaned.size() == 17 &&  // 标准长度校验（6字节×2 + 5分隔符）
                       !cleaned.contains("  ");  // 排除连续分隔符的情况
            if(res)
            {
                if(selfObj->selfBmsCommand->scanBlueList.contains(cleaned))
                {
                    emit selfObj->selfViewCommand->selfView.context("HMStmView")->codeImageReady("connecting", 1);
                    selfObj->selfBmsCommand->isScanConn = true;
                    emit connectBlueSlot(info);
                }
                else
                {
                    if(!selfObj->selfBmsCommand->isSearching)
                    {
                        emit startBle();
                    }
                }
            }
        }
        else if(type == 2)
        {
            emit selfObj->selfViewCommand->selfView.context("HMStmView")->codeImageReady(info, type);
        }
    }


    // emit parseCodeSlot(image);
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

bool CHMViewCommand::onCloseApp(const QVariantMap &op)
{
    emit closeAppSignal();
    return true;
}

bool CHMViewCommand::onTimerData(const QVariantMap &op)
{
    int type = op.value("type", -1).toInt();
    emit getTimerDataSignal(type);
    return true;
}

bool CHMViewCommand::onInitBle(const QVariantMap &op)
{
    emit initBleSignal();
    return true;
}

bool CHMViewCommand::onReadTable1(const QVariantMap &op)
{
    emit sendBlueSlot(10001);
    return true;
}

bool CHMViewCommand::onReadTable2(const QVariantMap &op)
{
    emit sendBlueSlot(10002);
    return true;
}

bool CHMViewCommand::onReadTable3(const QVariantMap &op)
{
    emit sendBlueSlot(10003);
    return true;
}
bool CHMViewCommand::onScanCodeBle(const QVariantMap &op)
{
    // emit parseCodeSlot(image);
    QString cleaned = scanName.trimmed();

    // 定义 MAC 地址正则表达式（兼容大小写和不同分隔符）
    QRegularExpression regex(
        "^"                          // 字符串开始
        "([0-9A-Fa-f]{2}"           // 第一个十六进制字节
        "([:-])){5}"                // 分隔符重复5次（冒号或短横线）
        "[0-9A-Fa-f]{2}"            // 最后一个字节
        "$"                         // 字符串结束
    );
    regex.setPatternOptions(QRegularExpression::CaseInsensitiveOption);

    // 执行正则匹配
    QRegularExpressionMatch match = regex.match(cleaned);

    // 验证结果有效性
    bool res = match.hasMatch() &&
               cleaned.size() == 17 &&  // 标准长度校验（6字节×2 + 5分隔符）
               !cleaned.contains("  ");  // 排除连续分隔符的情况
    if(res)
    {
        if(selfObj->selfBmsCommand->scanBlueList.contains(cleaned))
        {
            emit selfObj->selfViewCommand->selfView.context("HMStmView")->codeImageReady("gogogo", 1);
            selfObj->selfBmsCommand->isScanConn = true;
            emit connectBlueSlot(cleaned);
        }
        else
        {
            if(!selfObj->selfBmsCommand->isSearching)
            {
                emit startBle();
            }
        }
    }
    return true;
}
