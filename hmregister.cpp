#include "hmregister.h"
#include <QDebug>
CHMRegister::CHMRegister(QObject *parent)
    : QObject(parent)
{
}

CHMRegister::~CHMRegister()
{

}

void CHMRegister::setRegister(const QString &name, QObject *obj)
{
    selfRegister[name] =  obj;
}

void CHMRegister::setRegister(QStringList &list, QObject *obj)
{
    foreach (QString name, list) {
        selfRegister[name] =  obj;
    }
}

QObject* CHMRegister::isHasObj(const QString &name)
{
    return selfRegister.value(name, NULL);
}









