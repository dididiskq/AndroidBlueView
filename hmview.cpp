#include <QString>
#include <QVariant>
#include <QDir>
#include <QQuickView>
#include <QQuickItem>
#include "hmview.h"
#include "hmlog.h"
#include "hmutils.h"

CHMView::CHMView(QObject *parent) : QObject(parent)
{
    init();
}

CHMView::~CHMView()
{

}

void CHMView::setName(const QString &name)
{
    this->name = name;
}

QQuickView* CHMView::view(const QString &objectName)
{
    QQuickView *view = NULL;
    if (objectName.isEmpty()) // 默认返回第一个
    {
        Q_ASSERT(!views.isEmpty());
        view = views.first();
        return view;
    }
    else
    {
        if(!views.contains(objectName))
        {
            view = new QQuickView;
            views[objectName] = view;
            return view;
        }
    }

    view = views.value(objectName, NULL);

    if (view == NULL)
    {
        view = new QQuickView;
        views[objectName] = view;
    }

    return view;
}

HMViewContext *CHMView::context(const QString &viewName)
{
    HMViewContext* context = NULL;

    if (viewName.isEmpty())
    {
        context = contexts.first();
        return context;
    }

    context = contexts.value(viewName, NULL);

    if (context == NULL)
    {
        context = new HMViewContext;
        contexts[viewName] = context;

        initContext(context);
    }

    return context;
}

void CHMView::onViewInvoke(const QString &method, const QVariant &parameters, QVariant &result)
{
    Q_UNUSED(method);
    Q_UNUSED(parameters);
    Q_UNUSED(result);

    QVariantMap values = parameters.toMap();
    values["name"] = this->name;
    values["command"] = method;
    emit this->updateCommand(values, result);

}

bool CHMView::initContext(HMViewContext *context)
{
    Q_ASSERT(context != NULL);
    context->setFieldValue("test", "hello word!");

    return true;
}

void CHMView::init()
{

}

bool CHMView::initViews()
{
    int count = 1;
    HMUtils::log() << "界面数量:" << count << HMLog::endl;;
    for (int i = 0; i < 1; i++)
    {
        QString group = QString("HMView.%1").arg(i);
        QString name = "HMStmView";
        QString source = "qrc:/views/HMStmView.qml";


        QString qrc = source;
        QQuickView *v = view(name);
        HMViewContext *c = context(name);
        Q_ASSERT(v != NULL);
        Q_ASSERT(c != NULL);


        connect(c, SIGNAL(viewInvoke(QString,QVariant,QVariant&)), SLOT(onViewInvoke(QString,QVariant,QVariant&)));


        v->setResizeMode(QQuickView::SizeRootObjectToView);
        v->rootContext()->setContextProperty("HMStmViewContext", c);

        v->setSource(qrc);
        v->setObjectName(name);
        // v->setFlags(Qt::MaximizeUsingFullscreenGeometryHint|v->flags());
v->setFlags(v->flags() | Qt::Window | Qt::FramelessWindowHint | Qt::MaximizeUsingFullscreenGeometryHint);
        v->setColor(Qt::transparent);
        v->show();
    }

    return true;
}



