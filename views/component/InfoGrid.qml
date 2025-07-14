// InfoGrid.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Column
{
    width: parent.width
    spacing: 10

    // 暴露给外部的属性
    property string title
    property var modelData: []

    // 标题样式
    Text
    {
        text: title
        font
        {
            pixelSize: 16
            bold: true
            family: "Microsoft YaHei"
        }
        color: "white"
        leftPadding: srcDict.scaled(15)
        topPadding: srcDict.scaled(8)
    }

    // 网格布局容器
    Grid
    {
        columns: 4  // 根据图片每行显示4个参数项
        rowSpacing: srcDict.scaled(20)
        columnSpacing: srcDict.scaled(10)
        width: parent.width - srcDict.scaled(30)
        anchors.horizontalCenter: parent.horizontalCenter

        // 动态生成参数项
        Repeater
        {
            model: modelData

            // 单个参数项组件
            delegate: Rectangle {
                width: parent.width / 4 - 10
                height: srcDict.scaled(90)
                color: "transparent"

                // 参数名称
                Text
                {
                    text: modelData.text
                    font.pixelSize: 14
                    color: "white"
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // 数值显示区（示例：带单位）
                Text
                {
                    text: modelData.data // 此处应绑定实际数据
                    font
                    {
                        pixelSize: 18
                        bold: true
                    }
                    color: modelData.color
                    anchors.centerIn: parent
                }

                // 图标
                Image
                {
                    visible: false
                    source: modelData.source
                    anchors
                    {
                        right: parent.right
                        top: parent.top
                        margins: srcDict.scaled(5)
                    }
                    width: srcDict.scaled(24)
                    height: srcDict.scaled(24)
                }
            }
        }
    }
}
