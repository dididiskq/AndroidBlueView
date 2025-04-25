/****************************************************************************
** Meta object code from reading C++ file 'BmsController.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.2.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../../../BmsController.h"
#include <QtGui/qtextcursor.h>
#include <QScreen>
#include <QtNetwork/QSslPreSharedKeyAuthenticator>
#include <QtNetwork/QSslError>
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'BmsController.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.2.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_BmsController_t {
    const uint offsetsAndSize[68];
    char stringdata0[530];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(offsetof(qt_meta_stringdata_BmsController_t, stringdata0) + ofs), len 
static const qt_meta_stringdata_BmsController_t qt_meta_stringdata_BmsController = {
    {
QT_MOC_LITERAL(0, 13), // "BmsController"
QT_MOC_LITERAL(14, 9), // "startBlue"
QT_MOC_LITERAL(24, 0), // ""
QT_MOC_LITERAL(25, 23), // "writeOperationCompleted"
QT_MOC_LITERAL(49, 7), // "success"
QT_MOC_LITERAL(57, 5), // "error"
QT_MOC_LITERAL(63, 14), // "onWriteTimeout"
QT_MOC_LITERAL(78, 11), // "viewMessage"
QT_MOC_LITERAL(90, 4), // "type"
QT_MOC_LITERAL(95, 7), // "SendMsg"
QT_MOC_LITERAL(103, 11), // "startSearch"
QT_MOC_LITERAL(115, 19), // "onDescriptorWritten"
QT_MOC_LITERAL(135, 20), // "QLowEnergyDescriptor"
QT_MOC_LITERAL(156, 10), // "descriptor"
QT_MOC_LITERAL(167, 5), // "value"
QT_MOC_LITERAL(173, 10), // "findFinish"
QT_MOC_LITERAL(184, 25), // "addBlueToothDevicesToList"
QT_MOC_LITERAL(210, 20), // "QBluetoothDeviceInfo"
QT_MOC_LITERAL(231, 17), // "serviceDiscovered"
QT_MOC_LITERAL(249, 14), // "QBluetoothUuid"
QT_MOC_LITERAL(264, 11), // "serviceUuid"
QT_MOC_LITERAL(276, 15), // "serviceScanDone"
QT_MOC_LITERAL(292, 19), // "serviceStateChanged"
QT_MOC_LITERAL(312, 31), // "QLowEnergyService::ServiceState"
QT_MOC_LITERAL(344, 1), // "s"
QT_MOC_LITERAL(346, 29), // "BleServiceCharacteristicWrite"
QT_MOC_LITERAL(376, 24), // "QLowEnergyCharacteristic"
QT_MOC_LITERAL(401, 1), // "c"
QT_MOC_LITERAL(403, 31), // "BleServiceCharacteristicChanged"
QT_MOC_LITERAL(435, 28), // "BleServiceCharacteristicRead"
QT_MOC_LITERAL(464, 14), // "sendMsgByQueue"
QT_MOC_LITERAL(479, 17), // "getProtectMsgSlot"
QT_MOC_LITERAL(497, 15), // "forceDisconnect"
QT_MOC_LITERAL(513, 16) // "cleanupResources"

    },
    "BmsController\0startBlue\0\0"
    "writeOperationCompleted\0success\0error\0"
    "onWriteTimeout\0viewMessage\0type\0SendMsg\0"
    "startSearch\0onDescriptorWritten\0"
    "QLowEnergyDescriptor\0descriptor\0value\0"
    "findFinish\0addBlueToothDevicesToList\0"
    "QBluetoothDeviceInfo\0serviceDiscovered\0"
    "QBluetoothUuid\0serviceUuid\0serviceScanDone\0"
    "serviceStateChanged\0QLowEnergyService::ServiceState\0"
    "s\0BleServiceCharacteristicWrite\0"
    "QLowEnergyCharacteristic\0c\0"
    "BleServiceCharacteristicChanged\0"
    "BleServiceCharacteristicRead\0"
    "sendMsgByQueue\0getProtectMsgSlot\0"
    "forceDisconnect\0cleanupResources"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_BmsController[] = {

 // content:
      10,       // revision
       0,       // classname
       0,    0, // classinfo
      19,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,  128,    2, 0x06,    1 /* Public */,
       3,    2,  129,    2, 0x06,    2 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       6,    0,  134,    2, 0x0a,    5 /* Public */,
       7,    1,  135,    2, 0x0a,    6 /* Public */,
       9,    1,  138,    2, 0x0a,    8 /* Public */,
      10,    0,  141,    2, 0x0a,   10 /* Public */,
      11,    2,  142,    2, 0x0a,   11 /* Public */,
      15,    0,  147,    2, 0x0a,   14 /* Public */,
      16,    1,  148,    2, 0x0a,   15 /* Public */,
      18,    1,  151,    2, 0x0a,   17 /* Public */,
      21,    0,  154,    2, 0x0a,   19 /* Public */,
      22,    1,  155,    2, 0x0a,   20 /* Public */,
      25,    2,  158,    2, 0x0a,   22 /* Public */,
      28,    2,  163,    2, 0x0a,   25 /* Public */,
      29,    2,  168,    2, 0x0a,   28 /* Public */,
      30,    0,  173,    2, 0x0a,   31 /* Public */,
      31,    1,  174,    2, 0x0a,   32 /* Public */,
      32,    0,  177,    2, 0x0a,   34 /* Public */,
      33,    0,  178,    2, 0x0a,   35 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool, QMetaType::QString,    4,    5,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,    8,
    QMetaType::Void, QMetaType::QByteArray,    2,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 12, QMetaType::QByteArray,   13,   14,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 17,    2,
    QMetaType::Void, 0x80000000 | 19,   20,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 23,   24,
    QMetaType::Void, 0x80000000 | 26, QMetaType::QByteArray,   27,   14,
    QMetaType::Void, 0x80000000 | 26, QMetaType::QByteArray,   27,   14,
    QMetaType::Void, 0x80000000 | 26, QMetaType::QByteArray,   27,   14,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,    8,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void BmsController::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<BmsController *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->startBlue(); break;
        case 1: _t->writeOperationCompleted((*reinterpret_cast< bool(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 2: _t->onWriteTimeout(); break;
        case 3: _t->viewMessage((*reinterpret_cast< const int(*)>(_a[1]))); break;
        case 4: _t->SendMsg((*reinterpret_cast< const QByteArray(*)>(_a[1]))); break;
        case 5: _t->startSearch(); break;
        case 6: _t->onDescriptorWritten((*reinterpret_cast< const QLowEnergyDescriptor(*)>(_a[1])),(*reinterpret_cast< const QByteArray(*)>(_a[2]))); break;
        case 7: _t->findFinish(); break;
        case 8: _t->addBlueToothDevicesToList((*reinterpret_cast< QBluetoothDeviceInfo(*)>(_a[1]))); break;
        case 9: _t->serviceDiscovered((*reinterpret_cast< const QBluetoothUuid(*)>(_a[1]))); break;
        case 10: _t->serviceScanDone(); break;
        case 11: _t->serviceStateChanged((*reinterpret_cast< QLowEnergyService::ServiceState(*)>(_a[1]))); break;
        case 12: _t->BleServiceCharacteristicWrite((*reinterpret_cast< const QLowEnergyCharacteristic(*)>(_a[1])),(*reinterpret_cast< const QByteArray(*)>(_a[2]))); break;
        case 13: _t->BleServiceCharacteristicChanged((*reinterpret_cast< const QLowEnergyCharacteristic(*)>(_a[1])),(*reinterpret_cast< const QByteArray(*)>(_a[2]))); break;
        case 14: _t->BleServiceCharacteristicRead((*reinterpret_cast< const QLowEnergyCharacteristic(*)>(_a[1])),(*reinterpret_cast< const QByteArray(*)>(_a[2]))); break;
        case 15: _t->sendMsgByQueue(); break;
        case 16: _t->getProtectMsgSlot((*reinterpret_cast< const int(*)>(_a[1]))); break;
        case 17: _t->forceDisconnect(); break;
        case 18: _t->cleanupResources(); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
        case 6:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QLowEnergyDescriptor >(); break;
            }
            break;
        case 8:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QBluetoothDeviceInfo >(); break;
            }
            break;
        case 9:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QBluetoothUuid >(); break;
            }
            break;
        case 11:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QLowEnergyService::ServiceState >(); break;
            }
            break;
        case 12:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QLowEnergyCharacteristic >(); break;
            }
            break;
        case 13:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QLowEnergyCharacteristic >(); break;
            }
            break;
        case 14:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType(); break;
            case 0:
                *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType::fromType< QLowEnergyCharacteristic >(); break;
            }
            break;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (BmsController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&BmsController::startBlue)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (BmsController::*)(bool , const QString & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&BmsController::writeOperationCompleted)) {
                *result = 1;
                return;
            }
        }
    }
}

const QMetaObject BmsController::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_BmsController.offsetsAndSize,
    qt_meta_data_BmsController,
    qt_static_metacall,
    nullptr,
qt_incomplete_metaTypeArray<qt_meta_stringdata_BmsController_t
, QtPrivate::TypeAndForceComplete<BmsController, std::true_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<bool, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>
, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const int, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QByteArray &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QLowEnergyDescriptor &, std::false_type>, QtPrivate::TypeAndForceComplete<const QByteArray &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<QBluetoothDeviceInfo, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QBluetoothUuid &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<QLowEnergyService::ServiceState, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QLowEnergyCharacteristic &, std::false_type>, QtPrivate::TypeAndForceComplete<const QByteArray &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QLowEnergyCharacteristic &, std::false_type>, QtPrivate::TypeAndForceComplete<const QByteArray &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QLowEnergyCharacteristic &, std::false_type>, QtPrivate::TypeAndForceComplete<const QByteArray &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const int, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>


>,
    nullptr
} };


const QMetaObject *BmsController::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *BmsController::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_BmsController.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int BmsController::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 19)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 19;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 19)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 19;
    }
    return _id;
}

// SIGNAL 0
void BmsController::startBlue()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void BmsController::writeOperationCompleted(bool _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
