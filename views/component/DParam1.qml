import QtQuick 2.5
import QtQuick.Controls
import QtQuick.Layouts
Page
{
    property var celldata: 0
    background: Rectangle
    {
        color: "transparent"  // 完全透明
    }
    title: qsTr("快速设置")
    Component.onCompleted:
    {
        //获取本页面数据
        srcDict.sendToBlue(27)
        temTimer.start()
    }
    Timer
    {
        id: temTimer
        interval: 1000
        onTriggered:
        {
            srcDict.sendToBlue(24)
        }
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
    PasswordDialog
    {
        id: passwordDialog1
        x: srcDict.scaled(50)
        y: srcDict.scaled(200)
        title: qsTr("安全验证")
        message: qsTr("请输入管理员密码")
        onConfirmed: (pwd) =>
        {
            console.log("输入密码:", pwd)
            if(pwd)
            {
                srcDict.temType = 513
                srcDict.writeToBlue(513, celldata)
                passwordDialog1.close()
            }
            else
            {
                passwordDialog1.message = qsTr("密码错误请重新输入")
            }
        }
        onCanceled: console.log("操作取消")
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
            id: rectangle
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
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    rectangle.color = "grey"
                    celldata = 0
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
                        rectangle.color = "#E4DDDD"
                        passwordDialog1.open()
                    }
                }
            }
        }

        Rectangle
        {
            id: rectangle1
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
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    rectangle1.color = "grey"
                    celldata = 1
                }
                onReleased:
                {
                    console.log("放开")
                    releaseTimer2.start()
                }
                Timer
                {
                    id: releaseTimer2
                    interval: 150
                    repeat: false
                    onTriggered:
                    {
                        rectangle1.color = "#E4DDDD"
                        passwordDialog1.open()
                    }
                }
            }
        }

        Rectangle
        {
            id: rectangle3
            height: srcDict.scaled(60)
            width: srcDict.scaled(300)
            color: "#E4DDDD"
            radius: 10
            Label
            {
                text: qsTr("一键钛酸锂参数")
                anchors.centerIn: parent
                font.pixelSize: 16
                color: "#666666"
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    rectangle3.color = "grey"
                    celldata = 2
                }
                onReleased:
                {
                    console.log("放开")
                    releaseTimer3.start()
                }
                Timer
                {
                    id: releaseTimer3
                    interval: 150
                    repeat: false
                    onTriggered:
                    {
                        rectangle3.color = "#E4DDDD"
                        passwordDialog1.open()
                    }
                }
            }
        }

        Rectangle
        {
            id: rectangle4
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
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    rectangle4.color = "grey"
                    celldata = 3
                }
                onReleased:
                {
                    console.log("放开")
                    releaseTimer4.start()
                }
                Timer
                {
                    id: releaseTimer4
                    interval: 150
                    repeat: false
                    onTriggered:
                    {
                        rectangle4.color = "#E4DDDD"
                        passwordDialog1.open()
                    }
                }
            }
        }
    }
}
