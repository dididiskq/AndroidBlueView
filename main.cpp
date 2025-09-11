#include <QGuiApplication>
#include "hmmodule.h"
// #include <QZXing.h>
#include<QImage>
#include <QQuickWindow>
#include <QJniObject>
#include <QJniEnvironment>
#include <QtCore/qnativeinterface.h>
using namespace QNativeInterface;
static QString pickLangBySystem()
{
    const QLocale sys = QLocale::system();
    // 你的 qm 命名是 "english.qm" / "chinese.qm"
    if (sys.language() == QLocale::Chinese)      return QStringLiteral("chinese");
    // 细分简繁（如果你准备了不同 qm）
    // if (sys.language() == QLocale::Chinese && sys.script() == QLocale::SimplifiedChineseScript) return "zh_CN";
    // if (sys.language() == QLocale::Chinese && sys.script() == QLocale::TraditionalChineseScript) return "zh_TW";
    return QStringLiteral("english");
}
void setImmersiveMode()
{
    //
    QJniObject activity = QJniObject::callStaticObjectMethod(
        "org/qtproject/qt/android/QtNative",
        "activity",
        "()Landroid/app/Activity;"
        );
    if (!activity.isValid())
    {
        qWarning() << "Failed to get Android activity";
        return;
    }

    //
    QJniObject window = activity.callObjectMethod("getWindow", "()Landroid/view/Window;");
    if (!window.isValid())
    {
        qWarning() << "Failed to get window object";
        return;
    }

    //
    window.callMethod<void>("addFlags", "(I)V", 0x80000000); // FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS
    window.callMethod<void>("clearFlags", "(I)V", 0x04000000); // FLAG_TRANSLUCENT_STATUS
     window.callMethod<void>("clearFlags", "(I)V", 0x08000000); //FLAG_TRANSLUCENT_NAVIGATION 6/2

    //
    window.callMethod<void>("setStatusBarColor", "(I)V", 0x00000000);
    window.callMethod<void>("setNavigationBarColor", "(I)V", 0x00000000);


    //
    QJniObject decorView = window.callObjectMethod("getDecorView", "()Landroid/view/View;");
    if (!decorView.isValid())
    {
        qWarning() << "Failed to get decor view";
        return;
    }

    //
    const int sdkVersion = QJniObject::getStaticField<jint>("android/os/Build$VERSION", "SDK_INT");
    if (sdkVersion >= 30)// Android 11 (API 30) 及以上
    {
        QJniObject insetsController = decorView.callObjectMethod(
            "getWindowInsetsController",
            "()Landroid/view/WindowInsetsController;"
            );
        if (insetsController.isValid())
        {

        }
    }
    else
    { // Android 10

        int flags = decorView.callMethod<int>("getSystemUiVisibility", "()I");
        flags |= 0x00000100; // SYSTEM_UI_FLAG_LAYOUT_STABLE
        flags |= 0x00000200; // SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
        flags |= 0x00000400; // SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
        flags |= 0x00000004; // SYSTEM_UI_FLAG_FULLSCREEN
        flags |= 0x00000002; // SYSTEM_UI_FLAG_HIDE_NAVIGATION
        flags |= 0x00001000; // SYSTEM_UI_FLAG_IMMERSIVE_STICKY
        decorView.callMethod<void>("setSystemUiVisibility", "(I)V", flags);
    }
}
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);

    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts );
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGL);
    QGuiApplication a(argc, argv);  // 主线程
    setImmersiveMode();
    QObject::connect(&a, &QCoreApplication::aboutToQuit, []() {
        // 获取上下文并转换为QJniObject
        QJniObject context = QAndroidApplication::context();

        if (context.isValid()) {
            // 使用系统动画方式退出
            context.callMethod<void>("finishAndRemoveTask");
        }
    });

   // CHMModule module;
    QLocale::setDefault(QLocale::system());

    QTranslator tr;
    const QString lang = pickLangBySystem();
    if (tr.load(":/language/" + lang + ".qm")) {
        a.installTranslator(&tr);
    }
    std::unique_ptr<CHMModule> module(new CHMModule());
    if(!module->start())
    {
        return 1;
    }
    QNativeInterface::QAndroidApplication::hideSplashScreen(0);

    int ret = a.exec();
    // module->stop();



    return ret;
}


