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
    anchors.fill: parent
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
        function onCodeImageReady(message)
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
    Component.onCompleted:
    {
        // camera.start()
    }

    Button
    {
        id: button1
        text: qsTr("返回")
        anchors.top: parent.top
        anchors.topMargin: srcDict.scaled(50)
        onClicked:
        {
            returnPage()
        }
    }
    CaptureSession
    {
        id: cap
        camera: Camera
        {
            id: camera

            cameraFormat: Qt.size(640, 480)
        }
        imageCapture: ImageCapture
        {
            id: imgCap
            property bool muteShutter: true  // 关闭音效
            onImageCaptured: (requestId, img) =>
            {
               // 将捕获的 QImage 传递给 C++ 处理
                srcDict.sendCodeData(img)
                img.destroy()
                isCapturing = false
            }
        }

        videoOutput: output

    }
    property var sendFrame: null
    VideoOutput
    {
        id: output
        anchors.fill: parent


        Connections {
                target: output.videoSink
                function onVideoFrameChanged(frame) {
                    // 实时处理每一帧（约30fps）
                    print(frame)
                    sendFrame = frame
                }
            }
    }
    Timer
    {
        id: timer
        interval: 1500
        running: cap.camera.active // 摄像头激活时启动
        repeat: true
        onTriggered:
        {
            imgCap.capture()
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
        anchors.centerIn: parent
        width: srcDict.scaled(200)
        height: srcDict.scaled(200)
        visible: cap.camera.active
        color: "transparent"
        border.color: "#00ff00"
        border.width: 2
    }

}
