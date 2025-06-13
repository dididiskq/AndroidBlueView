import QtQuick
import QtQuick.Controls
import QtMultimedia
Page
{
    title: qsTr("生产操作面板")
    background: Rectangle
    {
        color: "transparent"  // 完全透明
    }

    // 主操作面板（初始状态）
    Item
    {
        id: mainPanel
        anchors.fill: parent
        visible: true
        Rectangle
        {
            id: rectangle
            anchors.top: parent.top
            anchors.topMargin: srcDict.scaled(10)
            width: parent.width
            height: srcDict.scaled(50)
            border.color: "white"
            color: "transparent"
            radius: 10
            Label
            {
                anchors.centerIn: parent
                text: qsTr("电流归零")
                color: "white"
                font.pixelSize: 25
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    srcDict.writeToBlue(257, 10000)
                    rectangle.color = "white"
                }
                onReleased:
                {
                    console.log("放开")
                    releaseTimer1.start()
                }
                Timer
                {
                    id: releaseTimer1
                    interval: 150
                    repeat: false
                    onTriggered:
                    {
                        rectangle.color = "transparent"
                    }
                }
            }
        }
        Rectangle
        {
            id: rectangle1
            anchors.top: rectangle.bottom
            anchors.topMargin: srcDict.scaled(50)
            width: parent.width
            height: srcDict.scaled(150)
            border.color: "white"
            color: "transparent"
            radius: 10
            TextFieldTemplate
            {
                id: inputRec
                anchors
                {
                    // left: parent.left
                    top: parent.top
                    topMargin: srcDict.scaled(30)
                    // leftMargin: srcDict.scaled(30)
                    horizontalCenter:parent.horizontalCenter
                }
                width: parent.width * 0.75
                height: parent.height * 0.3
                inputObj.placeholderText: qsTr("请输入蓝牙名称")
            }

            Label
            {
                id: writeLabel
                anchors
                {
                    top: inputRec.bottom
                    topMargin:  srcDict.scaled(20)
                    horizontalCenter:parent.horizontalCenter
                }
                background: Rectangle
                {
                    color: "transparent"
                    radius: 10
                    border.color: "white"
                }

                font.pixelSize: 25
                color: "white"
                text: qsTr("写入蓝牙名称")
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        writeLabel.color = "green"
                        if(inputRec.inputObj.text === "")
                        {
                            loadRect.startLoad(3000)
                            loadRect.text = qsTr("名称不能为空")
                        }
                        else if(inputRec.inputObj.text.length >24)
                        {
                            loadRect.startLoad(3000)
                            loadRect.text = qsTr("名称太长")
                        }
                        else
                        {
                            srcDict.writeToBlue(586, inputRec.inputObj.text)
                        }
                    }
                    onReleased:
                    {
                        releaseTimer2.start()
                    }
                    Timer
                    {
                        id: releaseTimer2
                        interval: 150
                        repeat: false
                        onTriggered:
                        {
                            writeLabel.color = "white"
                        }
                    }
                }
            }
        }

        Timer
        {
            id: timer1
            interval: 1000
            onTriggered:
            {
                srcDict.conectedBlueName = srcDict.customerMode
            }
        }

        Rectangle
        {
            id: rectangle2
            anchors.top: rectangle1.bottom
            anchors.topMargin: srcDict.scaled(50)
            width: parent.width
            height: srcDict.scaled(50)
            border.color: "white"
            color: "transparent"
            radius: 10
            Label
            {
                anchors.centerIn: parent
                text: qsTr("扫一扫")
                color: "white"
                font.pixelSize: 25
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    rectangle2.color = "white"
                }
                onReleased:
                {
                    releaseTimer3.start()
                }
                Timer
                {
                    id: releaseTimer3
                    interval: 150
                    repeat: false
                    onTriggered:
                    {
                        rectangle2.color = "transparent"
                        mainPanel.visible = false
                        scanPanel.visible = true
                    }
                }
            }
        }
    }

    // 扫描条形码面板（默认隐藏）
    Item
    {
        id: scanPanel
        anchors.fill: parent
        visible: false
        CaptureSession
        {
            id: cap
            camera: Camera
            {
                id: camera
                active: scanPanel.visible
            }
            videoOutput: output
        }

        VideoOutput
        {
            id: output
            anchors.fill: parent
        }
        Connections
        {
            target: context
            function onCodeImageReady(message, type)
            {
                if(type === 2)
                {
                    timer.stop();
                    scanPanel.visible = false
                    mainPanel.visible = true
                    inputRec.inputObj.text = message
                }
            }
        }
        Timer
        {
            id: timer
            interval: 600
            running: cap.camera.active
            repeat: true
            onTriggered:
            {

                output.grabToImage(function(result)
                {
                    srcDict.sendCodeData(result.image, 2)
                });
            }
        }
        // 扫描框
        Rectangle
        {
            id: scanFrame
            width: parent.width * 0.8
            height: width * 0.6
            anchors.centerIn: parent
            color: "transparent"
            border.color: "green"
            border.width: 2

            // 扫描线
            Rectangle
            {
                id: scanLine
                width: parent.width
                height: 2
                color: "red"
                y: 0
                NumberAnimation on y {
                    from: 0
                    to: scanFrame.height
                    duration: 2000
                    loops: Animation.Infinite
                    running: cap.camera.active
                }
            }

            // 提示文本
            Label
            {
                anchors.top: parent.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("将条形码放入框内")
                color: "white"
                font.pixelSize: 20
            }
        }

        // 扫描结果
        Label
        {
            id: resultText
            anchors.top: scanFrame.bottom
            anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            text: ""
            color: "#00FF00"
            font.pixelSize: 25
            visible: false
        }

        // 返回按钮
        Rectangle
        {
            id: backButton
            width: srcDict.scaled(100)
            height: srcDict.scaled(50)
            anchors
            {
                top: parent.top
                left: parent.left
                margins: srcDict.scaled(20)
            }
            color: "#303030"
            border.color: "white"
            radius: 5

            Label
            {
                anchors.centerIn: parent
                text: qsTr("返回")
                color: "white"
                font.pixelSize: 20
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: {
                    // 返回主面板
                    scanPanel.visible = false
                    mainPanel.visible = true
                    resultText.visible = false
                    scanLine.y = 0
                }
            }
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
        text: qsTr("...") // 自定义提示内容
    }
    Connections
    {
        target: context
        function onMySignal(message)
        {
            if(message === "66")
            {
                loadRect.text = qsTr("设置成功")
                loadRect.startLoad(3000)
                srcDict.sendToBlue(-586)
                timer1.start()
            }
            else if(message === "-66")
            {
                loadRect.text = qsTr("超时失败")
                loadRect.startLoad(3000)
            }
            else if(message === "-67")
            {
                loadRect.text = qsTr("服务无效")
                loadRect.startLoad(3000)
            }
        }
    }
}
