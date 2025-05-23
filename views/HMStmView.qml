import QtQuick
import QtQuick.Controls
import "./component"
import "./js" as HMFunc
import QtQuick.Window
// 主窗口

Rectangle
{
    visible: true

    property variant context: HMStmViewContext
    property variant fields:  HMStmViewContext.fields

    property int currIndex: 1

    width: srcDict.winWidth
    height: srcDict.winHeight


    function putOp(command,params)
    {
        if(params)
        {
            HMStmViewContext.invoke(command, params);
        }
    }
    // 启动动画页
       Rectangle {
           id: splashScreen
           anchors.fill: parent
           color: "#2c3e50"
           z: 100

           // Image {
           //     source: "qrc:/logo.png"  // 替换为你的 LOGO 资源
           //     anchors.centerIn: parent
           //     width: 120
           //     height: 120
           // }

           Text {
               text: "欢迎使用"
               color: "white"
               anchors.horizontalCenter: parent.horizontalCenter
               anchors.top: parent.verticalCenter
               anchors.topMargin: 80
               font.pixelSize: 20
           }

           // 动画退出启动页
           SequentialAnimation on opacity {
               running: true
               loops: 1
               NumberAnimation { from: 1; to: 1; duration: 1000 } // 停留 1 秒
               NumberAnimation { from: 1; to: 0; duration: 1000 } // 淡出动画
               ScriptAction { script: splashScreen.visible = false } // 隐藏启动页
           }
       }

    HMFunc.HMJs
    {
        id: srcDict
    }

    Loader
    {
        focus: true
        id:myLoader
        anchors.fill: parent
    }

    Component.onCompleted:
    {
        // myLoader.source = "InitView.qml"
    }
    StackView
    {
        id: stackView
        anchors.fill: parent
        initialItem: InitView { id: mainInitView}
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.25;height:1080;width:1920}
}
##^##*/
