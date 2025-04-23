#ifndef HMREGISTER_H
#define HMREGISTER_H
#include <QObject>
#include <QVariantMap>

class CHMRegister: public QObject  // 定义一个类
{
    Q_OBJECT
public:
    explicit CHMRegister(QObject *parent = 0);
    ~CHMRegister();
    /**
     * @brief setRegister
     * @param name 注册对象名称 单个
     * @param obj 注册对象
     */
    void setRegister(const QString &name, QObject*obj);
    /**
     * @brief setRegister
     * @param list 注册对象名称 列表
     * @param obj 注册对象
     */
    void setRegister(QStringList &list, QObject*obj);
    QObject* isHasObj(const QString &name);

public:
    QMap<QString, QObject*> selfRegister;

};

#endif // HMREGISTER_H
