
QT += gui qml quick core bluetooth multimedia svg
greaterThan(QT_MAJOR_VERSION, 5): QT += core5compat
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = ultra_bms
TEMPLATE = app

CONFIG += resources_big
CONFIG += C++17
CONFIG += embed_translations




# QZXing 配置
android {
    # 根据构建类型选择库
    CONFIG(debug, debug|release) {
        ANDROID_EXTRA_LIBS += $$PWD/QZXing/lib/arm64-v8a/libQZXingd.so
        LIBS += -L$$PWD/QZXing/lib/arm64-v8a -lQZXingd
    } else {
        ANDROID_EXTRA_LIBS += $$PWD/QZXing/lib/arm64-v8a/libQZXing.so
        LIBS += -L$$PWD/QZXing/lib/arm64-v8a -lQZXing
    }
}

# 指定Android资源目录
ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

INCLUDEPATH += $$PWD/QZXing/include
DEPENDPATH += $$PWD/QZXing/include

CONFIG += qzxing_qml
CONFIG += qzxing_multimedia


# 输出目录
OBJECTS_DIR = ./build/$$TARGET/obj
MOC_DIR     = ./build/$$TARGET/moc
RCC_DIR     = ./build/$$TARGET/rcc
UI_DIR      = ./build/$$TARGET/ui
DESTDIR     = ../

# 源文件和头文件
SOURCES += \
    BMSProtocol.cpp \
    BmsController.cpp \
    CameraCapture.cpp \
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
    CameraCapture.h \
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
    views/HMTest.qml \
    views/InitView.qml \
    views/component/AlarmMsgPage.qml \
    views/component/BatteryArc.qml \
    views/component/BlueList.qml \
    views/component/BmsControl.qml \
    views/component/CamerView.qml \
    views/component/CameraImg.qml \
    views/component/CellMessage.qml \
    views/component/DControl.qml \
    views/component/DMessage.qml \
    views/component/DParam.qml \
    views/component/DParam1.qml \
    views/component/DParam2.qml \
    views/component/DParam3.qml \
    views/component/DParam4.qml \
    views/component/DParam5.qml \
    views/component/DParam6.qml \
    views/component/DRealTime.qml \
    views/component/DevicePage.qml \
    views/component/HMCNCulture.qml \
    views/component/InfoGrid.qml \
    views/component/InfoGridLang.qml \
    views/component/InfoGridOne.qml \
    views/component/LoadingIndicator.qml \
    views/component/MainPage.qml \
    views/component/MinePage.qml \
    views/component/OperaBoard.qml \
    views/component/ParameterItem.qml \
    views/component/ParameterPage.qml \
    views/component/STabButton.qml \
    views/component/TextFieldTemplate.qml \
    views/js/HMJs.qml


RESOURCES += \
    resources.qrc
