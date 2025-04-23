#ifndef HMTHREAD_H
#define HMTHREAD_H

#include <QObject>
#include <QString>
#include <QThread>
#include <QVariantList>
#include <QMutex>

class CHMThread : public QThread
{
    Q_OBJECT
public:
    explicit CHMThread( QObject *parent = 0);
    ~CHMThread();
    QVariantList& operations();
    void appendOp(const QVariantMap &operation);
    void start(Priority p = InheritPriority);
    void terminate();
    void quit();
    void stopOverTimer();
    void clearExecuteOperations();
    void operationLock();
    void operationUnlock();
protected:
    void run();
signals:
    void deviceEvent(const QVariantMap &event);
protected:
    bool selfRunning;
    QVariantList selfExecuteOperations;
    QMutex operationMutex;
};

#endif // HMTHREAD_H
