#include "hmutils.h"

#include <QSettings>
#include <QDebug>

#include <QDir>
#include <string.h>
#include <iostream>
#include <QTextCodec>
//#include <windows.h>
#include <QCryptographicHash>
//#define USELOGDIR false



#ifdef OPENSSL
#include "openssl/rsa.h"
#include "openssl/pem.h"
#include "openssl/err.h"
#include "openssl/evp.h"
#endif


QMap<QString, HMLog*> HMUtils::logs;

HMUtils::HMUtils(QObject *parent) : QObject(parent)
{

}

HMLog& HMUtils::log(const QString &name)
{
    HMLog *l = NULL;
    l = HMUtils::logs.value(name);
    QString logName = name;
    if (l == NULL)//如果没有创建过
    {
        logName = QString("%1log/%2").arg(ABS_PATH).arg(logName);
        if (!name.endsWith(".log"))
        {
            logName += ".log";
        }

        l = new HMLog(logName);
        HMUtils::logs[name] = l;
    }


    if (!l->isOpen())
    {
        l->open(logName, "Text Log", true, 1024 * 1024 * 100);
    }

    return *l;
}

void HMUtils::logChangeDay()
{

}

QByteArray HMUtils::uintToByte(uint number)
{
    QByteArray abyte;
    abyte.resize(4);
    abyte[0] = (uchar)  (0x000000ff & number);
    abyte[1] = (uchar) ((0x0000ff00 & number) >> 8);
    abyte[2] = (uchar) ((0x00ff0000 & number) >> 16);
    abyte[3] = (uchar) ((0xff000000 & number) >> 24);
    return abyte;
}

QByteArray HMUtils::uintToByteBig(uint number)
{
    QByteArray abyte;
    abyte.resize(4);
    abyte[3] = (uchar)  (0x000000ff & number);
    abyte[2] = (uchar) ((0x0000ff00 & number) >> 8);
    abyte[1] = (uchar) ((0x00ff0000 & number) >> 16);
    abyte[0] = (uchar) ((0xff000000 & number) >> 24);
    return abyte;
}

QByteArray HMUtils::ushortToByte(ushort number)
{
    QByteArray abyte;
    abyte.resize(2);
    abyte[0] = (uchar)  (0x00ff & number);
    abyte[1] = (uchar) ((0xff00 & number) >> 8);
    return abyte;
}
QByteArray HMUtils::ushortToByteBig(ushort number)
{
    QByteArray abyte;
    abyte.resize(2);
    abyte[1] = (uchar)  (0x00ff & number);
    abyte[0] = (uchar) ((0xff00 & number) >> 8);
    return abyte;
}

QByteArray HMUtils::ushortToByte_1(ushort number)
{
    QByteArray abyte;
    abyte.resize(2);
    abyte[1] = (uchar)  (0x00ff & number);
    abyte[0] = (uchar) ((0xff00 & number) >> 8);
    return abyte;
}

QByteArray HMUtils::int3ToByte(uint number)
{
    QByteArray abyte;
    abyte.resize(3);
    abyte[0] = (uchar)  (0x000000ff & number);
    abyte[1] = (uchar) ((0x0000ff00 & number) >> 8);
    abyte[2] = (uchar) ((0x00ff0000 & number) >> 16);
    return abyte;
}

uint HMUtils::byteArrayToUint(const QByteArray &a)
{
    if(a.length() < 3)
    {
        return 0;
    }
    unsigned char balanceL = a.at(0);
    unsigned char balanceM = a.at(1);
    unsigned char balanceH = a.at(2);

    int balance = 0;
    balance = ((((balance | balanceH) << 8) | balanceM) << 8) | balanceL;
    return balance;
}

uint HMUtils::byteArrayToUint4Byte(const QByteArray &a)
{
    if(a.length() < 4)
    {
        return 0;
    }
    unsigned char data0 = a.at(0);
    unsigned char data1 = a.at(1);
    unsigned char data2 = a.at(2);
    unsigned char data3 = a.at(3);

    int balance = 0;
    balance = (data3 << 24) | (data2 << 16) | (data1 << 8) | data0;

    return balance;
}

