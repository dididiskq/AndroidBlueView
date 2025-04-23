#include "hmtestthread.h"
#include <QDebug>

CHMTestThread::CHMTestThread(QObject *parent) :
    CHMThread(parent)
{
    selfObj = (CHMModuleBasics*)parent;
}

CHMTestThread::~CHMTestThread()
{

}

/**
 * @brief CHMTestThread::run
 *  线程运行函数
 */
void CHMTestThread::run()
{ 
     while (selfRunning)
     {
//         operationLock();
         if(!selfObj->processOp())
         {
              msleep(10);
         }
//         operationUnlock();
     }
}
































