
import QtQuick
import QtQuick.Controls

Page {
    property var soc: srcDict.soc
    property var soh: srcDict.soh
    property var cellList: srcDict.cellVlist

    background: Rectangle
    {
        color: "transparent"
    }
    title: qsTr("Ultra BMS")

    onCellListChanged:
    {
        if(cellList === undefined)
        {
            return
        }
        batteryModel.clear();
        for (var i = 0; i < cellList.length; i++)
        {
            // console.log(i, cellList[i])
            var voltage = String(cellList[i].toFixed(2)) + "V"; // 结果: "3.14"
            // batteryModel.setProperty(i, "typeData", str)
            batteryModel.append({
                        text: "" + (i + 1),
                        imgSrc: "../res/danCell.svg",
                        typeData: voltage
                    });
        }
    }
    ListModel {
        id: batteryModel
        // Component.onCompleted:
        // {
        //     for (var i = 0; i < (srcDict.cellNum === undefined ? 0:srcDict.cellNum); i++)
        //     {

        //         append({text: "" + (i + 1), imgSrc: "../res/danCell.svg", typeData: ""})
        //     }
        // }
    }
    LoadingIndicator
    {
        id: loadRect
        anchors.centerIn: parent
        width: srcDict.scaled(300)  // 自定义尺寸
        height: srcDict.scaled(150)
        z: 999
        bgColor: "#CC303030"  // 自定义背景色
        textColor: "#00FF00"   // 自定义文字颜色
        iconColor: "#FFA500"   // 橙色加载图标
        text: qsTr("刷新中，请稍后") // 自定义提示内容
    }
    property bool isTriggered: false
    // 主内容容器
    Flickable
    {
        id: flickable
        anchors.fill: parent
        contentHeight: contentColumn.height // 动态计算总高度
        clip: true
        flickDeceleration: 500
        onContentYChanged:
        {
            // 当下拉超过顶部时触发（contentY为负值）
            if(contentY < -100 && !isTriggered && !loadRect.visible)
            {
                console.log("下拉到位")
                isTriggered = true
            }
        }
        onMovementEnded:
        {

            if(isTriggered && !loadRect.visible)
            {
                console.log("下拉结束")
                srcDict.sendToBlue(24)
                srcDict.getProtectMessage(1)
                loadRect.startLoad()
            }

            isTriggered = false  // 重置状态
        }
        // 下拉提示层
        Rectangle
        {
            id: refreshHeader
            width: parent.width
            height: srcDict.scaled(60)
            y: -height
            visible: flickable.contentY < -20
            color: "transparent"
            // 渐显动画
            opacity: Math.min(1, -flickable.contentY/height)
            Behavior on opacity { NumberAnimation { duration: 200 } }
            Text
            {
                anchors.centerIn: parent
                text: flickable.contentY < -50 ? "松开刷新" : "下拉刷新"
                color: "white"
                font.pixelSize: 18
            }
        }
        Column
        { // 垂直布局所有内容块
            id: contentColumn
            width: parent.width

            InfoGridOne
            {
            }

            // InfoGridLang
            // {
            // }

            // 电池信息
            InfoGrid
            {
                title: qsTr("电池信息")
                modelData: [
                    {text: qsTr("总电压"), source: "", data: srcDict.electYa === undefined ? "" : String(srcDict.electYa) + "V"},
                    {text: qsTr("总电流"), source: "", data: srcDict.electLiu === undefined ? "" : String(srcDict.electLiu) + "A"},
                    {text: qsTr("压差"), source: "", data: srcDict.yaCha === undefined ? "" : String(srcDict.yaCha) + "V"},
                    {text: qsTr("最高电压"), source: "", data: srcDict.maxYa === undefined ? "" : String(srcDict.maxYa) + "V"},
                    {text: qsTr("最低电压"), source: "", data: srcDict.minYa === undefined ? "" : String(srcDict.minYa) + "V"},
                    {text: qsTr("循环次数"), source: "", data: srcDict.cycles_number === undefined ? "" : srcDict.cycles_number},
                    {text: qsTr("功率"), source: "", data: srcDict.electYa === undefined ? "" : String((parseFloat(srcDict.electYa) * parseFloat(srcDict.electLiu)).toFixed(2)) + "W"},
                ]
            }

            // 温度信息模块
            InfoGrid
            {
                title: "温度信息"
                modelData: [
                    {text: qsTr("MOS温度"), source: "", data: srcDict.mosTemperature === undefined ? "" : (srcDict.mosTemperature + "℃")},
                    {text: qsTr("T1温度"), source: "", data: srcDict.temperature1 === undefined ? "" : (srcDict.temperature1+ "℃")},
                    {text: qsTr("T2温度"), source: "", data: srcDict.temperature2 === undefined ? "" : (srcDict.temperature2+ "℃")},
                    {text: qsTr("T3温度"), source: "", data: srcDict.temperature3 === undefined ? "" : (srcDict.temperature3)}
                ]
            }

            // 电池单体电压
            Rectangle
            {
                width: parent.width
                height: batteryGrid.height + srcDict.scaled(40)
                color: "transparent"

                // 标题
                Text
                {
                    text: qsTr("单体电压")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: 10
                    color: "white"
                }

                // 电池单元专用网格布局
                GridView
                {
                    id: batteryGrid
                    width: parent.width
                    height: Math.ceil(model.count / 5) * cellHeight // 动态计算高度
                    anchors.top: parent.top
                    anchors.topMargin: srcDict.scaled(40)
                    cellWidth: width / 5   // 关键：每行5个
                    cellHeight: srcDict.scaled(90)
                    interactive: false     // 禁用独立滚动

                    model:batteryModel

                    delegate: Rectangle {
                        width: batteryGrid.cellWidth
                        height: batteryGrid.cellHeight
                        color: "transparent"
                        // border.color: "red"

                        Text
                        {
                            text: model.text
                            font.pixelSize: 20
                            anchors.left: parent.left
                            anchors.leftMargin: srcDict.scaled(10)
                            anchors.top: parent.top
                            color: "white"
                        }
                        Text
                        {
                            text: model.typeData
                            font.pixelSize: 16
                            color: "white"
                            anchors.left: parent.left
                            anchors.leftMargin: srcDict.scaled(15)
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: srcDict.scaled(20)
                            // anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Image
                        {
                            source: model.imgSrc
                            // anchors.right: parent.right
                            // anchors.verticalCenter : parent.verticalCenter
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width - 10
                            height: srcDict.scaled(70)
                        }
                    }
                }
            }
        }
    }
}
