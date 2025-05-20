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
            font.pixelSize: 25
            color: "white"
            text: qsTr("写入蓝牙名称")
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    if(inputRec.inputObj.text === "")
                    {
                        loadRect.startLoad()
                        loadRect.text = qsTr("名称不能为空")
                    }
                    else
                    {
                        srcDict.writeToBlue(582, inputRec.inputObj.text)
                        loadRect.visible = true
                        loadRect.text = qsTr("请稍后...")
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
                loadRect.visible = false
            }
            else if(message === "-66")
            {
                loadRect.text = qsTr("超时失败")
                loadRect.visible = false
            }
            else if(message === "-67")
            {
                loadRect.text = qsTr("服务无效")
                loadRect.visible = false
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

            }
        }
    }

}
