#include "hmutils.h"
#include "hmcommand.h"

CHMCommand::CHMCommand(QObject *parent) :
    QObject(parent)
{
    selfHeartbeatCount = 0;
    selfHeartbeatCountMax = 100;
    selfOnLine = false;
    selfName = "";
    QObject::connect(&selfHeartbeatTimer, SIGNAL(timeout())
                     , this, SLOT(onHeartbeatTimer()));
    QObject::connect(&selfHeartbeatCountTimer, SIGNAL(timeout())
                     , this, SLOT(onHeartbeatCountTimer()));

}



CHMCommand::~CHMCommand()
{
    close();
}

void CHMCommand::close()
{

}

QString CHMCommand::getName()
{
    return  selfName;
}


void CHMCommand::heartBeatTimerStart(int msec)
{
    this->selfHeartbeatTimer.start(msec);
    this->selfHeartbeatCountTimer.start(msec);
}

void CHMCommand::heartBeatTimerStop()
{
    this->selfHeartbeatTimer.stop();
}

void CHMCommand::onHeartbeatCountTimer()
{

    selfHeartbeatCount += 1;
    if (selfHeartbeatCount > selfHeartbeatCountMax)
    {
        if (selfOnLine)
        {
            disConnect();
            clearBuf();
            selfOnLine = false;
        }
    }
}

void CHMCommand::disConnect()
{
//    qDebug() << selfName << ", >>>>>>>>>>>>>>>>>>>>>>. 断线" << endl;
    HMUtils::log() << selfName << ", 断线" << HMLog::endl;
}

void CHMCommand::connect()
{
//    qDebug() << selfName << ", >>>>>>>>>>>>>>>>>>>>>>. 在线" << endl;
    HMUtils::log() << selfName << ", 在线" << HMLog::endl;
}

bool CHMCommand::isConnect()
{
    setHeartbeartCount(0);
    if (!selfOnLine)
    {
        connect();
        selfOnLine = true;
    }

    return selfOnLine;
}

void CHMCommand::setHeartbeartCount(int count)
{
    this->selfHeartbeatCount = count;
}

void CHMCommand::setHeartbeartCountMax(int max)
{
    this->selfHeartbeatCountMax = max;
}


void CHMCommand::setSyncOpertionOverTime()
{

}

void CHMCommand::stopOverTimer()
{
//    selfSendThread->stopOverTimer();
}


















