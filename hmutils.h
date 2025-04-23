#ifndef HMUTILS_H
#define HMUTILS_H

#include <QObject>
#include <QMap>
#include <QVariant>
#include "hmlog.h"
#include <QDateTime>
#include <QDebug>

#define ABS_PATH  "../"


#define USERES  0


class HMUtils : public QObject
{
	Q_OBJECT
public:
	explicit HMUtils(QObject *parent = 0);

signals:

public slots:

public:
    // 2022-01-06  zhaoshengli 修改不使用 参数：name，使用可执行程序的名字
    static HMLog& log(const QString &name = "hmRealView.log");
    static void logChangeDay();
    static QByteArray  uintToByte(uint number);
    static QByteArray  uintToByteBig(uint number);
    static QByteArray  ushortToByte(ushort number);
    static QByteArray  ushortToByte_1(ushort number);
    static QByteArray  ushortToByteBig(ushort number);
    static QByteArray  int3ToByte(uint number);

    static uint byteArrayToUint(const QByteArray& a);
    static int byteArrayToInt(const QByteArray& a);
    static uint byteArrayToUint4Byte(const QByteArray& a);
    static int byteArrayToInt_3(const QByteArray& a);
    static int byteArrayToInt_4(const QByteArray& a);
    static int byteArrayToInt_2(const QByteArray& a);

    static ushort byteToUshort(const QByteArray & byte);
    static ushort byteToUshortBig(const QByteArray &byte);
    static uchar calcXorSum(const QByteArray& byte);

    //将 1970 1 1 至time转换成秒数
    static uint dateTimeToSec(QDateTime & time);
    static QDateTime secToDateTime(uint sec);
    static QByteArray overturnArray(const QByteArray& bytes);
    static QByteArray stringToArrray(const QString &str);

    /**
         * @brief decToBCD 1字节的十进制转换为bcd码
         * @param temp
         * @return
         */
    static uchar decToBCD(uchar temp);

    static uchar bcdToDec(uchar n);

    static QString byteArrayToString(QByteArray array);

    static
	QVariant
	settingValue(
			const QString &name,
			const QString &group,
			const QVariant &defaultValue = QVariant(),
            const QString &filename = "r_bom.ini"
			);

	static
	void
	setSettingValue(
			const QVariant &value,
			const QString &name,
			const QString &group,
            const QString &filename = "r_bom.ini"
			);
    static
    QVariantMap
    allKeys();

    static
    QVariantMap
    allKeys(const QString &group, const QString &filename = "r_bom.ini");


    static uint byteToUint(const QByteArray &a,int len);
    static int  strHex2Int(const QString &num);

    static uint byteToUintBig(const QByteArray &a);
    static QByteArray stringToArrayByGbk(const QString &str);

    static QString getMd5(const QString& originalData);
    static QString getBase64(const QString& originalData);

private:
	static QMap<QString, HMLog*> logs;
};

#endif // HMUTILS_H
