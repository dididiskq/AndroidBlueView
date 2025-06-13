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
    width: parent.width
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

    Connections
    {
        target: context
        function onCodeImageReady(message, type)
        {
            if(message === "connecting")
            {
                timer.stop();
                camera.stop()
                labConn.visible = true
            }
            else
            {
                srcDict.conectedBlueName = message
                returnPage()
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
    Component.onCompleted:
    {
        cap.camera.start()
        srcDict.currentPageIndex = 4
    }
    Timer
    {
        id: timer
        interval: 1000
        running: cap.camera.active // 摄像头激活时启动
        repeat: true
        onTriggered:
        {
            // imgCap.capture()
            // srcDict.sendCodeData(sendFrame)
            output.grabToImage(function(result)
            {
                // result.image 就是一个 QImage
                // HMStmViewContext.onFrameGrabbed(result.image)
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
