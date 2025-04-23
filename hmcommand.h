#ifndef HMCOMMAND_H
#define HMCOMMAND_H

#include <QObject>
#include <QString>
#include "hmthread.h"
#include <QTimer>

class CHMCommand : public QObject
{
    Q_OBJECT
public:
    explicit CHMCommand(QObject *parent = 0);
    virtual ~CHMCommand();

    void close();
    QString getName();
    virtual  bool isCommand(const QString& command) = 0;
    /**
     * @brief processCommand
     * @param command 模块命令
     * @param op 模块命令字典
     * @param result true-命令无需应答， false-命令收到回复后需要应答指定数据
     */
    virtual void processCommand(const QString &command, const QVariantMap &op, QVariant &result) = 0;
    /**
     * @brief initCommands
     * 初始化回调函数列表
     */
    virtual void initCommands() = 0;
    virtual void processOp(const QVariantMap &op) = 0;
    /**
     * @brief clearBuf
     * 清空命令缓存
     */
    virtual void clearBuf() = 0;
    /**
     * @brief appendCommand
     * @param op 添加并执行模块本模块命令
     */
    virtual void appendCommand(const QVariantMap &op) = 0;
    /**
     * @brief heartBeatTimerStart 心跳启动
     * @param msec 心跳周期单位毫秒
     */
    void heartBeatTimerStart(int msec);
    /**
     * @brief heartBeatTimerStop 心跳停止
     */
    void heartBeatTimerStop();
    /**
     * @brief disConnect
     * 模块断开后回调
     */
    virtual void disConnect();
    /**
     * @brief connect
     * 模块链接上后回调
     */
    virtual void connect();
    /**
     * @brief isConnect
     * 是否链接状态
     * @return
     */
    bool isConnect();
    /**
     * @brief setHeartbeartCount
     * 心跳计数设置
     * @param count
     */
    void setHeartbeartCount(int count);
    /**
     * @brief setHeartbeartCountMax
     * 心跳最大计数设置， 心跳计数超过最大计数， 模块将被判断离线
     * @param max
     */
    void setHeartbeartCountMax(int max);
    /**
     * @brief setUseSync
     * 设置是否使用启用同步收发， 同步是指发送和接收为一组原子操作， 中间不会被打断
     * @param s
     */
//    void setUseSync(bool s);
    /**
     * @brief isUseSync
     * 判断模块是否使用了同步
     * @return
     */
//    bool isUseSync();
    //设置同步标志
    /**
     * @brief setSyncFlag
     * 设置原子操作标志位
     * @param flag
     */
//    void setSyncFlag(bool flag);
    /**
     * @brief isSyncFlag
     * 判断原子操作标志位状态
     * @return
     */
//    bool isSyncFlag();
//    /**
//     * @brief processSendOperatioins
//     */
//    virtual bool processSendOperatioins(CHMThread *threader);
//    /**
//     * @brief processRevOperatioins
//     */
//    virtual bool processRevOperatioins(CHMThread *threader);


    virtual void setSyncOpertionOverTime();

public slots:
    virtual void sendOp(const QVariantMap &op) = 0;
    virtual void onHeartbeatTimer() = 0;
    void onHeartbeatCountTimer();
    void stopOverTimer();

signals:
    void deviceEvent(const QVariantMap &event);
    void stopTimer();

protected:
    QTimer selfHeartbeatTimer;//心跳定时器
    QTimer selfHeartbeatCountTimer;//心跳计数定时器
    int selfHeartbeatCount;//心跳计数
    int selfHeartbeatCountMax;//心跳计数最大值
    bool selfOnLine;//在线标志

    QStringList selfGroupTopics;
protected:
    QString selfName;
};

#endif // HMCOMMAND_H
