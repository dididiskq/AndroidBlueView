import QtQuick
import QtMultimedia
import QtQuick.Controls
import QtQml.WorkerScript
Page
{
    property alias capReal: cap
    property var codeData: srcDict.codeData
    property bool isCapturing: false
    visible: true
    width: srcDict.winWidth
    height: srcDict.winHeight
    signal returnPage()

    onCodeDataChanged:
    {
        if(codeData === undefined || codeData === "")
        {
            return;
        }
        // timer.stop()
        // returnPage()
        // srcDict.connectBlue(codeData)
    }
    Label
    {
        id: labConn
        visible: false
        anchors.centerIn: parent
        text: qsTr("连接中请稍后...")
    }
    Timer
    {
        id: timerHiden
        interval: 5000
        onTriggered:
        {
            labConn.text = qsTr("未找到指定设备，请重试")
        }
    }
    LoadingIndicator
    {
        id: loadRect
        anchors.centerIn: parent
        width: srcDict.scaled(300)  // 自定义尺寸
        height: srcDict.scaled(150)
        z: 999
        bgColor: "#CC303030"  // 自定义背景色
        textColor: "#00FF00"   // 自定义文字颜色
        iconColor: "#FFA500"   // 橙色加载图标
        text: qsTr("连接中，请稍后") // 自定义提示内容
    }
    Connections
    {
        target: context
        function onCodeImageReady(message, type)
        {
            if(message === "connecting")
            {
                timer.stop();
                camera.stop()
                loadRect.visible = true
                // timerHiden.start()
            }
            else
            {
                loadRect.visible = false
                srcDict.conectedBlueName = message
                hidenTabbar(0)
                srcDict.currentPageIndex = 2
                stackView1.pop()
            }
        }
    }


    Button
    {
        id: button1
        text: qsTr("返回")
        anchors.top: parent.top
        anchors.topMargin: srcDict.scaled(50)
        onClicked:
        {
            hidenTabbar(0)
            srcDict.currentPageIndex = 2
            stackView1.pop()
        }
    }
    CaptureSession
    {
        id: cap
        camera: Camera
        {
            id: camera

            // cameraFormat: Qt.size(640, 480)
        }


        videoOutput: output

    }
    property var sendFrame: null
    VideoOutput
    {
        id: output
        anchors.fill: parent
    }
    function startCamera() {
        camera.active = true   // ✅ Qt 6.9 正确的启用方式
    }
    Component.onCompleted:
    {
        srcDict.startSearch()
        // cap.camera.start()
        // camera.active = true
        HMStmViewContext.requestCameraThenStart(this)
        srcDict.currentPageIndex = 4
    }
    Timer
    {
        id: timer
        interval: 500
        running: cap.camera.active // 摄像头激活时启动
        repeat: true
        onTriggered:
        {
            output.grabToImage(function(result)
            {  
                srcDict.sendCodeData(result.image, 1)
            });
        }
    }


    Rectangle
    {
        id: scanLine
        visible: cap.camera.active
        width: parent.width
        height: 2
        color: "#00ff00" // 绿色扫描线
        opacity: 0.6     // 半透明效果


        y: 0
        NumberAnimation on y {
            from: 0
            to: output.height
            duration: 2000  // 动画时长（毫秒）
            loops: Animation.Infinite // 无限循环
            running: cap.camera.active
        }
    }


    Rectangle
    {
        id: cenRect
        anchors.centerIn: parent
        width: srcDict.scaled(200)
        height: srcDict.scaled(200)
        visible: cap.camera.active
        color: "transparent"
        border.color: "#00ff00"
        border.width: 2
    }

}
