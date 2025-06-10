import QtQuick
import QtQuick.Controls

Row
{
    id: mainRow
    property string paramName: ""   // 参数名称（如“充电隔热保护”）
    property real paramValue: 0     // 参数值（如60）
    property string paramUnit: "℃"  // 参数单位（如℃）
    property var btnText: "设置"  // 按钮文本
    property alias realValueEditor: valueEditor
    property alias resetTimer: resetTimer

    signal clicked

    spacing: srcDict.scaled(20)
    // 参数值 + 单位
    Row {
        spacing: srcDict.scaled(10)

        // 参数名称
        Text {
            id: nameP
            width: srcDict.scaled(150)
            height: btnReal.height
            text: paramName
            font.pixelSize: 14
            color: "white"
            verticalAlignment: Text.AlignVCenter

        }
        // 可编辑的数值输入框
        TextInput
        {
            id: valueEditor
            width: srcDict.scaled(50)
            height: btnReal.height
            text: paramValue.toString()
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
            color: activeFocus ? "#0078D4" : "blue"  // 聚焦时显示蓝色边框
            validator: DoubleValidator {           // 限制只能输入数字（含负号和小数）
                locale: "C"
                notation: DoubleValidator.StandardNotation
            }
            selectByMouse: true                     // 允许鼠标选择文本
            activeFocusOnPress: true                // 点击时自动聚焦

            // 边框样式
            Rectangle
            {
                anchors.fill: parent
                border.color: parent.activeFocus ? "#0078D4" : "transparent"
                border.width: 1
                radius: 2
                z: -1
            }

            // 完成编辑时更新参数值
            onEditingFinished: {
                paramValue = Number(text)
                focus = false
            }
        }
        Text
        {
            text: paramUnit
            height: btnReal.height
            width: srcDict.scaled(30)
            font.pixelSize: 12
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }

        // 设置按钮
        // Button
        // {
        //     id: btnReal
        //     visible: false
        //     text: btnText
        //     width: srcDict.scaled(95)
        //     height: srcDict.scaled(30)

        //     background: Rectangle
        //     {
        //         color: "#0078D4"        // 蓝色按钮
        //         radius: 4
        //     }
        //     contentItem: Text
        //     {
        //         text: parent.text
        //         color: "white"
        //         horizontalAlignment: Text.AlignHCenter
        //         verticalAlignment: Text.AlignVCenter
        //     }
        //     onClicked: mainRow.clicked() // 触发点击信号
        // }
        Rectangle
        {
            id: btnReal
            width: srcDict.scaled(95)
            height: srcDict.scaled(30)
            color: "#0078D4"
            radius: 4
            Text {
                id: name
                text: btnText
                color: "white"
                anchors.centerIn: parent
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    onClicked: mainRow.clicked()
                }
            }
        }
    }


    Timer
    {
        id: resetTimer
        interval: 2000
        onTriggered:
        {
            btnText = qsTr("设置")
        }
    }
}
