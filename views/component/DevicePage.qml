import QtQuick 2.5
import QtQuick.Controls
import Qt5Compat.GraphicalEffects // 需要导入图形效果模块
Page
{

    id: window
    property alias realDrawer: drawer
    property var realTimer: mainPageTimer
    property alias reallStackView: stackView
    property var count: 1
    Timer
    {
        id: mainPageTimer
        interval: 0       // 初始立即触发
        repeat: false     // 首次不重复
        onTriggered:
        {
            if(stackView.depth > 1 || srcDict.currentPageIndex !== 1)
            {
                return
            }

            if(count % 2 === 0)
            {
                srcDict.getProtectMessage(1)
            }
            else
            {
                srcDict.timerGetData(1)
            }
            count++

            // 调整间隔和重复模式
            interval = 4000
            repeat = true
            start()
        }
    }

    background: Rectangle
    {
        color: "transparent"  // 完全透明
    }
    header:ToolBar
    {
        id: headTool
        height: srcDict.scaled(88)
        background: Rectangle
        {
            anchors.fill: parent
            color: "transparent"
        }
        ToolButton
        {
            // visible: srcDict.isShowTool
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            text: stackView.depth > 1 ? "\u25C0" : "\u2261"
            font.pixelSize: 25
            onClicked:
            {
                if(stackView.depth > 1)
                {
                    stackView.pop()
                }
                else
                {
                    if(drawer.opened)
                    {
                        drawer.close()
                    }
                    else
                    {
                        drawer.open()
                    }
                }
                window.forceActiveFocus()
            }
        }

        Label
        {
            text: stackView.currentItem.title
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 25
            color: "#33C3FF"
        }
    }
    Component.onCompleted:
    {
    }

    StackView
    {
        id: stackView
        anchors.fill: parent

        initialItem: DRealTime{}
        // 添加模糊层
        layer.enabled: drawer.position > 0 // 抽屉展开时启用效果
        layer.effect: FastBlur
        {
            radius: 32 // 模糊半径（0-64）
            transparentBorder: true // 允许边缘透明
            Behavior on radius { // 添加过渡动画
                NumberAnimation { duration: 200 }
            }
        }
    }
    //侧边抽屉
    Drawer
    {
        id: drawer
        width: window.width * 0.7
        height: window.height * 0.8
        y: headTool.height
        dim: true // 关闭默认的暗色遮罩
        edge: Qt.LeftEdge
        interactive: false
        modal: true
        // 添加半透明背景
        background: Rectangle
        {
            color: "transparent" // 半透明黑色
            Rectangle
            { // 侧边栏内容背景
                width: parent.width
                height: parent.height
                color: "#001556"
                radius: 10
                anchors.right: parent.right
            }
        }

        Column
        {
            anchors.fill: parent

            ItemDelegate
            {
                width: drawer.width
                height: 50
                text: qsTr("快速设置")
                background: Rectangle
                {
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "white"
                    radius: 10
                }
                onClicked:
                {
                    stackView.push("DParam1.qml")
                    drawer.close()
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            ItemDelegate
            {
                width: drawer.width
                height: srcDict.scaled(50)
                text: qsTr("电压参数")
                onClicked:
                {
                    stackView.push("DParam2.qml")
                    drawer.close()
                }
                background: Rectangle
                {
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "white"
                    radius: 10
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            ItemDelegate
            {
                width: drawer.width
                height: srcDict.scaled(50)
                text: qsTr("温度参数")
                onClicked:
                {
                    stackView.push("DParam3.qml")
                    drawer.close()
                }
                background: Rectangle
                {
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "white"
                    radius: 10
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            ItemDelegate
            {
                width: drawer.width
                height: srcDict.scaled(50)
                text: qsTr("电流参数")
                onClicked:
                {
                    stackView.push("DParam4.qml")
                    drawer.close()
                }
                background: Rectangle
                {
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "white"
                    radius: 10
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            ItemDelegate
            {
                width: drawer.width
                height: srcDict.scaled(50)
                text: qsTr("均衡参数")
                onClicked:
                {
                    stackView.push("DParam5.qml")
                    drawer.close()
                }
                background: Rectangle
                {
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "white"
                    radius: 10
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            ItemDelegate
            {
                width: drawer.width
                height: srcDict.scaled(50)
                text: qsTr("系统参数")
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked:
                {
                    stackView.push("DParam6.qml")
                    drawer.close()
                }
                background: Rectangle
                {
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "white"
                    radius: 10
                }
            }
        }
    }

}
