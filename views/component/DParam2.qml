import QtQuick 2.5
import QtQuick.Controls
import QtQuick.Layouts
Page
{
    background: Rectangle
    {
        color: "transparent"
    }
    title: qsTr("电压参数")
    Component.onCompleted:
    {
        //获取本页面数据
        srcDict.sendToBlue(-528)
        srcDict.sendToBlue(-529)
        srcDict.sendToBlue(-535)
        srcDict.sendToBlue(-536)
    }

    ParameterPage
    {
        width: parent.width
        paramList: [
            { name: qsTr("过充保护电压"), value: srcDict.ov === undefined ? 0 : srcDict.ov, unit: "mV" , cellData: 528},
            { name: qsTr("过充回复电压"), value: srcDict.ovr === undefined ? 0 : srcDict.ov, unit: "mV" , cellData: 529},
            { name: qsTr("过放保护电压"),  value: srcDict.uv === undefined ? 0 : srcDict.uv, unit: "mV", cellData: 535},
            { name: qsTr("过放恢复电压"),  value: srcDict.uvr === undefined ? 0 : srcDict.uvr, unit: "mV", cellData: 536},
        ]
    }
}
