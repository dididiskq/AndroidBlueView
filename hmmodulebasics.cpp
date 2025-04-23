#include "hmmodulebasics.h"

/*!
 * \brief CHMModule::CHMModule
 * \param parent
 */
CHMModuleBasics::CHMModuleBasics(QObject *parent) : QObject(parent)
{
    selfThread = new CHMTestThread(this);
    selfThread->start();
}

CHMModuleBasics::~CHMModuleBasics()
{
    selfThread->terminate();
}

bool CHMModuleBasics::processOp()
{
    selfThread->operationLock();
    bool hasOperations = !selfThread->operations().isEmpty();
    if (hasOperations)
    {
        QVariantMap operation = selfThread->operations().first().toMap();
        selfThread->operations().removeFirst();
        selfThread->operationUnlock();
        doProcessOp(operation);
        return true;
    }
    else
    {
        selfThread->operationUnlock();
        return false;
    }
}

void CHMModuleBasics::doProcessOp(const QVariantMap &op)
{
    Q_UNUSED(op);
}








