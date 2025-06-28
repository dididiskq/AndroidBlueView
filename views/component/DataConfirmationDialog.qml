import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects
Item {
    id: rootdialog
    anchors.fill: parent

    // 显示/隐藏控制
    property bool showDialog: false
    property bool jiantouVisible: true
    property var titleName: "以下数据发生变更，是否继续写入?"
    property var changeName: ""
    property var changeold: ""
    property var changeNew: ""
    signal okBtn()
    signal noBtn()

    // 半透明背景层
    Rectangle
    {
        id: overlay
        anchors.fill: parent
        color: "black"
        opacity: showDialog ? 0.5 : 0
        visible: opacity > 0

        // 禁用背景交互
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {}  // 阻止点击穿透
        }
    }

    // 对话框组件
    Rectangle {
        id: confirmationDialog
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.8, 350)
        height: 150
        radius: 8
        color: "#FFFFFF"
        opacity: showDialog ? 1 : 0
        visible: opacity > 0

        // 平滑的显示/隐藏动画
        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        // 卡片阴影
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 16
            color: "#80000000"
            spread: 0.1
        }

        Column {
            id: content
            width: parent.width - 30
            anchors.centerIn: parent
            spacing: 15

            // 标题文本
            Text
            {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: titleName
                font.pixelSize: 16
                font.bold: true
                color: "#333333"
            }

            // 修改项详情
            Column
            {
                width: parent.width
                spacing: 10

                Text
                {
                    width: parent.width
                    text: changeName
                    font.pixelSize: 14
                    color: "#444444"
                }

                // 值变更对比
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10

                    // 原始值 - 红色
                    Text {
                        text: changeold
                        font.pixelSize: 14
                        color: "#FF0000"
                    }

                    // 箭头符号
                    Text
                    {
                        visible: jiantouVisible
                        text: "→"
                        font.pixelSize: 14
                        color: "#888888"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    // 新值 - 绿色加粗
                    Text {
                        text: changeNew
                        font.pixelSize: 14
                        font.bold: true
                        color: "#00AA00"
                    }
                }
            }

            // 按钮组
            Row {
                width: parent.width
                spacing: 20

                // 取消按钮
                Button
                {
                    width: (parent.width - parent.spacing) / 2
                    text: "取消"
                    background: Rectangle {
                        color: "#DDDDDD" // 灰色背景
                        radius: 5
                    }
                    onClicked: {
                        console.log("操作取消")
                        rootdialog.showDialog = false
                        noBtn()
                    }
                }

                // 确定按钮
                Button
                {
                    width: (parent.width - parent.spacing) / 2
                    text: "确定"
                    background: Rectangle {
                        color: "#4CAF50" // 绿色背景
                        radius: 5
                    }
                    onClicked: {
                        console.log("确认操作")
                        rootdialog.showDialog = false
                        okBtn()
                    }
                }
            }
        }
    }
}
