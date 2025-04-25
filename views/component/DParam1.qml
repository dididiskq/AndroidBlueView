import QtQuick 2.5
import QtQuick.Controls
import QtQuick.Layouts
Page
{
    background: Rectangle
    {
        color: "transparent"  // 完全透明
    }
    title: qsTr("快速设置")
    // Connections
    // {
    //     target: context
    //     function onMySignal(message)
    //     {
    //         if(message === "66")
    //         {
    //             // print("改写成功")
    //         }
    //         else if(message === "-66")
    //         {
    //             // print("改写超时")
    //         }
    //         else if(message === "-67")
    //         {
    //             // print("服务或特征无效")
    //         }
    //     }
    // }
    Column
    {
        id: colArea
        spacing: 10
        anchors
        {
            top: parent.top
            topMargin: srcDict.scaled(50)
            horizontalCenter: parent.horizontalCenter
        }
        Rectangle
        {
            height: srcDict.scaled(60)
            width: srcDict.scaled(300)
            color: "#E4DDDD"
            radius: 10
            Label
            {
                text: qsTr("一键铁锂参数")
                anchors.centerIn: parent
                font.pixelSize: 16
                color: "#666666"
            }
        }

        Rectangle
        {
            height: srcDict.scaled(60)
            width: srcDict.scaled(300)
            color: "#E4DDDD"
            radius: 10
            Label
            {
                text: qsTr("一键三元参数")
                anchors.centerIn: parent
                font.pixelSize: 16
                color: "#666666"
            }
        }


        Rectangle
        {
            height: srcDict.scaled(60)
            width: srcDict.scaled(300)
            color: "#E4DDDD"
            radius: 10
            Label
            {
                text: qsTr("一键钠离子参数")
                anchors.centerIn: parent
                font.pixelSize: 16
                color: "#666666"
            }
        }
    }
    Component.onCompleted:
    {
        //获取本页面数据
        srcDict.sendToBlue(24)
        srcDict.sendToBlue(27)

    }

    // 示例页面：ChargeParamsPage.qml
    ParameterPage
    {
        anchors.top: colArea.bottom
        anchors.topMargin: srcDict.scaled(20)
        width: parent.width
        paramList: [
            { name: qsTr("电池实际串数"), value: srcDict.cellNum === undefined ? 0 : srcDict.cellNum, unit: "串" , cellData: 512},
            { name: qsTr("电池物理容量"), value: srcDict.fcc === undefined ? 0 : srcDict.fcc/100, unit: "AH" , cellData: 1026}
        ]
    }

}
