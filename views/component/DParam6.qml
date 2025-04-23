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
        srcDict.sendToBlue(-520)
        srcDict.sendToBlue(-521)
        srcDict.sendToBlue(-518)
        srcDict.sendToBlue(-519)
        srcDict.sendToBlue(-524)
        srcDict.sendToBlue(-522)
        srcDict.sendToBlue(-523)
        srcDict.sendToBlue(-525)
    }
    title: qsTr("系统参数")
    ParameterPage
    {
        width: parent.width
        paramList: [
            { name: qsTr("额定充电电压"), value: srcDict.eYa === undefined ? 0 : srcDict.eYa, unit: "0.1V", cellData:520 },
            { name: qsTr("额定充电电流"), value: srcDict.eLiu === undefined ? 0 : srcDict.eLiu, unit: "0.1A", cellData:521 },
            { name: qsTr("休眠延时"),  value: srcDict.sleepDelay === undefined ? 0 : srcDict.sleepDelay, unit: "s", cellData:518 },
            { name: qsTr("关机延时"),  value: srcDict.shutDownDelay === undefined ? 0 : srcDict.shutDownDelay, unit: "s", cellData:519 },
            { name: qsTr("满充延时"), value: srcDict.manYshi === undefined ? 0 : srcDict.manYshi, unit: "s", cellData:524 },
            { name: qsTr("满充电压"), value: srcDict.mYa === undefined ? 0 : srcDict.mYa, unit: "mV", cellData:522 },
            { name: qsTr("满充电流"),  value: srcDict.mcLiu === undefined ? 0 : srcDict.mcLiu, unit: "mA", cellData:523 },
            { name: qsTr("零电流显示阈值"),  value: srcDict.lingYuzhi === undefined ? 0 : srcDict.lingYuzhi, unit: "mA", cellData:525 },
        ]
    }
}

