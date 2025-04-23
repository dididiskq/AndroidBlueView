import QtQuick 2.5

import QtQuick.Controls
import QtQuick.Layouts
Page
{
    id: minePage
    property int currIndex: -1
    property alias reallStackView: stackViewMine
    background: Rectangle
    {
        anchors.fill: parent
        color: "transparent"
    }
    header:ToolBar
    {
        height: srcDict.scaled(88)
        background: Rectangle
        {
            anchors.fill: parent
            color: "transparent"
        }
        ToolButton
        {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            text: stackViewMine.depth > 1 ? "\u25C0" :""
            font.pixelSize: 25
            visible: stackViewMine.depth <= 1 ? false: true
            onClicked:
            {
                if(stackViewMine.depth > 1)
                {
                    stackViewMine.pop()
                }
                else
                {
                    // drawer.open()
                }
            }
        }

        Label
        {
            text: stackViewMine.currentItem.title
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 25
            color: "#33C3FF"
        }
    }
    StackView
    {
        id: stackViewMine
        anchors.fill: parent
        initialItem: mainMenu
    }
    PasswordDialog
    {
        id: passwordDialog
        x: 50
        y: 200
        title: "安全验证"
        message: "请输入管理员密码"
        onConfirmed: (pwd) =>
        {
            console.log("输入密码:", pwd)
            if(pwd)
            {
                if(currIndex === 3)
                             {
                                 stackViewMine.push("BmsControl.qml")
                             }
                             else if(currIndex === 2)
                             {
                                 stackViewMine.push("OperaBoard.qml")
                             }

                passwordDialog.close()
            }
            else
            {
                passwordDialog.message = "密码错误请重新输入"
            }
        }
        onCanceled: console.log("操作取消")
    }
    Page
    {
        id: mainMenu
        title: qsTr("Ultra BMS")
        background: Rectangle
        {
            id: rectBg
            // color: "white"
            color: "transparent"  // 完全透明
        }
        Column
        {
            spacing: srcDict.scaled(20)
            anchors.top: parent.top
            anchors.topMargin: srcDict.scaled(50)
            width: minePage.width

            Rectangle
            {
                height: srcDict.scaled(60)
                width: srcDict.scaled(380)
                color: "transparent"
                Layout.alignment: Qt.AlignHCenter // 关键代码
                radius: 10
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        stackViewMine.push("CellMessage.qml")
                    }
                }

                Label
                {
                    text: "电池信息"
                    font.pixelSize: 30
                    color: "white"
                    anchors.centerIn: parent
                }
                Image
                {
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    height: parent.height
                    width: srcDict.scaled(60)
                    source: "../res/mineComeIn.svg"
                }
            }

            Rectangle
            {
                height: srcDict.scaled(60)
                width: srcDict.scaled(380)
                radius: 10
                color: "transparent"
                Layout.alignment: Qt.AlignHCenter // 关键代码
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                    }
                }

                Label
                {
                    text: "固件升级"
                    font.pixelSize: 30
                    anchors.centerIn: parent
                    color: "white"
                }
                Image
                {
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    height: parent.height
                    width: srcDict.scaled(60)
                    source: "../res/mineComeIn.svg"
                }
            }
            Rectangle
            {
                height: srcDict.scaled(60)
                width: srcDict.scaled(380)
                color: "transparent"
                Layout.alignment: Qt.AlignHCenter // 关键代码
                radius: 10
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        currIndex = 2
                        passwordDialog.open()

                    }
                }

                Label
                {
                    text: "生产操作面板"
                    color: "white"
                    font.pixelSize: 30
                    anchors.centerIn: parent
                }
                Image
                {
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    height: parent.height
                    width: srcDict.scaled(60)
                    source: "../res/mineComeIn.svg"
                }
            }
            Rectangle
            {
                height: srcDict.scaled(60)
                width: srcDict.scaled(380)
                color: "transparent"
                Layout.alignment: Qt.AlignHCenter // 关键代码
                radius: 10
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        // currIndex = 2
                        stackViewMine.push("BmsControl.qml")
                        // passwordDialog.open()

                    }
                }

                Label
                {
                    text: "BMS控制"
                    font.pixelSize: 30
                    anchors.centerIn: parent
                    color: "white"
                }
                Image
                {
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    height: parent.height
                    width: srcDict.scaled(60)
                    source: "../res/mineComeIn.svg"
                }
            }
        }
    }
}
