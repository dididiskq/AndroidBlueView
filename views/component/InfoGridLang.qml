import QtQuick
import QtQuick.Controls

Column
{
    width: parent.width
    spacing: 10
    Text
    {
        text: qsTr("设备信息")
        font
        {
            pixelSize: 16
            bold: true
            family: "Microsoft YaHei"
        }
        color: "#333333"
        leftPadding: 15
        topPadding: 8
    }


    Rectangle
    {
        width: parent.width   - 10
        height: srcDict.scaled(30)
        color: "transparent"
        // 参数名称
        Text
        {
            text: "设备名称"
            font.pixelSize: 14
            color: "#666666"
            anchors
            {
                left: parent.left
                leftMargin: srcDict.scaled(30)
                verticalCenter: parent.verticalCenter
            }
        }

        // 数值显示区（示例：带单位）
        Text
        {
            text: qsTr("3333333333333") // 此处应绑定实际数据
            font
            {
                pixelSize: 18
                bold: true
            }
            color: "#2196F3"
            anchors.centerIn: parent
        }

        // 图标
        // Image
        // {
        //     visible: false
        //     source: modelData.source
        //     anchors
        //     {
        //         right: parent.right
        //         top: parent.top
        //         margins: 5
        //     }
        //     width: 24
        //     height: 24
        // }
    }
    Rectangle
    {
        width: parent.width   - 10
        height: srcDict.scaled(30)
        color: "transparent"

        // 参数名称
        Text
        {
            text: "固件版本"
            font.pixelSize: 14
            color: "#666666"
            anchors
            {
                left: parent.left
                leftMargin: srcDict.scaled(30)
                verticalCenter: parent.verticalCenter
            }
        }
        // 数值显示区（示例：带单位）
        Text
        {
            text: qsTr("V 1.0") // 此处应绑定实际数据
            font
            {
                pixelSize: 18
                bold: true
            }
            color: "#2196F3"
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        width: parent.width   - 10
        height: srcDict.scaled(30)
        color: "transparent"

        // 参数名称
        Text
        {
            text: "电池类型"
            font.pixelSize: 14
            color: "#666666"
            anchors
            {
                left: parent.left
                leftMargin: srcDict.scaled(30)
                verticalCenter: parent.verticalCenter
            }
        }
        // 数值显示区（示例：带单位）
        Text
        {
            text: qsTr("磷酸铁锂") // 此处应绑定实际数据
            font
            {
                pixelSize: 18
                bold: true
            }
            color: "#2196F3"
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        width: parent.width   - 10
        height: srcDict.scaled(30)
        color: "transparent"

        // 参数名称
        Text
        {
            text: "电池串数"
            font.pixelSize: 14
            color: "#666666"
            anchors
            {
                left: parent.left
                leftMargin: srcDict.scaled(30)
                verticalCenter: parent.verticalCenter
            }
        }
        // 数值显示区（示例：带单位）
        Text
        {
            text: qsTr("24") // 此处应绑定实际数据
            font
            {
                pixelSize: 18
                bold: true
            }
            color: "#2196F3"
            anchors.centerIn: parent
        }
    }
    Rectangle
    {
        width: parent.width   - 10
        height: srcDict.scaled(30)
        color: "transparent"

        // 参数名称
        Text
        {
            text: "BMS时间"
            font.pixelSize: 14
            color: "#666666"
            anchors
            {
                left: parent.left
                leftMargin: srcDict.scaled(30)
                verticalCenter: parent.verticalCenter
            }
        }
        // 数值显示区（示例：带单位）
        Text
        {
            text: qsTr("2025-01-01 00:00") // 此处应绑定实际数据
            font
            {
                pixelSize: 18
                bold: true
            }
            color: "#2196F3"
            anchors.centerIn: parent
        }
    }

}
