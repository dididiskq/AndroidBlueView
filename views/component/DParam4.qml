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
        srcDict.sendToBlue(-544)
        srcDict.sendToBlue(-545)
        srcDict.sendToBlue(-538)
        srcDict.sendToBlue(-539)
        srcDict.sendToBlue(-540)
        srcDict.sendToBlue(-541)
        srcDict.sendToBlue(-542)
        srcDict.sendToBlue(-543)
        srcDict.sendToBlue(-526)
    }
    title: qsTr("电流参数")
    ParameterPage
    {
        width: parent.width
        paramList: [
            { name: qsTr("充电过流1保护电流"), value: srcDict.occ === undefined ? 0 : srcDict.occ, unit: "A", cellData:544},
            { name: qsTr("充电过流1延时"), value: srcDict.occt === undefined ? 0 : srcDict.occt, unit: "ms", cellData:545},
            { name: qsTr("放电过流1保护电流"),  value: srcDict.ocd1 === undefined ? 0 : srcDict.ocd1, unit: "A", cellData:538},
            { name: qsTr("放电过流1延时"),  value: srcDict.ocd1t === undefined ? 0 : srcDict.ocd1t, unit: "ms" , cellData:539},
            { name: qsTr("放电过流2保护电流"), value: srcDict.ocd2 === undefined ? 0 : srcDict.ocd2, unit: "A" , cellData:540},
            { name: qsTr("放电过流2延时"), value: srcDict.ocd2t === undefined ? 0 : srcDict.ocd2t, unit: "ms" , cellData:541},
            { name: qsTr("短路保护电流"),  value: srcDict.dbYa === undefined ? 0 : srcDict.dbYa, unit: "A", cellData:542 },
            { name: qsTr("短路保护延时"),  value: srcDict.sct === undefined ? 0 : srcDict.sct, unit: "us" , cellData:543},
            { name: qsTr("采样电阻值"),  value: srcDict.sampleRValue === undefined ? 0 : srcDict.sampleRValue, unit: "mΩ", cellData:526 },
        ]
    }
}
