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
        版本:1.00.001.20250808
        @author:skq
    */
    version = "1.00.001.20250814";
    HMUtils::log() << QString("界面程序版本： %1").arg(version) <<HMLog::endl;


    selfViewCommand = new CHMViewCommand(this, "View");  // 界面对象
    selfRegister.setRegister("View", selfViewCommand);

    selfBmsCommand = new BmsController(this, "Ble");
    selfRegister.setRegister("Ble", selfBmsCommand);

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

}

void CHMModule::closeAppSlot()
{
    QCoreApplication::quit();
}





