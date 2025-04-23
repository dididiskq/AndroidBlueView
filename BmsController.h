#pragma once
#include <QObject>
#include <QBluetoothLocalDevice>
#include <QBluetoothDeviceDiscoveryAgent>
#include <QStandardItemModel>
#include <QLowEnergyService>
#include <QLowEnergyController>
#include <QVector>
#include <QBluetoothUuid>
#include <QMap>
#include <QtBluetooth/QLowEnergyCharacteristic>
#include<QTextCodec>
#include "hmmodule.h"
#include<QQueue>
#include"BMSProtocol.h"
class CHMModule;
static QString byteArrayToHexStr(const QByteArray &data)
{
    QString temp = "";
    QString hex = data.toHex();
    for (int i = 0; i < hex.length(); i = i + 2) {
        temp += hex.mid(i, 2) + " ";
    }

    return temp.trimmed().toUpper();
}
static char hexStrToChar(char data)
{
    if ((data >= '0') && (data <= '9')) {
        return data - 0x30;
    } else if ((data >= 'A') && (data <= 'F')) {
        return data - 'A' + 10;
    } else if ((data >= 'a') && (data <= 'f')) {
        return data - 'a' + 10;
    } else {
        return (-1);
    }
}
static QByteArray hexStrToByteArray(const QString &data)
{
    QByteArray senddata;
    int hexdata, lowhexdata;
    int hexdatalen = 0;
    int len = data.length();
    senddata.resize(len / 2);
    char lstr, hstr;

    for (int i = 0; i < len;) {
        hstr = data.at(i).toLatin1();
        if (hstr == ' ') {
            i++;
            continue;
        }

        i++;
        if (i >= len) {
            break;
        }

        lstr = data.at(i).toLatin1();
        hexdata = hexStrToChar(hstr);
        lowhexdata = hexStrToChar(lstr);

        if ((hexdata == 16) || (lowhexdata == 16)) {
            break;
        } else {
            hexdata = hexdata * 16 + lowhexdata;
        }

        i++;
        senddata[hexdatalen] = (char)hexdata;
        hexdatalen++;
    }

    senddata.resize(hexdatalen);
    return senddata;
}

static unsigned short crc16_ccitt(const char *buf, int len)
{
    unsigned short crc = 0;
    for (int i = 0; i < len; ++i)
    {
        crc = (crc << 8) ^ crc16tab[((crc >> 8) ^ (static_cast<quint8>(buf[i]))) & 0xFF];
    }
    return crc;
}

class BmsController : public QObject
{
    Q_OBJECT
public:
    explicit BmsController(QObject *parent = nullptr);

    ~BmsController();

    void searchCharacteristic();

    void viewWriteMessage(const QVariantMap &op);
    void connectBlue(const QString addr);
signals:
    void startBlue();
    void writeOperationCompleted(bool success, const QString &error);
public slots:
    void onWriteTimeout();

    void viewMessage(const int type);
    void SendMsg(const QByteArray&);
    void startSearch();
    void onDescriptorWritten(const QLowEnergyDescriptor& descriptor, const QByteArray& value);

    void findFinish();

    void addBlueToothDevicesToList(QBluetoothDeviceInfo);

    void serviceDiscovered(const QBluetoothUuid & serviceUuid);

    void serviceScanDone();

    void serviceStateChanged(QLowEnergyService::ServiceState s);

    void BleServiceCharacteristicWrite(const QLowEnergyCharacteristic &c, const QByteArray &value);

    void BleServiceCharacteristicChanged(const QLowEnergyCharacteristic &c, const QByteArray &value);

    void BleServiceCharacteristicRead(const QLowEnergyCharacteristic &c, const QByteArray &value);
    void sendMsgByQueue();
    void getProtectMsgSlot(const int type);
private:

    void processNextWriteRequest();

private:
    CHMModule *selfObj;
    BMSProtocol protocal;

    QBluetoothDeviceDiscoveryAgent *Discovery;//扫描蓝牙(经典蓝牙和BLE蓝牙)类

    QStandardItemModel *item;

    QBluetoothDeviceInfo currentDevice;
    QVector<QBluetoothDeviceInfo> deviceList;

    QLowEnergyCharacteristic  mCharacteristic; //记录当前选定的特性值
    QLowEnergyCharacteristic m_Characteristic[3];//存放选中服务的特性值 0-write 1-read 2-notify

    QLowEnergyController * mController = nullptr; //对蓝牙低能耗设备的访问

    QVector<QLowEnergyService *> serviceList;
    QLowEnergyService *currentService;

    bool isItemchoose = false;

    // 定义发送队列和定时器
    QQueue<QByteArray> commandQueue;
    QTimer sendTimer;

    QQueue<QByteArray> writeQueue;  // 写入请求队列
    bool isWriting = false;         // 当前是否正在写入

    const QBluetoothUuid SERVICE_UUID = QBluetoothUuid(QUuid("00002760-08C2-11E1-9073-0E8AC72E1001"));
    const QBluetoothUuid WRITE_UUID   = QBluetoothUuid(QUuid("00002760-08C2-11E1-9073-0E8AC72E0001"));
    const QBluetoothUuid NOTIFY_UUID  = QBluetoothUuid(QUuid("00002760-08C2-11E1-9073-0E8AC72E0002"));

    QTimer m_writeTimeoutTimer;
    bool m_waitingWriteResponse;

    bool isConnected = false;
    QVariantList cellVlist;
    QVariantMap protectMap;//保护事件、时间
    QList<int> initCmdList{0, 1, 2,3,4,6,
                           8, 10, 12,14 ,15,16,
                           17,18,19,20,21,22,
                           23,24,24,26,27,28,
                           29,30,31, 32,33,34,35,36,37,38,39,40,
                           41,42,43,44,45,46,47,48,49,50,51,52,53,54,
                           55, 56,57,58,59,60,61,62,63};
};
