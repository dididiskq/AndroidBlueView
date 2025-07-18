#pragma once
#include <QObject>
#include "hmviewcommand.h"
#include "QVariantMap"
#include "hmregister.h"
#include "hmmodulebasics.h"
#include"BmsController.h"



class CHMViewCommand;
class BmsController;
class CHMModule: public CHMModuleBasics
{
    Q_OBJECT
public:
    explicit CHMModule(QObject *parent = 0);
    ~CHMModule();
    void doProcessOp(const QVariantMap &op);
    bool start();
    void stop();
    void initConnectSlots();
public slots:
    void test(QVariantMap& parameters, QVariant &result);

    void playVoices(const QString path);
    void parseCode(const QImage&  img);
    void closeAppSlot();

public:
        // 配置文件

    CHMViewCommand *selfViewCommand;    // 界面文件
    BmsController *selfBmsCommand;
    CHMRegister selfRegister;           // 注册器

};

