import QtQuick 2.5
import QtQuick.Controls
Page
{
    title: "参数"
    background: Rectangle
    {
        color: "transparent"  // 设置背景颜色
        anchors.fill: parent // 确保填充整个 Page
    }
    StackView
    {
        id: stackView2
        anchors.fill: parent
        initialItem: mainMenu
    }
    Component
    {
        id: mainMenu
        Column
        {
            // anchors.fill: parent
            spacing: 20
            ItemDelegate
            {
                width: parent.width
                height: 50
                text: "快速设置"
                onClicked:
                {
                    stackView2.push("DParam1.qml")
                }
                Rectangle
                {
                    anchors.fill: parent
                    border.color: "red"
                    radius: 10
                }
            }
            ItemDelegate
            {
                width: parent.width
                height: 50
                text: "电压参数"
                onClicked:
                {
                    stackView2.push("DParam2.qml")
                }
                Rectangle
                {
                    anchors.fill: parent
                    border.color: "red"
                    radius: 10
                }
            }
            ItemDelegate
            {
                width: parent.width
                height: 50
                text: "温度参数"
                onClicked:
                {
                    stackView2.push("DParam3.qml")
                }
                Rectangle
                {
                    anchors.fill: parent
                    border.color: "red"
                    radius: 10
                }
            }
            ItemDelegate
            {
                width: parent.width
                height: 50
                text: "电流参数"
                onClicked:
                {
                    stackView2.push("DParam4.qml")
                }
                Rectangle
                {
                    anchors.fill: parent
                    border.color: "red"
                    radius: 10
                }
            }
            ItemDelegate
            {
                width: parent.width
                height: 50
                text: "均衡参数"
                onClicked:
                {
                    stackView2.push("DParam5.qml")
                }
                Rectangle
                {
                    anchors.fill: parent
                    border.color: "red"
                    radius: 10
                }
            }
            ItemDelegate
            {
                width: parent.width
                height: 50
                text: "系统参数"
                onClicked:
                {
                    stackView2.push("DParam6.qml")
                }
                Rectangle
                {
                    anchors.fill: parent
                    border.color: "red"
                    radius: 10
                }
            }
        }
    }
}