int HMUtils::byteArrayToInt(const QByteArray &a)
{


    if(a.length() < 3)
    {
        return 0;
    }
    char byte = a.at(2);
    int v = 0;
    QByteArray bytes = a;

    if (byte &80)
    {
        ((char*)&v)[0] = bytes.at(0);
        ((char*)&v)[1] = bytes.at(1);
        ((char*)&v)[2] = bytes.at(2);
        ((char*)&v)[3] = 0xFF;
    }
    else
    {
        ((char*)&v)[0] = bytes.at(0);
        ((char*)&v)[1] = bytes.at(1);
        ((char*)&v)[2] = bytes.at(2);
        ((char*)&v)[3] = 0x00;
    }
    return v;
}

int HMUtils::byteArrayToInt_3(const QByteArray &a)
{
    if(a.length() < 3)
    {
        return 0;
    }
    char byte = a.at(2);
    int v = 0;
    QByteArray bytes = a;
    if (byte &0x80)
    {
        ((char*)&v)[0] = bytes.at(0);
        ((char*)&v)[1] = bytes.at(1);
        ((char*)&v)[2] = bytes.at(2);
        ((char*)&v)[3] = 0xFF;
    }
    else
    {
        ((char*)&v)[0] = bytes.at(0);
        ((char*)&v)[1] = bytes.at(1);
        ((char*)&v)[2] = bytes.at(2);
        ((char*)&v)[3] = 0x00;
    }
    return v;
}

int HMUtils::byteArrayToInt_4(const QByteArray &a)
{
    if(a.length() < 4)
    {
        return 0;
    }
    int v = 0;
    QByteArray bytes = a;

    ((char*)&v)[0] = bytes.at(0);
    ((char*)&v)[1] = bytes.at(1);
    ((char*)&v)[2] = bytes.at(2);
    ((char*)&v)[3] = bytes.at(3);

    return v;
}

int HMUtils::byteArrayToInt_2(const QByteArray &a)
{
    if(a.length() < 2)
    {
        return 0;
    }
    qint16 v = 0;
    QByteArray bytes = a;

    ((char*)&v)[0] = bytes.at(0);
    ((char*)&v)[1] = bytes.at(1);
    return (int)v;
}

ushort HMUtils::byteToUshort(const QByteArray &byte)
{
    if(byte.length() < 2)
    {
        return 0;
    }
    uchar d = byte.at(0);
    uchar d1 = byte.at(1);
    ushort ret = (d1 << 8) | d;
    return ret;
}

ushort HMUtils::byteToUshortBig(const QByteArray &byte)
{
    if(byte.length() < 2)
    {
        return 0;
    }
    uchar d = byte.at(0);
    uchar d1 = byte.at(1);
    ushort ret = (d << 8) | d1;
    return ret;
}

uchar HMUtils::calcXorSum(const QByteArray &bytes)
{
    unsigned char bcc = 0;
    for(int i = 0;i<bytes.size();i++)
    {
        bcc ^= (unsigned char)bytes.at(i);
    }
    return bcc;
}



uint HMUtils::dateTimeToSec(QDateTime &time)
{
    uint t;
    return t;
}

QDateTime HMUtils::secToDateTime(uint sec)
{
    // return QDateTime::fromTime_t(sec);
    QDateTime t;
    return t;
}

QByteArray HMUtils::overturnArray(const QByteArray &bytes)
{
    int len = bytes.length();
    QByteArray tmp;
    tmp.resize(len);
    for(int i=0; i<len; i++)
    {
        tmp[len -1 - i] = bytes[i];
    }
    return tmp;
}

QByteArray HMUtils::stringToArrray(const QString &str)
{
    QByteArray byte = QByteArray::fromHex(str.toLocal8Bit());
    return byte;
}

uchar HMUtils::decToBCD(uchar temp)
{
    return ( (temp/10)*16 + temp%10 ) ;
}

uchar HMUtils::bcdToDec(uchar n)
{
    return (n / 16) * 10 + ( n % 16);
}

QString HMUtils::byteArrayToString(QByteArray array)
{
    return QString(array.toHex());
}


