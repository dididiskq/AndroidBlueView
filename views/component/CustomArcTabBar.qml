import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

TabBar {
    id: tabBar
    width: parent.width
    height: 80

    // 自定义属性
    property color backgroundColor: "#2C3E50"   // 背景颜色
    property color selectedColor: "#3498DB"      // 选中状态颜色
    property real arcHeight: 30                 // 弧形高度

    // 背景形状
    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 8

        ShapePath {
            fillColor: tabBar.backgroundColor
            strokeWidth: 0

            startX: 0
            startY: tabBar.height

            // 左侧垂直线段
            PathLine { x: 0; y: tabBar.arcHeight }

            // 左侧弧形
            PathArc {
                x: tabBar.width
                y: tabBar.arcHeight
                radiusX: tabBar.width / 2
                radiusY: tabBar.arcHeight * 2
                direction: PathArc.Counterclockwise
            }

            // 右侧垂直线段
            PathLine { x: tabBar.width; y: tabBar.height }

            // 底部闭合路径
            PathLine { x: 0; y: tabBar.height }
        }
    }

    // Tab按钮样式
    background: Rectangle { color: "transparent" } // 隐藏默认背景

    contentItem: Row {
        spacing: 0
        Repeater {
            model: tabBar.contentModel
            delegate: TabButton {
                width: tabBar.width / tabBar.count
                height: tabBar.height - tabBar.arcHeight

                // 自定义文本样式
                contentItem: Text {
                    text: modelData.text
                    color: tabBar.currentIndex === index ? selectedColor : "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font {
                        pixelSize: 16
                        bold: tabBar.currentIndex === index
                    }
                }

                // 按钮背景
                background: Rectangle {
                    color: "transparent"
                    Rectangle {
                        width: parent.width
                        height: 4
                        color: selectedColor
                        visible: tabBar.currentIndex === index
                        anchors.bottom: parent.bottom
                    }
                }
            }
        }
    }
}
