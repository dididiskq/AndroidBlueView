#include <qDebug>
#include "hmmodule.h"
#include "hmutils.h"
#include <QtConcurrent/QtConcurrentRun>
#include <QRegularExpression>
#include<QCoreApplication>
// 构造函数
CHMModule::CHMModule(QObject *parent)
    : CHMModuleBasics(parent)
{
    /*
        版本:1.00.001.20250623
        @author:skq
    */
    version = "1.00.001.20250623";
    HMUtils::log() << QString("界面程序版本： %1").arg(version) <<HMLog::endl;


    selfViewCommand = new CHMViewCommand(this, "View");  // 界面对象
    selfRegister.setRegister("View", selfViewCommand);

    selfBmsCommand = new BmsController(this, "Ble");
    selfRegister.setRegister("Ble", selfBmsCommand);
    m_camera = new CameraCapture(this);
    initConnectSlots();
}

CHMModule::~CHMModule()
{

    if (selfViewCommand)
    {
        delete selfViewCommand;
        selfViewCommand = nullptr;
    }
    if (selfBmsCommand)
    {
        delete selfBmsCommand;
        selfBmsCommand = nullptr;
    }

}

void CHMModule::initConnectSlots()
{
    connect(m_camera, &CameraCapture::frameBase64Ready, selfViewCommand, &CHMViewCommand::render_image);
    connect(selfViewCommand, &CHMViewCommand::cameraOpera, m_camera, &CameraCapture::cameraOperaSlot);
    connect(selfViewCommand, &CHMViewCommand::startBle, selfBmsCommand, &BmsController::startSearch);
    connect(selfViewCommand, &CHMViewCommand::sendBlueSlot, selfBmsCommand, &BmsController::viewMessage);
    connect(selfViewCommand, &CHMViewCommand::writeBlueSlot, selfBmsCommand, &BmsController::viewWriteMessage);
    connect(selfViewCommand, &CHMViewCommand::connectBlueSlot, selfBmsCommand, &BmsController::connectBlue);
    connect(selfViewCommand, &CHMViewCommand::protectMsgSignal, selfBmsCommand, &BmsController::getProtectMsgSlot);
    connect(selfViewCommand, &CHMViewCommand::parseCodeSlot, this, &CHMModule::parseCode);
    connect(selfViewCommand, &CHMViewCommand::closeAppSignal, this, &CHMModule::closeAppSlot);
    connect(selfViewCommand, &CHMViewCommand::getTimerDataSignal, selfBmsCommand, &BmsController::getTimerDataSignalSlot);

}
// 重写父类的方法
void CHMModule::doProcessOp(const QVariantMap &op)
{
    QString name = op.value("name").toString();
    QString command = op.value("command").toString();
    CHMCommand* obj = (CHMCommand*)selfRegister.isHasObj(name);
    QVariant result = true;

    if (obj)
    {
        if (obj->isCommand(command))
        {
            obj->isConnect();
            // qDebug()<<"主线程"<<name<<command;
            obj->processCommand(command, op, result);
        }
        else
        {
            qDebug() << name << "模块, " << command << ", 无此命令";
            // HMUtils::log() << name << "模块, " << command << ", 无此命令" << HMLog::endl;
        }
    }
    else
    {
        qDebug()<< name << ", 模块未注册" ;
        // HMUtils::log() << name << ", 模块未注册" << HMLog::endl;
    }
}

bool CHMModule::start()
{
    return selfViewCommand->initView();
}

void CHMModule::stop()
{
    HMUtils::log()<<"stop"<<HMLog::endl;
}

void CHMModule::test(QVariantMap &parameters, QVariant &result)
{
    Q_UNUSED(result);
    this->selfThread->appendOp(parameters);
}

void CHMModule::playVoices(const QString path)
{

}

void CHMModule::parseCode(const QImage&  img)
{
    // QFuture<void> future = QtConcurrent::run([=]() {
        //QR Code二维码
        decoder.setDecoder(QZXing::DecoderFormat_QR_CODE);

        decoder.setSourceFilterType(QZXing::SourceFilter_ImageNormal);
        decoder.setTryHarderBehaviour(QZXing::TryHarderBehaviour_ThoroughScanning |
                                      QZXing::TryHarderBehaviour_Rotate);
        QString info = decoder.decodeImage(img);
        qDebug()<<"二维码识别结果:"<<info;
        if(info == "")
        {

        }
        else
        {
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
                emit selfViewCommand->selfView.context("HMStmView")->codeImageReady("connecting", 1);
                // selfViewCommand->selfView.context("HMStmView")->setFieldValue("codeData", info);
                selfBmsCommand->isScanConn = true;
                selfBmsCommand->connectBlue(info);
            }
        }
    // });
}

void CHMModule::closeAppSlot()
{
    QCoreApplication::quit();
}





