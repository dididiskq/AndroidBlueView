#include "hmviewcontext.h"
#include <QDebug>
#include "hmutils.h"
#include<QImage>
#include<QVideoFrame>
// #include <QZXing.h>
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

void HMViewContext::switchLanguage(const QString &language)
{
    emit languageChangeRequested(language);
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

}
