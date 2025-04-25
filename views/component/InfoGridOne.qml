import QtQuick
import QtQuick.Controls

Row
{
    width: parent.width
    spacing: 10

    Rectangle
    {
        width: parent.width / 2 - 5
        height: srcDict.scaled(130)
        color: "transparent"

        Rectangle
        {
            height: srcDict.scaled(50)
            width: 130 * (srcDict.soc / 100)
            anchors.top: parent.top
            anchors.topMargin: 5
            Rectangle
            {
                height: parent.height
                width: srcDict.scaled(130)
                color: "transparent"
                border.color: "white"
                anchors.centerIn: parent
                radius: 10
            }

            border.color: "red"
            radius: 10
            anchors.horizontalCenter: parent.horizontalCenter
            color: {
                if(srcDict.soc <= 20) "#ff4444";    // 红色
                else if(srcDict.soc <= 60) "#ffdd33"; // 黄色
                else "#77dd77" // 绿色
            }
            Behavior on width {
                NumberAnimation { duration: 500 } // 添加动画效果
            }
        }

        Column
        {
            spacing: 10
            anchors
            {
                top: parent.top
                topMargin: srcDict.scaled(55)
                // verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            Label
            {
                text: "SOC：" + String(srcDict.soc === undefined ? "0" : srcDict.soc) + "%"
                font.pixelSize: 14
                color: "white"
            }
            Label
            {
                text: "总容量：" + String(srcDict.fcc === undefined ? "0" : srcDict.fcc) + "AH"
                font.pixelSize: 14
                color: "white"
            }
            Label
            {
                text: "剩余容量：" + String(srcDict.remaining_capacity === undefined ? "0" : srcDict.remaining_capacity)+ "AH"
                font.pixelSize: 14
                color: "white"
            }
        }
    }

    Rectangle
    {
        width: parent.width / 2 - 5
        height: srcDict.scaled(130)
        color: "transparent"

        // 参数名称
        Column
        {
            spacing: srcDict.scaled(20)
            anchors
            {
                left: parent.left
                leftMargin: srcDict.scaled(50)
                verticalCenter: parent.verticalCenter
            }
            Label
            {
                text: "充电MOS"
                font.pixelSize: 14
                color: "white"
            }
            Label
            {
                text: "放电MOS"
                font.pixelSize: 14
                color: "white"
            }
            Label
            {
                text: "均衡状态"
                font.pixelSize: 14
                color: "white"
            }
        }
        Column
        {
            spacing: 20
            anchors
            {
                right: parent.right
                rightMargin: srcDict.scaled(50)
                verticalCenter: parent.verticalCenter
            }
            Image
            {
                height: srcDict.scaled(20)
                width: srcDict.scaled(20)
                source: srcDict.cMos === undefined ? "../res/guan.svg" : (srcDict.cMos === 1 ? "../res/kai.svg" : "../res/guan.svg")
            }
            Image
            {
                height: srcDict.scaled(20)
                width: srcDict.scaled(20)
                source: srcDict.fMos === undefined ? "../res/guan.svg" : (srcDict.fMos === 1 ? "../res/kai.svg" : "../res/guan.svg")
            }
            Image
            {
                height: srcDict.scaled(20)
                width: srcDict.scaled(20)
                source: srcDict.junhengStatus === undefined ? "../res/guan.svg" : (srcDict.junhengStatus === 1 ? "../res/kai.svg" : "../res/guan.svg")
            }
        }

    }
}