// 读取信息
QVariant
HMUtils::settingValue(
        const QString &name,
        const QString &group,
        const QVariant &defaultValue,
        const QString &filename
        )
{
    QString sFilename = QString("%1ini/%2").arg(ABS_PATH).arg(filename);
    // qDebug()<<sFilename;
    QSettings settings(sFilename, QSettings::IniFormat);
    settings.beginGroup(group);
    QVariant value = settings.value(name, defaultValue);
    settings.endGroup();
    // qDebug()<<value<<"****";
    return value;
}



void
HMUtils::setSettingValue(
        const QVariant &value,
        const QString &name,
        const QString &group,
        const QString &filename
        )
{
    QString sFilename = QString("%1ini/%2").arg(ABS_PATH).arg(filename);
    QSettings settings(sFilename, QSettings::IniFormat);
    settings.beginGroup(group);
    // settings.setIniCodec(QTextCodec::codecForName("UTF-8"));
    settings.setValue(name, value);
    settings.endGroup();

    settings.sync();
}

QVariantMap HMUtils::allKeys()
{
    QString sFilename = QString("%1ini/%2").arg(ABS_PATH).arg("w_view.ini");
    QSettings settings(sFilename, QSettings::IniFormat);
    settings.beginGroup("viewInfo");
    // settings.setIniCodec(QTextCodec::codecForName("GB2312"));

    QVariantMap map;
    QStringList ll =  settings.allKeys();

    for(int i = 0;i< ll.length();i++)
    {
        QVariant value = settings.value(ll[i], "xxx");
        map[ll[i]] = value.toString();
    }
    return map;
}

QVariantMap HMUtils::allKeys(const QString &group, const QString &filename)
{
    QString sFilename = QString("%1ini/%2").arg(ABS_PATH).arg(filename);
    QSettings settings(sFilename, QSettings::IniFormat);
    settings.beginGroup(group);
    // settings.setIniCodec(QTextCodec::codecForName("UTF-8"));

    QVariantMap map;
    QStringList ll =  settings.allKeys();

    for(int i = 0;i< ll.length();i++)
    {
        QVariant value = settings.value(ll[i], "xxx");
        map[ll[i]] = value.toString();
    }
    return map;
}

uint HMUtils::byteToUint(const QByteArray &a, int len)
{
    int i = 0;
    uint sum = 0;

    for(i = 0;i<len;i++)
    {
        char c = 0;
        c = a.at(i);
        c = c << (i*8);
        sum = sum | c;
    }

    return sum;
}

int HMUtils::strHex2Int(const QString &num)
{
    Q_UNUSED(num);
    QByteArray publishplotocal;
    QString tmp = "";
    tmp = num.mid(2);
    publishplotocal = tmp.toLatin1();
    int n = publishplotocal.toInt(NULL, 16);
    return  n;
}

uint HMUtils::byteToUintBig(const QByteArray &a)
{
    //    int i = 0;
    uint sum = 0;

    //    len = a.length();

    //    for(i = 0;i<len;i++)
    //    {
    //        sum <<= 8;
    //        sum |= ((uint)a.at(i) & 0xFF);
    //    }

    ((char*)&sum)[0] = a.at(3);
    ((char*)&sum)[1] = a.at(2);
    ((char*)&sum)[2] = a.at(1);
    ((char*)&sum)[3] = a.at(0);

    return sum;
}


/**
  toLocal8Bit()和toUtf8() 在string包含中文或者特殊符号ubuntn下会转为3个byte
  GBK在win和Ubuntu下正常
 * @brief HMUtils::stringToArrayByGbk
 * @param str
 * @return
 */
QByteArray HMUtils::stringToArrayByGbk(const QString &str)
{
    QTextCodec *tc = QTextCodec::codecForName("GBK");
    QByteArray ba = tc->fromUnicode(str);
    return ba;
}


QString HMUtils::getMd5(const QString &originalData)
{
    QByteArray hashData = QCryptographicHash::hash(originalData.toUtf8(), QCryptographicHash::Md5);
    QString md5Hash = QString(hashData.toHex());
//    qDebug() << md5Hash.length()/2 << endl;
    return md5Hash;
}

QString HMUtils::getBase64(const QString &originalData)
{
    QByteArray byteArray = originalData.toUtf8();
    QString base64Encoded = byteArray.toBase64();
//    qDebug() << "Base64 Encoded: " << base64Encoded;
    return base64Encoded;
}

