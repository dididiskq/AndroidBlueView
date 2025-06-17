import QtQuick 2.5
import QtQuick.Controls
import QtQuick.Layouts
Page
{
    background: Rectangle
    {
        color: "transparent"
    }
    Component.onCompleted:
    {
        srcDict.sendToBlue(-532)
        srcDict.sendToBlue(-533)
        srcDict.sendToBlue(-534)
    }
    title: qsTr("均衡参数")
    ParameterPage
    {
        anchors
        {
            top: parent.top
            topMargin: srcDict.scaled(20)

        }
        width: parent.width
        paramList: [
            { name: qsTr("均衡启动电压"), value: srcDict.vob === undefined ? 0 : srcDict.vob, unit: "mV", cellData:532 },
            { name: qsTr("均衡启动阈值"), value: srcDict.bald === undefined ? 0 : srcDict.bald, unit: "mV", cellData:533 },
            { name: qsTr("均衡延时"),  value: srcDict.balt === undefined ? 0 : srcDict.balt, unit: "ms", cellData:534 },
        ]
    }
}
