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

                }
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
