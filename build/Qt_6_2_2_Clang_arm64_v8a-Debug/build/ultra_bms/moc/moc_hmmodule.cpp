/****************************************************************************
** Meta object code from reading C++ file 'hmmodule.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.2.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../../../hmmodule.h"
#include <QtGui/qtextcursor.h>
#include <QScreen>
#include <QtNetwork/QSslPreSharedKeyAuthenticator>
#include <QtNetwork/QSslError>
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'hmmodule.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.2.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_CHMModule_t {
    const uint offsetsAndSize[22];
    char stringdata0[87];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(offsetof(qt_meta_stringdata_CHMModule_t, stringdata0) + ofs), len 
static const qt_meta_stringdata_CHMModule_t qt_meta_stringdata_CHMModule = {
    {
QT_MOC_LITERAL(0, 9), // "CHMModule"
QT_MOC_LITERAL(10, 4), // "test"
QT_MOC_LITERAL(15, 0), // ""
QT_MOC_LITERAL(16, 12), // "QVariantMap&"
QT_MOC_LITERAL(29, 10), // "parameters"
QT_MOC_LITERAL(40, 9), // "QVariant&"
QT_MOC_LITERAL(50, 6), // "result"
QT_MOC_LITERAL(57, 10), // "playVoices"
QT_MOC_LITERAL(68, 4), // "path"
QT_MOC_LITERAL(73, 9), // "parseCode"
QT_MOC_LITERAL(83, 3) // "img"

    },
    "CHMModule\0test\0\0QVariantMap&\0parameters\0"
    "QVariant&\0result\0playVoices\0path\0"
    "parseCode\0img"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_CHMModule[] = {

 // content:
      10,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       1,    2,   32,    2, 0x0a,    1 /* Public */,
       7,    1,   37,    2, 0x0a,    4 /* Public */,
       9,    1,   40,    2, 0x0a,    6 /* Public */,

 // slots: parameters
    QMetaType::Void, 0x80000000 | 3, 0x80000000 | 5,    4,    6,
    QMetaType::Void, QMetaType::QString,    8,
    QMetaType::Void, QMetaType::QImage,   10,

       0        // eod
};

void CHMModule::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<CHMModule *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->test((*reinterpret_cast< QVariantMap(*)>(_a[1])),(*reinterpret_cast< QVariant(*)>(_a[2]))); break;
        case 1: _t->playVoices((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 2: _t->parseCode((*reinterpret_cast< const QImage(*)>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObject CHMModule::staticMetaObject = { {
    QMetaObject::SuperData::link<CHMModuleBasics::staticMetaObject>(),
    qt_meta_stringdata_CHMModule.offsetsAndSize,
    qt_meta_data_CHMModule,
    qt_static_metacall,
    nullptr,
qt_incomplete_metaTypeArray<qt_meta_stringdata_CHMModule_t
, QtPrivate::TypeAndForceComplete<CHMModule, std::true_type>
, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<QVariantMap &, std::false_type>, QtPrivate::TypeAndForceComplete<QVariant &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QImage &, std::false_type>


>,
    nullptr
} };


const QMetaObject *CHMModule::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *CHMModule::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CHMModule.stringdata0))
        return static_cast<void*>(this);
    return CHMModuleBasics::qt_metacast(_clname);
}

int CHMModule::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = CHMModuleBasics::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 3;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
