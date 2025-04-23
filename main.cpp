#include <QGuiApplication>
#include "hmmodule.h"
#include <QZXing.h>
#include<QImage>
#include <QQuickWindow>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);

    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts );
    QQuickWindow::setGraphicsApi(QSGRendererInterface::OpenGL);
    QGuiApplication a(argc, argv);  // 主线程
   // CHMModule module;
    std::unique_ptr<CHMModule> module(new CHMModule());
    if( !module->start())
    {
        return 1;
    }


    int ret = a.exec();
    // module->stop();



    return ret;
}


