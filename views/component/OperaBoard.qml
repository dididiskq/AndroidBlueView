import QtQuick
import QtQuick.Controls
Page
{
    title: qsTr("生产操作面板")
    background: Rectangle
    {
        color: "transparent"  // 完全透明
    }


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
                        loadRect.startLoad()
                        loadRect.text = qsTr("名称不能为空")
                    }
                    else if(inputRec.inputObj.text.length >24)
                    {
                        loadRect.startLoad()
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
                loadRect.startLoad()
            }
            else if(message === "-66")
            {
                loadRect.text = qsTr("超时失败")
                loadRect.startLoad()
            }
            else if(message === "-67")
            {
                loadRect.text = qsTr("服务无效")
                loadRect.startLoad()
            }
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
            text: qsTr("扫描条形码")
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
                    loadRect.text = "还未开发此功能"
                    loadRect.startLoad()
                }
            }
        }
    }

}
