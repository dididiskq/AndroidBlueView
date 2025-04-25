/****************************************************************************
** Meta object code from reading C++ file 'hmviewcommand.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.2.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../../../hmviewcommand.h"
#include <QtGui/qtextcursor.h>
#include <QScreen>
#include <QtNetwork/QSslPreSharedKeyAuthenticator>
#include <QtNetwork/QSslError>
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'hmviewcommand.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.2.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_CHMViewCommand_t {
    const uint offsetsAndSize[34];
    char stringdata0[163];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(offsetof(qt_meta_stringdata_CHMViewCommand_t, stringdata0) + ofs), len 
static const qt_meta_stringdata_CHMViewCommand_t qt_meta_stringdata_CHMViewCommand = {
    {
QT_MOC_LITERAL(0, 14), // "CHMViewCommand"
QT_MOC_LITERAL(15, 9), // "playVoice"
QT_MOC_LITERAL(25, 0), // ""
QT_MOC_LITERAL(26, 4), // "path"
QT_MOC_LITERAL(31, 8), // "startBle"
QT_MOC_LITERAL(40, 12), // "sendBlueSlot"
QT_MOC_LITERAL(53, 4), // "type"
QT_MOC_LITERAL(58, 15), // "connectBlueSlot"
QT_MOC_LITERAL(74, 4), // "addr"
QT_MOC_LITERAL(79, 13), // "writeBlueSlot"
QT_MOC_LITERAL(93, 2), // "op"
QT_MOC_LITERAL(96, 16), // "protectMsgSignal"
QT_MOC_LITERAL(113, 13), // "parseCodeSlot"
QT_MOC_LITERAL(127, 3), // "img"
QT_MOC_LITERAL(131, 11), // "cameraOpera"
QT_MOC_LITERAL(143, 12), // "render_image"
QT_MOC_LITERAL(156, 6) // "base64"

    },
    "CHMViewCommand\0playVoice\0\0path\0startBle\0"
    "sendBlueSlot\0type\0connectBlueSlot\0"
    "addr\0writeBlueSlot\0op\0protectMsgSignal\0"
    "parseCodeSlot\0img\0cameraOpera\0"
    "render_image\0base64"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_CHMViewCommand[] = {

 // content:
      10,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       8,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   68,    2, 0x06,    1 /* Public */,
       4,    0,   71,    2, 0x06,    3 /* Public */,
       5,    1,   72,    2, 0x06,    4 /* Public */,
       7,    1,   75,    2, 0x06,    6 /* Public */,
       9,    1,   78,    2, 0x06,    8 /* Public */,
      11,    1,   81,    2, 0x06,   10 /* Public */,
      12,    1,   84,    2, 0x06,   12 /* Public */,
      14,    1,   87,    2, 0x06,   14 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
      15,    1,   90,    2, 0x0a,   16 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,    6,
    QMetaType::Void, QMetaType::QString,    8,
    QMetaType::Void, QMetaType::QVariantMap,   10,
    QMetaType::Void, QMetaType::Int,    6,
    QMetaType::Void, QMetaType::QImage,   13,
    QMetaType::Void, QMetaType::Int,    6,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,   16,

       0        // eod
};

void CHMViewCommand::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<CHMViewCommand *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->playVoice((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: _t->startBle(); break;
        case 2: _t->sendBlueSlot((*reinterpret_cast< const int(*)>(_a[1]))); break;
        case 3: _t->connectBlueSlot((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 4: _t->writeBlueSlot((*reinterpret_cast< const QVariantMap(*)>(_a[1]))); break;
        case 5: _t->protectMsgSignal((*reinterpret_cast< const int(*)>(_a[1]))); break;
        case 6: _t->parseCodeSlot((*reinterpret_cast< const QImage(*)>(_a[1]))); break;
        case 7: _t->cameraOpera((*reinterpret_cast< const int(*)>(_a[1]))); break;
        case 8: _t->render_image((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (CHMViewCommand::*)(const QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CHMViewCommand::playVoice)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (CHMViewCommand::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CHMViewCommand::startBle)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (CHMViewCommand::*)(const int );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CHMViewCommand::sendBlueSlot)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (CHMViewCommand::*)(const QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CHMViewCommand::connectBlueSlot)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (CHMViewCommand::*)(const QVariantMap & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CHMViewCommand::writeBlueSlot)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (CHMViewCommand::*)(const int );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CHMViewCommand::protectMsgSignal)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (CHMViewCommand::*)(const QImage & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CHMViewCommand::parseCodeSlot)) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (CHMViewCommand::*)(const int );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&CHMViewCommand::cameraOpera)) {
                *result = 7;
                return;
            }
        }
    }
}

const QMetaObject CHMViewCommand::staticMetaObject = { {
    QMetaObject::SuperData::link<CHMCommand::staticMetaObject>(),
    qt_meta_stringdata_CHMViewCommand.offsetsAndSize,
    qt_meta_data_CHMViewCommand,
    qt_static_metacall,
    nullptr,
qt_incomplete_metaTypeArray<qt_meta_stringdata_CHMViewCommand_t
, QtPrivate::TypeAndForceComplete<CHMViewCommand, std::true_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const int, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QVariantMap &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const int, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QImage &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const int, std::false_type>
, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>


>,
    nullptr
} };


const QMetaObject *CHMViewCommand::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *CHMViewCommand::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CHMViewCommand.stringdata0))
        return static_cast<void*>(this);
    return CHMCommand::qt_metacast(_clname);
}

int CHMViewCommand::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = CHMCommand::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 9)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 9;
    }
    return _id;
}

// SIGNAL 0
void CHMViewCommand::playVoice(const QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void CHMViewCommand::startBle()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void CHMViewCommand::sendBlueSlot(const int _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void CHMViewCommand::connectBlueSlot(const QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void CHMViewCommand::writeBlueSlot(const QVariantMap & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void CHMViewCommand::protectMsgSignal(const int _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void CHMViewCommand::parseCodeSlot(const QImage & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void CHMViewCommand::cameraOpera(const int _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
