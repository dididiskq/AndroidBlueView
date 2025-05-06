#include "hmviewcontext.h"
#include <QDebug>
#include "hmutils.h"
#include<QImage>
#include<QVideoFrame>
#include <QZXing.h>
#include<QPainter>
#include<QOpenGLContext>
#include<QOffscreenSurface>
#include <QRegularExpression>
HMViewContext::HMViewContext(QObject *parent) : QObject(parent)
{

}


QVariantMap &HMViewContext::fields()
{
	return selfFields;
}

void HMViewContext::setFields(const QVariantMap &fields)
{
	if (fields == selfFields)
		return;

	selfFields = fields;

    emit fieldsChanged();
}


void HMViewContext::setFieldValue(const QString &name, const QVariant &value)
{
    if (selfFields.value(name) == value)
    {
        return;
    }
	selfFields[name] = value;
	emit fieldsChanged();
}

QVariant HMViewContext::fieldValue(const QString &name)
{
    return selfFields.value(name);
}

QVariant HMViewContext::invoke(const QString &method, const QVariant &parameters)
{

	QVariant result;

	emit viewInvoke(method, parameters, result);


    return result;
}

QString HMViewContext::byteToString(const QVariant &a)
{
    QByteArray array = a.toByteArray();
    return QString(array.toHex()).toUpper();
}

QString HMViewContext::timeFormatYYYY_MM_DD(const QString &str)
{
    QString strea = str;
    strea = strea.insert(4,"-").insert(7,"-");

    return strea;
}

QString HMViewContext::timeFormatMM_DD_hh_mm(const QString &str)
{
    QString strea = str;
    strea = strea.insert(2,"-").insert(5," ").insert(8,":").insert(11,"");
    return strea;
}

QString HMViewContext::getImageFrmeBase64()
{ 
    return base64Image;
}

void HMViewContext::setBase64Image(const QString &m)
{
    base64Image = m;
}

void HMViewContext::log(const QString msg)
{
    HMUtils::log() << "console :" << msg <<HMLog::endl;
}

void HMViewContext::keyPressed(QObject *tf, Qt::Key k)
{
    QKeyEvent keyPressEvent = QKeyEvent(QEvent::Type::KeyPress, k, Qt::NoModifier, QKeySequence(k).toString());
    QCoreApplication::sendEvent(tf, &keyPressEvent);
//    emit mySignal("hellow from c++");
}

QString HMViewContext::getRfid()
{
    return rfid;
}

void HMViewContext::setRfid(const QString &m)
{
    rfid = m;
}

void HMViewContext::setVideoSink(QVideoSink *sink)
{
    if (m_videoSink != sink) {
        m_videoSink = sink;
        connect(m_videoSink, &QVideoSink::videoFrameChanged,
                this, &HMViewContext::processFrame, Qt::QueuedConnection);
    }
}


void HMViewContext::processFrame(const QVideoFrame &frame)
{


}
void HMViewContext::onFrameGrabbed(const QImage &img)
{
    if (img.isNull()) return;
    QZXing decoder;
    //QR Code二维码
    decoder.setDecoder(QZXing::DecoderFormat_QR_CODE);

    decoder.setSourceFilterType(QZXing::SourceFilter_ImageNormal);
    decoder.setTryHarderBehaviour(QZXing::TryHarderBehaviour_ThoroughScanning |
                                  QZXing::TryHarderBehaviour_Rotate);
    QString info = decoder.decodeImage(img);
    if(info == "")
    {

    }
    else
    {
        QString cleaned = info.trimmed();

        // 定义 MAC 地址正则表达式（兼容大小写和不同分隔符）
        QRegularExpression regex(
            "^"                          // 字符串开始
            "([0-9A-Fa-f]{2}"           // 第一个十六进制字节
            "([:-])){5}"                // 分隔符重复5次（冒号或短横线）
            "[0-9A-Fa-f]{2}"            // 最后一个字节
            "$"                         // 字符串结束
            );
        regex.setPatternOptions(QRegularExpression::CaseInsensitiveOption);

        // 执行正则匹配
        QRegularExpressionMatch match = regex.match(cleaned);

        // 验证结果有效性
        bool res = match.hasMatch() &&
                   cleaned.size() == 17 &&  // 标准长度校验（6字节×2 + 5分隔符）
                   !cleaned.contains("  ");  // 排除连续分隔符的情况
        if(res)
        {
            emit codeImageReady(info);
        }

    }
}
