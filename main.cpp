#include <QGuiApplication>
#include "hmmodule.h"
#include <QZXing.h>
#include<QImage>
#include <QQuickWindow>
#include <QJniObject>
#include <QJniEnvironment>
#include <QtCore/qnativeinterface.h>
using namespace QNativeInterface;
void setImmersiveMode()
{
    // 获取当前 Activity 对象
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

    // 获取窗口对象
    QJniObject window = activity.callObjectMethod("getWindow", "()Landroid/view/Window;");
    if (!window.isValid())
    {
        qWarning() << "Failed to get window object";
        return;
    }

    // 设置窗口标志（允许绘制系统栏背景）
    window.callMethod<void>("addFlags", "(I)V", 0x80000000); // FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS
    window.callMethod<void>("clearFlags", "(I)V", 0x04000000); // FLAG_TRANSLUCENT_STATUS
     window.callMethod<void>("clearFlags", "(I)V", 0x08000000); //FLAG_TRANSLUCENT_NAVIGATION 6/2

    // 设置状态栏和导航栏颜色为透明
    window.callMethod<void>("setStatusBarColor", "(I)V", 0x00000000);
    window.callMethod<void>("setNavigationBarColor", "(I)V", 0x00000000);


    // 获取 DecorView
    QJniObject decorView = window.callObjectMethod("getDecorView", "()Landroid/view/View;");
    if (!decorView.isValid())
    {
        qWarning() << "Failed to get decor view";
        return;
    }

    // 根据 Android 版本选择不同实现
    const int sdkVersion = QJniObject::getStaticField<jint>("android/os/Build$VERSION", "SDK_INT");
    if (sdkVersion >= 30)// Android 11 (API 30) 及以上
    {
        QJniObject insetsController = decorView.callObjectMethod(
            "getWindowInsetsController",
            "()Landroid/view/WindowInsetsController;"
            );
        if (insetsController.isValid())
        {
            // // 隐藏状态栏和导航栏
            // insetsController.callMethod<void>("hide", "(I)V", 0x00000003); // systemBars()
            // // 设置粘性行为（滑动呼出临时显示）
            // insetsController.callMethod<void>("setSystemBarsBehavior", "(I)V", 0x00000001);
        }
    }
    else
    { // Android 10 及以下
        // 组合沉浸式标志
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
        jobject activity = QAndroidApplication::context();
        QJniObject javaActivity(activity);

        if (javaActivity.isValid()) {
            // 使用系统动画方式退出
            javaActivity.callMethod<void>("finishAndRemoveTask");

            // 清理引用
            QJniEnvironment env;
            env->DeleteLocalRef(activity);
        }
    });

   // CHMModule module;

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


