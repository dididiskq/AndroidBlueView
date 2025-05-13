import QtQuick
import QtQuick.Controls
Item {
    id: root

    // 可定制属性
    property alias text: label.text      // 提示文本
    property alias textColor: label.color
    property alias textSize: label.font.pixelSize
    property alias bgColor: bg.color
    property alias bgRadius: bg.radius
    property alias iconColor: loaderIcon.color
    property alias iconSize: loaderIcon.width
    property alias animationSpeed: rotationAnim.duration
    visible: false
    width: 200  // 默认尺寸
    height: 120

    function startLoad()
    {
        root.visible = true
        timerLoad.start()
    }

    Timer
    {
        id: timerLoad
        interval: 2000
        onTriggered:
        {
            root.visible = false
        }
    }

    // 背景框
    Rectangle
    {
        id: bg
        anchors.fill: parent
        color: "#80000000"  // 半透明黑色默认背景
        radius: 8
    }

    // 加载图标（可替换为自定义图片）
    Rectangle
    {
        id: loaderIcon
        width: 40
        height: width
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 20
        }

        Rectangle
        {
            width: parent.width * 0.8
            height: 4
            color: root.iconColor || "white"
            anchors.centerIn: parent
        }

        RotationAnimator
        {
            id: rotationAnim
            target: loaderIcon
            from: 0
            to: 360
            duration: 1000
            loops: Animation.Infinite
            running: root.visible  // 自动控制动画启停
        }
    }

    // 文字提示
    Text
    {
        id: label
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 20
        }
        color: "white"
        font.pixelSize: 14
        text: qsTr("正在加载数据...")
    }
}
