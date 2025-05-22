import QtQuick
import QtQuick.Controls

Row
{
    width: parent.width
    spacing: 10

    Rectangle
    {
        width: parent.width / 2 - srcDict.scaled(5)
        height: srcDict.scaled(130)
        color: "transparent"

        Rectangle
        {
            height: srcDict.scaled(50)
            width: srcDict.scaled(130)
            color: "transparent"
            border.color: "white"
            anchors.top: parent.top
            anchors.topMargin: srcDict.scaled(5)
            anchors.left: parent.left
            anchors.leftMargin: srcDict.scaled(30)
            radius: 10
            Rectangle
            {
                height: parent.height
                width: parent.width * (srcDict.soc / 100)
                anchors.top: parent.top
                anchors.left: parent.left
                radius: 10
                color: {
                    if(srcDict.soc <= 20) "#ff4444";    // 红色
                    else if(srcDict.soc < 60) "#ffdd33"; // 黄色
                    else "#77dd77" // 绿色
                }
                Behavior on width {
                    NumberAnimation { duration: 500 } // 添加动画效果
                }
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
                text: "SOC：       " + String(srcDict.soc === undefined ? "0" : srcDict.soc) + "%"
                font.pixelSize: 14
                color: "white"
            }
            Label
            {
                // text: "总容量：" + String(srcDict.fcc === undefined ? "0" : srcDict.fcc) + "AH"
                text: qsTr("总容量：   ") + String(srcDict.fcc !== undefined ? (srcDict.fcc / 100).toFixed(2) : "0.00") + "AH"
                font.pixelSize: 14
                color: "white"
            }
            Label
            {
                // text: "剩余容量：" + String(srcDict.remaining_capacity === undefined ? "0" : srcDict.remaining_capacity)+ "AH"
                text: qsTr("剩余容量：") + String(srcDict.remaining_capacity !== undefined ? (srcDict.remaining_capacity / 1000).toFixed(2) : "0.00") + "AH"
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
                text: qsTr("充电MOS")
                font.pixelSize: 14
                color: "white"
            }
            Label
            {
                text: qsTr("放电MOS")
                font.pixelSize: 14
                color: "white"
            }
            Label
            {
                text: qsTr("均衡状态")
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
                source: srcDict.cMos === undefined ? "../res/guan.svg" : (srcDict.cMos === 2 ? "../res/kai.svg" : "../res/guan.svg")
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
                source: srcDict.junhengStatus === undefined ? "../res/guan.svg" : (srcDict.junhengStatus === 128 ? "../res/kai.svg" : "../res/guan.svg")
            }
        }

    }
}
