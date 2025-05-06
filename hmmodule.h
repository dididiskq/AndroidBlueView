#pragma once
#include <QObject>
// #include "HMUtils/device/hmmqttclient.h"


#include "hmviewcommand.h"
#include "QVariantMap"
#include "hmregister.h"
#include "hmmodulebasics.h"
#include"BmsController.h"
#include"CameraCapture.h"
#include <QZXing.h>
// class CHMMqttCommand;
class CHMViewCommand;
class BmsController;
// The CHMModule class
class CHMModule: public CHMModuleBasics
{
    Q_OBJECT
public:
    explicit CHMModule(QObject *parent = 0);
    ~CHMModule();
    void doProcessOp(const QVariantMap &op);
    bool start();
    void stop();
    //    void textDeome();  // 调试一些测试信息
    void initConnectSlots();
public slots:
    void test(QVariantMap& parameters, QVariant &result);

    void playVoices(const QString path);
    void parseCode(const QImage&  img);

public:
        // 配置文件

    CHMViewCommand *selfViewCommand;    // 界面文件
    BmsController *selfBmsCommand;
    CHMRegister selfRegister;           // 注册器
    CameraCapture *m_camera;
    QZXing decoder;

};

