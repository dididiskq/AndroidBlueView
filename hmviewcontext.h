#ifndef HMVIEWCONTEXT_H
#define HMVIEWCONTEXT_H

#include <QObject>
#include <QVariantMap>
#include <QKeyEvent>
#include <QCoreApplication>
#include<QVideoSink>
class HMViewContext : public QObject
{
    Q_OBJECT
public:
    explicit HMViewContext(QObject *parent = 0);

    Q_PROPERTY(QVariantMap fields READ fields WRITE setFields NOTIFY fieldsChanged)
public:
    QVariantMap &fields();
    void setFields(const QVariantMap &fields);

    Q_INVOKABLE QVariant fieldValue(const QString &name);
    Q_INVOKABLE void setFieldValue(const QString &name, const QVariant &value);

    Q_INVOKABLE QVariant invoke(const QString &method, const QVariant &parameters);

    Q_INVOKABLE QString byteToString(const QVariant &a);
    Q_INVOKABLE QString timeFormatYYYY_MM_DD(const QString &str);
    Q_INVOKABLE QString timeFormatMM_DD_hh_mm(const QString &str);

    Q_INVOKABLE QString  getImageFrmeBase64();
    Q_INVOKABLE void setBase64Image(const QString & m);

    Q_INVOKABLE void log(const QString msg);

    Q_INVOKABLE void keyPressed(QObject* tf, Qt::Key k); //调用键盘按键
    Q_INVOKABLE QString  getRfid();
    Q_INVOKABLE void setRfid(const QString & m);
    Q_INVOKABLE void switchLanguage(const QString &language);

    Q_PROPERTY(QVideoSink *videoSink WRITE setVideoSink);
    void setVideoSink(QVideoSink* sink);
signals:
    void fieldsChanged();
    void viewInvoke(const QString &method, const QVariant &parameters, QVariant &result);

    void mySignal(const QString &message);
    void codeImageReady(const QString &message, const int& type);

    void sinkChanged();
    void languageChangeRequested(const QString &language);

public slots:
    void processFrame(const QVideoFrame &frame);
     void onFrameGrabbed(const QImage &img);  // 只声明
private:

QVideoSink* m_videoSink  = nullptr;
    QVariantMap selfFields;
    QString base64Image = "";
    QString rfid = "";
};

#endif // HMVIEWCONTEXT_H
