import QtQuick
import QtQuick.Shapes

Item
{
    id: root
    width: srcDict.scaled(200)
    height: srcDict.scaled(200)

    // 可配置属性
    property real progress: 0.2    // 进度值（0-1）
    property int lineWidth: 20     // 进度条粗细
    property color backgroundColor: "#1A73E8"  // 背景色（原图蓝色）
    property color progressColor: "white"       // 进度条颜色
    property string textPrefix: "正在充电"       // 文字前缀

    // 进度动画（500ms缓动动画）
    Behavior on progress
    {
        NumberAnimation
        {
            duration: 500
            easing.type: Easing.OutCubic
        }
    }
    // 添加底部SOC文字
    Text
    {
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.verticalCenter
            bottomMargin: -srcDict.scaled(90)  // 调整到底部合适位置
        }
        text: "SOC"
        color: "white"

        font
        {
            pixelSize: 20
            letterSpacing: 2
            bold: true
        }
    }
    Text
    {
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.verticalCenter
            bottomMargin: -srcDict.scaled(125)  // 调整到底部合适位置
        }
        text: srcDict.soc === undefined ? "0%" : (String(srcDict.soc) + "%")
        color: "white"
        font
        {
            pixelSize: 35
            letterSpacing: 2
            bold: true
        }
    }
    Repeater
    {
        model: [0, 20, 40, 60, 80, 100]
        delegate: Text {
            // 角度计算（0点在左，100在右，顺时针270度）
            property real angle: -225 + (index * 270 / 5)  // 从-180°开始
            property real radius: root.width/2 - root.lineWidth/2 + 12

            // 精确坐标计算（增加垂直补偿）
            x: root.width/2 + radius * Math.cos(angle * Math.PI/180) - width/2
            y: root.height/2 + radius * Math.sin(angle * Math.PI/180) - height/2 + 3

            text: modelData
            color: "white"
            font {
                pixelSize: 14
                bold: true
            }

            // 智能文字旋转（防止倒置）
            transform: Rotation {
                origin.x: width/2; origin.y: height/2
                angle: angle < -90 ? -angle - 180 : -angle
            }
        }
    }
    // 背景圆环
    Shape
    {
        anchors.fill: parent
        antialiasing: true
        ShapePath
        {
            strokeWidth: root.lineWidth
            strokeColor: Qt.lighter(root.backgroundColor, 1.2)
            // capStyle: ShapePath.RoundCap
            fillColor: "transparent"
            startX: root.width/2 + root.width/2 * Math.cos(270 * Math.PI/180)
            startY: root.height/2 + root.height/2 * Math.sin(270 * Math.PI/180)

            PathAngleArc
            {
                centerX: root.width/2
                centerY: root.height/2
                radiusX: root.width/2 - root.lineWidth
                radiusY: root.height/2 - root.lineWidth
                startAngle: 135 // 起始角度（左上）
                sweepAngle: 270     // 总角度（270度）
            }
        }
    }

    // 进度圆环（动态部分）
    Shape
    {
        anchors.fill: parent
        antialiasing: true
        ShapePath {
            strokeWidth: root.lineWidth - 5
            strokeColor: root.progressColor
            // capStyle: ShapePath.RoundCap
            fillColor: "transparent"
            startX: root.width/2 + root.width/2 * Math.cos(270 * Math.PI/180)
            startY: root.height/2 + root.height/2 * Math.sin(270 * Math.PI/180)

            PathAngleArc {
                centerX: root.width/2
                centerY: root.height/2
                radiusX: root.width/2 - root.lineWidth
                radiusY: root.height/2 - root.lineWidth
                startAngle: 135  // 起始角度
                sweepAngle: 270 * root.progress // 动态角度
            }
        }
    }
    // 动态指针
    Rectangle
    {
        id: pointer
        z: 1
        width: 5
        height: parent.height / 2 - lineWidth
        color:  "transparent"
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.verticalCenter  // 将底部锚定到圆心
        }
        antialiasing: true
        // border.color: "red"
        Image
        {
            anchors.fill: parent
            source:"../res/106.svg"
        }

        transformOrigin: Item.Bottom
        rotation:  -135 + 270 * root.progress  // 角度范围：-90°（左）到 90°（右）
    }
}
