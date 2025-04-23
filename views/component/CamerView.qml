import QtQuick
import QtMultimedia
import QtQuick.Controls
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
        returnPage()
        // srcDict.connectBlue(codeData)
    }
    Connections
    {
        target: context
        function onCodeImageReady(message)
        {

            srcDict.conectedBlueName = message
            returnPage()
        }
    }
    Component.onCompleted:
    {
        // camera.start()
    }

    Button
    {
        id: button1
        text: "返回"
        anchors.top: parent.top
        anchors.topMargin: srcDict.scaled(50)
        onClicked:
        {
            returnPage()
            // myLoader.source = "InitView.qml"
        }
    }
    CaptureSession
    {
        id: cap
        camera: Camera
        {
            id: camera

            cameraFormat: Qt.size(1280, 720)
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
    VideoOutput
    {
        id: output
        anchors.fill: parent
    }
    Timer
    {
        interval: 1500
        running: cap.camera.active && !isCapturing// 摄像头激活时启动
        repeat: true
        onTriggered:
        {
            isCapturing = true
            // imgCap.captureToFile("") // 触发捕获
            imgCap.capture()
        }
    }


    // 2. 扫描线动画
    Rectangle
    {
        id: scanLine
        visible: cap.camera.active
        width: parent.width
        height: 2
        color: "#00ff00" // 绿色扫描线
        opacity: 0.6     // 半透明效果

        // 初始位置在顶部
        y: 0
        // 线性动画：从上到下循环移动
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
        width: 200
        height: 200
        visible: cap.camera.active
        color: "transparent"
        border.color: "#00ff00"
        border.width: 2
    }

}
