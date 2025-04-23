#ifndef HMVIEW_H
#define HMVIEW_H
#include <QObject>
#include <QDebug>
#include <QDateTime>
#include <QThread>
#include <QtQuick>
#include "hmviewcontext.h"
// 定义一个类
class CHMView: public QObject
{
    Q_OBJECT
public:
    explicit CHMView(QObject *parent = 0);
    ~CHMView();
    void setName(const QString& name);
    QQuickView* view(const QString &objectName = QString());
    HMViewContext *context(const QString &viewName);
    bool initContext(HMViewContext *context);
    bool initViews();                   // 初始化界面
    bool closeView();

public slots:
    void onViewInvoke(const QString &method, const QVariant &parameters, QVariant &result);

signals:
    void updateCommand(QVariantMap& v, QVariant &result);

private:
    void init();

public:

private:
    QString name;
    HMViewContext viewContext;
    QMap<QString, QQuickView*> views;
    QMap<QString, HMViewContext*> contexts;
};

#endif // HMVIEW_H
