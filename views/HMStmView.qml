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
    Rectangle
    {
        id: splash
        anchors.fill: parent
        color: "white"  // 或你的启动图背景色
        z: 9999

        // Image {
        //     anchors.centerIn: parent
        //     source: "qrc:/android/res/drawable/splash_image.png"
        // }
        Label
        {
            text: "ULTRA BMS" + srcDict.version
            anchors.centerIn: parent
        }

        // Behavior 自动为 opacity 添加渐变
        Behavior on opacity
        {
            NumberAnimation
            {
                duration: 500    // 渐变时长 500ms
                easing.type: Easing.InOutQuad
            }
        }

        // 自动隐藏 splash 画面
        Timer {
            interval: 1100  // 启动持续时间
            running: true
            repeat: false
            onTriggered:
            {
                splash.opacity = 0.0
            }
        }
        onOpacityChanged: {
                    if (opacity === 0) {
                        splash.visible = false
                    }
                }
    }


    function putOp(command,params)
    {
        if(params)
        {
            HMStmViewContext.invoke(command, params);
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
