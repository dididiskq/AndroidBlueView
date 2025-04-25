#pragma once
#include <QObject>
#include <QTranslator>

#include "hmview.h"
#include"hmmodule.h"
#include "hmcommand.h"
#include <QZXing.h>
#include<QVideoFrame>
class CHMModule;
class CHMViewCommand: public CHMCommand
{
    Q_OBJECT
public:
    explicit CHMViewCommand(QObject *parent = 0, const QString &name = "");
    ~CHMViewCommand();
    bool initView();
    //  设置客显界面变量
    bool initViewVariable();
    void setLanguageView();
    virtual void processCommand(const QString &command, const QVariantMap &op, QVariant &result);
    virtual void initCommands();
    virtual bool isCommand(const QString& command);
    virtual void processOp(const QVariantMap &op);
    virtual void sendOp(const QVariantMap &op);
    virtual void clearBuf();
    virtual void onHeartbeatTimer();
    virtual void disConnect();
    virtual void connect();
    void appendCommand(const QVariantMap &op);




    bool onStartSearchBlue(const QVariantMap &op);
    bool onSendToBlue(const QVariantMap &op);
    bool onSendCodeData(const QVariantMap &op);
    bool onConnectBlue(const QVariantMap &op);
    bool onGetProtectMsg(const QVariantMap &op);

    void playAudio(const QString &filePath);
public:


public slots:
    void render_image(const QString &base64);

    // 更新摄像头数据
    //    void updateFrame();
    //    QString imageToBase64( QImage image);

signals:
    void playVoice(const QString path);
    void startBle();
    void sendBlueSlot(const int type);
    void connectBlueSlot(const QString addr);
    void writeBlueSlot(const QVariantMap &op);
    void protectMsgSignal(const int type);
    void parseCodeSlot(const QImage& img);
    void cameraOpera(const int type);
public:
    CHMModule *selfObj;
    CHMView selfView;                                             // 界面对象
    typedef bool (CHMViewCommand::*func)(const QVariantMap &op);  // 定义数据类型，
    QMap<QString, CHMViewCommand::func> selfCommands;
    bool imageReady = false;

    int currentIndex;

    int frameCount = 0;



};
