#pragma once
#include <QObject>
#include <QVariantMap>
#include "hmtestthread.h"
class CHMTestThread;
/**
 * @brief The CHMModuleBasics class
 *        子模块的基类，
 *        属性：  线程对象
 */
class CHMModuleBasics: public QObject
{
    Q_OBJECT
public:
    explicit CHMModuleBasics(QObject *parent = 0);
    ~CHMModuleBasics();

    virtual bool processOp();
    virtual void doProcessOp(const QVariantMap &op);

//public slots:
//    void test(QVariantMap& parameters, QVariant &result);

public:
    CHMTestThread *selfThread;
    QString version;
};

