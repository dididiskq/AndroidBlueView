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
        text: qsTr("刷新中，请稍后") // 自定义提示内容
    }
    PasswordDialog
    {
        id: passwordDialog
        x: srcDict.scaled(50)
        y: srcDict.scaled(200)
        title: qsTr("安全验证")
        message: qsTr("请输入管理员密码")
        onConfirmed: (pwd) =>
        {
            console.log("输入密码:", pwd)
            if(pwd === "0909")
            {
                srcDict.setPassFlag2 = false
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
        onCanceled:
        {
            console.log("操作取消")
        }
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
                    text: qsTr("电池信息")
                    font.pixelSize: 30
                    color: "white"
                    anchors.centerIn: parent
                }
                Image
                {
                    anchors.right: parent.right
                    anchors.rightMargin: srcDict.scaled(20)
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
                        // loadRect.text = "功能未开放"
                        // loadRect.startLoad(3000)
                        stackViewMine.push("FirmwareUpdate.qml")
                    }
                }

                Label
                {
                    text: qsTr("固件升级")
                    font.pixelSize: 30
                    anchors.centerIn: parent
                    color: "white"
                }
                Image
                {
                    anchors.right: parent.right
                    anchors.rightMargin: srcDict.scaled(20)
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
                        if(srcDict.setPassFlag2)
                        {
                            passwordDialog.open()
                        }
                        else
                        {
                            if(currIndex === 3)
                            {
                                stackViewMine.push("BmsControl.qml")
                            }
                            else if(currIndex === 2)
                            {
                                stackViewMine.push("OperaBoard.qml")
                            }

                        }

                    }
                }

                Label
                {
                    text: qsTr("生产操作面板")
                    color: "white"
                    font.pixelSize: 30
                    anchors.centerIn: parent
                }
                Image
                {
                    anchors.right: parent.right
                    anchors.rightMargin: srcDict.scaled(20)
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
                    text: qsTr("BMS控制")
                    font.pixelSize: 30
                    anchors.centerIn: parent
                    color: "white"
                }
                Image
                {
                    anchors.right: parent.right
                    anchors.rightMargin: srcDict.scaled(20)
                    height: parent.height
                    width: srcDict.scaled(60)
                    source: "../res/mineComeIn.svg"
                }
            }
        }
    }
}
