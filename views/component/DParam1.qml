import QtQuick 2.5
import QtQuick.Controls
import QtQuick.Layouts
Page
{

    background: Rectangle
    {
        color: "transparent"  // 完全透明
    }
    title: qsTr("快速设置")
    Component.onCompleted:
    {
        //获取本页面数据
        srcDict.sendToBlue(24)
        srcDict.sendToBlue(27)

    }


    ParameterPage
    {
        id: paramRect
        anchors
        {
            top: parent.top
            topMargin: srcDict.scaled(50)

        }
        width: parent.width
        paramList: [
            { name: qsTr("电池实际串数"), value: srcDict.cellNum === undefined ? 0 : srcDict.cellNum, unit: "串" , cellData: 512},
            { name: qsTr("电池物理容量"), value: srcDict.fcc === undefined ? 0 : srcDict.fcc/100, unit: "AH" , cellData: 1026}
        ]
    }


    Column
    {
        id: colArea
        spacing: 10
        anchors.top: paramRect.bottom
        anchors.topMargin: srcDict.scaled(20)
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle
        {
            height: srcDict.scaled(60)
            width: srcDict.scaled(300)
            color: "#E4DDDD"
            radius: 10
            Label
            {
                text: qsTr("一键铁锂参数")
                anchors.centerIn: parent
                font.pixelSize: 16
                color: "#666666"
            }
        }

        Rectangle
        {
            height: srcDict.scaled(60)
            width: srcDict.scaled(300)
            color: "#E4DDDD"
            radius: 10
            Label
            {
                text: qsTr("一键三元参数")
                anchors.centerIn: parent
                font.pixelSize: 16
                color: "#666666"
            }
        }


        Rectangle
        {
            height: srcDict.scaled(60)
            width: srcDict.scaled(300)
            color: "#E4DDDD"
            radius: 10
            Label
            {
                text: qsTr("一键钠离子参数")
                anchors.centerIn: parent
                font.pixelSize: 16
                color: "#666666"
            }
        }
    }
}
