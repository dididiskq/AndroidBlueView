#include <QDebug>
#include <QTimer>
#include <QDebug>
#include <QJsonDocument>
#include "hmutils.h"
#include "hmviewcommand.h"
#include <qrencode.h>
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
        HMUtils::log() << "初始化界面失败" <<HMLog::endl;
        return false;
    }
    return true;
}

bool CHMViewCommand::initViewVariable()
{
    HMUtils::log() <<"initViewVariable:" << QGuiApplication::applicationDirPath() <<HMLog::endl;
    QString absPath = "../";
    selfView.context("HMStmView")->setFieldValue("SampleRValue", "0");
    selfView.context("HMStmView")->setFieldValue("version", selfObj->version);
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
    selfCommands["close.app"] = &CHMViewCommand::onCloseApp;
    selfCommands["get.timerData"] = &CHMViewCommand::onTimerData;
    selfCommands["init.ble"] = &CHMViewCommand::onInitBle;
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


bool CHMViewCommand::onSendCodeData(const QVariantMap &op)
{

    int type = op.value("type", -1).toInt();
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

    // QZXing decoder;
    // decoder.setDecoder(QZXing::DecoderFormat_QR_CODE);

    // decoder.setSourceFilterType(QZXing::SourceFilter_ImageNormal);
    // decoder.setTryHarderBehaviour(QZXing::TryHarderBehaviour_ThoroughScanning |
    //                               QZXing::TryHarderBehaviour_Rotate);
    QString info = decoder.decodeImage(image);
    // qDebug()<<"扫描结果："<<info;
    if(info == "")
    {

    }
    else
    {
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
