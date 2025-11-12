import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Page
{
    property var realProtect: srcDict.protectMap
    title: qsTr("电池信息")
    background: Rectangle
    {
        anchors.fill: parent
        color: "transparent"
    }
    Component.onCompleted:
    {
        srcDict.sendToBlue(-560)
        srcDict.sendToBlue(-566)
        srcDict.sendToBlue(24)
        srcDict.sendToBlue(19)
        srcDict.sendToBlue(-536)
        srcDict.sendToBlue(-570)
        srcDict.sendToBlue(-582)
        srcDict.sendToBlue(-586)
        srcDict.sendToBlue(-598)
        srcDict.sendToBlue(-1024)
        srcDict.sendToBlue(-1026)
        srcDict.sendToBlue(-1032)
        srcDict.sendToBlue(27)
        srcDict.sendToBlue(28)
        srcDict.sendToBlue(29)
        srcDict.sendToBlue(30)
        srcDict.getProtectMessage(2)
    }

    Flickable
    {
        id: root
        width: srcDict.winWidth
        anchors.fill: parent
        contentHeight: contentColumn.height // 动态计算总高度
        clip: true
        ColumnLayout
        {
            id: contentColumn
            width: Math.max(implicitWidth, root.width)
            spacing: 20

            // 电池信息部分
            ColumnLayout
            {
                Layout.margins: 20
                spacing: 10
                id: columnLayout  // 添加 id

                function getCellType(type)
                {

                    if(type === undefined)
                    {
                        return qsTr("")
                    }
                    if(type === 0)
                    {
                        return qsTr("磷酸铁锂")
                    }
                    else if(type === 1)
                    {
                        return qsTr("三元")
                    }
                    else if(type === 2)
                    {
                        return qsTr("钛酸锂")
                    }
                    else if(type === 3)
                    {
                        return qsTr("钠电池")
                    }
                }
                GridLayout
                {
                    columns: 2
                    columnSpacing: srcDict.scaled(20)
                    rowSpacing: 8

                    // 电池信息项
                    Text { text: qsTr("电池 SN"); font.bold: true; color: "white" }
                    Text { text: srcDict.sn === undefined ? "" : srcDict.sn; color: "white" }

                    Text { text: qsTr("制造厂家"); font.bold: true ; color: "white" }
                    Text { text: srcDict.manufacturer === undefined ? "" : srcDict.manufacturer; color: "white"}

                    Text { text: qsTr("制造厂商型号"); font.bold: true; color: "white"  }
                    Text { text: srcDict.manufacturerMode === undefined ? "" : srcDict.manufacturerMode; color: "white" }

                    Text { text: qsTr("客户名称"); font.bold: true; color: "white"  }
                    Text { text: srcDict.customerName === undefined ? "" : srcDict.customerName; color: "white"}

                    Text { text: qsTr("客户型号"); font.bold: true; color: "white"  }
                    Text { text: srcDict.customerMode === undefined ? "" : srcDict.customerMode; color: "white"}

                    Text { text: qsTr("生产日期"); font.bold: true; color: "white"  }
                    Text { text: srcDict.mnfDate === undefined ? "" : srcDict.mnfDate; color: "white"  }

                    Text { text: qsTr("固件版本"); font.bold: true; color: "white"  }
                    Text { text: srcDict.mainVer === undefined ? "" : srcDict.mainVer; color: "white"  }

                    Text { text: qsTr("电池类型"); font.bold: true; color: "white"  }
                    Text { text: columnLayout.getCellType(srcDict.celllType); color: "white"  }

                    Text { text: qsTr("电池串数"); font.bold: true; color: "white"  }
                    Text { text: srcDict.cellNum === undefined ? 0 : srcDict.cellNum; color: "white"  }


                    Text { text: qsTr("BMS时间"); font.bold: true; color: "white"  }
                    Text { text: qsTr("2025-01-01 00:00"); color: "white"  }

                    Text { text: qsTr("设计循环次数"); font.bold: true; color: "white"  }
                    Text { text: srcDict.sjCirCount === undefined ? "" : srcDict.sjCirCount; color: "white"  }

                    Text { text: qsTr("參考容值"); font.bold: true; color: "white"  }
                    Text { text: srcDict.fcc === undefined ? "" :String(srcDict.fcc); color: "white"  }

                    Text { text: qsTr("设计容量"); font.bold: true; color: "white"  }
                    Text { text: srcDict.dc === undefined ? "" : String(srcDict.dc ); color: "white"  }

                    Text { text: qsTr("最大未充电间隔时间"); font.bold: true; color: "white"  }
                    Text { text: srcDict.maxNoElect === undefined ? "" : srcDict.maxNoElect ; color: "white" }

                    Text { text: qsTr("最近未充电间隔时间"); font.bold: true; color: "white"  }
                    Text { text: srcDict.majNoElect === undefined ? "" : srcDict.majNoElect; color: "white"  }

                    Text { text: qsTr("BT码"); font.bold: true; color: "white"  }
                    Text { text: srcDict.bt === undefined ? "" : srcDict.bt; color: "white" ; font.pixelSize: 13 }

                }
            }


            // ================ 保护事件表格 =================
            // ColumnLayout
            // {
            //     Layout.fillWidth: true
            //     spacing: 10

            //     // —— 表头 ——
            //     RowLayout {
            //         Layout.leftMargin: 20
            //         Layout.rightMargin: 20
            //         spacing: 0

            //         Text {
            //             text: qsTr("保护时间")
            //             font.bold: true
            //             color: "white"
            //             Layout.preferredWidth: srcDict.scaled(200)
            //             horizontalAlignment: Text.AlignLeft
            //         }
            //         Text {
            //             text: qsTr("保护事件")
            //             font.bold: true
            //             color: "white"
            //             Layout.fillWidth: true
            //             horizontalAlignment: Text.AlignLeft
            //         }
            //     }

            //     // —— 用 Column + Repeater 来替代 ListView ——
            //     Column
            //     {
            //         id: eventContainer
            //         width: parent.width
            //         spacing: 2

            //         Repeater
            //         {
            //             model: eventModel

            //             RowLayout {
            //                 width: eventContainer.width
            //                 height: srcDict.scaled(30)   // 每行高度
            //                 spacing: 0

            //                 Text
            //                 {
            //                     text: model.eventTime
            //                     Layout.preferredWidth: srcDict.scaled(200)
            //                     leftPadding: 20
            //                     color: "white"
            //                     verticalAlignment: Text.AlignVCenter
            //                 }
            //                 Text
            //                 {
            //                     text: model.eventCode
            //                     Layout.fillWidth: true
            //                     color: "white"
            //                     verticalAlignment: Text.AlignVCenter
            //                 }
            //                 Rectangle
            //                 {
            //                     height: 1
            //                     color: "#eee"
            //                     Layout.fillWidth: true
            //                 }
            //             }
            //         }
            //     }
            // }
            GridLayout
            {
                columns: 2
                columnSpacing: 0
                rowSpacing: 0
                width: parent.width

                // 表头
                Text {
                    text: qsTr("保护时间")
                    font.bold: true
                    color: "white"
                    Layout.preferredWidth: srcDict.scaled(200)
                    leftPadding: 20
                    Layout.row: 0
                    Layout.column: 0
                }
                Text {
                    text: qsTr("保护事件")
                    font.bold: true
                    color: "white"
                    Layout.fillWidth: true
                    Layout.row: 0
                    Layout.column: 1
                }

                // 数据行
                Repeater
                {
                    model: eventModel

                    Column {
                        Layout.columnSpan: 2
                        Layout.fillWidth: true

                        RowLayout {
                            width: parent.width
                            height: srcDict.scaled(30)

                            Text {
                                text: model.eventTime
                                Layout.preferredWidth: srcDict.scaled(200)
                                leftPadding: 20
                                color: "white"
                            }
                            Text {
                                text: model.eventCode
                                Layout.fillWidth: true
                                color: "white"
                            }
                        }

                        Rectangle {
                            width: parent.width
                            height: 1
                            color: "#444"
                        }
                    }
                }
            }
        }


    }
    ListModel
    {
        id: eventModel
    }
    // 动态添加数据的方法
    function addEvent(time, code)
    {
        eventModel.append({"eventTime": time, "eventCode": code})
    }
    onRealProtectChanged:
    {
        if(realProtect === undefined)
        {
            return
        }
        addEvent(realProtect.protectTime, realProtect.protectEvent)
    }
}
