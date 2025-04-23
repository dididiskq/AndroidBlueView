#include "hmthread.h"
#include <QDebug>

CHMThread::CHMThread(QObject *parent) :
    QThread(parent)
{
    selfRunning = false;
}

CHMThread::~CHMThread()
{

}

QVariantList &CHMThread::operations()
{
    return selfExecuteOperations;
}

void CHMThread::appendOp(const QVariantMap &operation)
{
    operationMutex.lock();
    operations() << QVariant(operation);
    operationMutex.unlock();
}

void CHMThread::run()
{ 
}

void CHMThread::start(QThread::Priority p)
{
    selfRunning = true;
    QThread::start(p);
}

void CHMThread::terminate()
{
    selfRunning = false;
    QThread::terminate();
}

void CHMThread::quit()
{
    selfRunning = false;
    QThread::quit();
}

void CHMThread::clearExecuteOperations()
{
    selfExecuteOperations.clear();
}

void CHMThread::operationLock()
{
    operationMutex.lock();
}

void CHMThread::operationUnlock()
{
    operationMutex.unlock();
}































