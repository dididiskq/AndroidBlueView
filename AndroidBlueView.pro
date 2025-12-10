
QT += gui qml quick core bluetooth svg multimedia

#
greaterThan(QT_MAJOR_VERSION, 5): QT += core5compat
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = Ultra_bms
TEMPLATE = app

CONFIG += resources_big
CONFIG += C++17
CONFIG += embed_translations

TRANSLATIONS += \
    ./language/english.ts \
    ./language/chinese.ts



# QZXing
android{
    CONFIG(debug, debug|release){
        ANDROID_EXTRA_LIBS += $$PWD/QZXing/lib/arm64-v8a/libQZXingd.so
        LIBS += -L$$PWD/QZXing/lib/arm64-v8a -lQZXingd
    }else{
        ANDROID_EXTRA_LIBS += $$PWD/QZXing/lib/arm64-v8a/libQZXing.so
        LIBS += -L$$PWD/QZXing/lib/arm64-v8a -lQZXing
    }
}

#  Android
ANDROID_TARGET_SDK_VERSION = 35
ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

INCLUDEPATH += $$PWD/QZXing/include
DEPENDPATH += $$PWD/QZXing/include



OBJECTS_DIR = ./build/$$TARGET/obj
MOC_DIR     = ./build/$$TARGET/moc
RCC_DIR     = ./build/$$TARGET/rcc
UI_DIR      = ./build/$$TARGET/ui
DESTDIR     = ../


SOURCES += \
    BMSProtocol.cpp \
    BmsController.cpp \
    hmcommand.cpp \
    hmlog.cpp \
    hmmodule.cpp \
    hmmodulebasics.cpp \
    hmregister.cpp \
    hmtestthread.cpp \
    hmthread.cpp \
    hmutils.cpp \
    hmview.cpp \
    hmviewcommand.cpp \
    hmviewcontext.cpp \
    main.cpp

HEADERS += \
    BMSProtocol.h \
    BmsController.h \
    hmcommand.h \
    hmlog.h \
    hmmodule.h \
    hmmodulebasics.h \
    hmregister.h \
    hmtestthread.h \
    hmthread.h \
    hmutils.h \
    hmview.h \
    hmviewcommand.h \
    hmviewcontext.h


# 资源文件
DISTFILES += \
    views/HMStmView.qml \
    views/InitView.qml \
    views/InitialWindow.qml \
    views/component/AlarmMsgPage.qml \
    views/component/BatteryArc.qml \
    views/component/BlueList.qml \
    views/component/BmsControl.qml \
    views/component/CamerView.qml \
    views/component/CellMessage.qml \
    views/component/DParam1.qml \
    views/component/DParam2.qml \
    views/component/DParam3.qml \
    views/component/DParam4.qml \
    views/component/DParam5.qml \
    views/component/DParam6.qml \
    views/component/DRealTime.qml \
    views/component/DataConfirmationDialog.qml \
    views/component/DevicePage.qml \
    views/component/FirmwareUpdate.qml \
    views/component/InfoGrid.qml \
    views/component/InfoGridOne.qml \
    views/component/LoadingIndicator.qml \
    views/component/MainPage.qml \
    views/component/MinePage.qml \
    views/component/OperaBoard.qml \
    views/component/ParameterItem.qml \
    views/component/ParameterPage.qml \
    views/component/STabButton.qml \
    views/component/TextFieldTemplate.qml \
    views/component/Ysxy.qml \
    views/js/HMJs.qml


RESOURCES += \
    resources.qrc
