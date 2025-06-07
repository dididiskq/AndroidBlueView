import QtQuick 2.5
import QtQuick.Controls

Page
{
    id: pageMain
    property var realTimer: mainPageTimer

    signal hidenTabbar(var type)
    background: Rectangle
    {

        color: "transparent"  // 完全透明
    }
    Timer
    {
        id: mainPageTimer
        interval: 0       // 初始立即触发
        repeat: false     // 首次不重复
        onTriggered:
        {
            if(srcDict.currentPageIndex !== 2)
            {
                return
            }
            srcDict.timerGetData(2)
            // sendDataToBlue()

            // 调整间隔和重复模式
            interval = 3000
            repeat = true
            start()
        }
    }

    StackView
    {
        id: stackView1
        anchors.fill: parent
        initialItem: mainView
    }
    function getStatus()
    {
        var res
        if(srcDict.cMos === 1)
        {
            res = qsTr("正在充电")
        }
        else if(srcDict.fMos === 1)
        {
            res = qsTr("正在放电")
        }
        else
        {
            res = qsTr("")
        }

        return res
    }

    function sendDataToBlue()
    {
        srcDict.sendToBlue(20)
        srcDict.sendToBlue(4)
        srcDict.sendToBlue(6)
        srcDict.sendToBlue(0)
        srcDict.sendToBlue(1)
        srcDict.sendToBlue(2)
        srcDict.sendToBlue(8)
        srcDict.sendToBlue(12)
        srcDict.sendToBlue(14)
        srcDict.sendToBlue(15)
        srcDict.sendToBlue(26)
        srcDict.sendToBlue(27)
    }

    property bool isTriggered: false
    Page
    {
        id: mainView
        background: Rectangle
        {
            id: rectBg
            // color: "white"
            color: "transparent"  // 完全透明
        }
        Component.onCompleted:
        {

        }
        Component.onDestruction:
        {

        }
        //标题
        Rectangle
        {
            id: appName

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: srcDict.scaled(42)
            width: srcDict.scaled(80)
            height: srcDict.scaled(40)
            color: "transparent"
            Label
            {
                text: qsTr("Ultra BMS")
                color: "#33C3FF"
                font.pixelSize: 25
                anchors.centerIn: parent
            }
        }
        Rectangle
        {
            id: buttonSacn

            anchors.left: parent.left
            anchors.leftMargin: srcDict.scaled(10)
            border.color: "white"
            radius: 10
            z: 1
            y: srcDict.scaled(42)
            width: srcDict.scaled(110)
            height: srcDict.scaled(40)
            color: "transparent"
            Label
            {
                text: qsTr("设备列表")
                color: "white"
                font.pixelSize: 25
                anchors.centerIn: parent
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    mainPageTimer.stop()
                    // myLoader.source = "./component/BlueList.qml"
                    stackView1.push("BlueList.qml")
                }
            }
        }
        Rectangle
        {
            id: buttonCode

            anchors.right: parent.right
            anchors.rightMargin: srcDict.scaled(20)
            y: srcDict.scaled(42)
            width: srcDict.scaled(80)
            height: srcDict.scaled(40)
            color: "transparent"
            z: 1
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    hidenTabbar(1)
                    // mainPageTimer.stop()
                    srcDict.sendCodeData(1)
                    // cameraRect.visible = true
                    // cameraRect.capReal.camera.start()
                    stackView1.push("CamerView.qml")
                }
            }

            Image
            {
                width: srcDict.scaled(40)
                height: srcDict.scaled(40)
                anchors.centerIn: parent
                source: "../res/sacn.svg"
            }
        }
        // CamerView
        // {
        //     id: cameraRect
        //     anchors.fill: parent
        //     visible: false
        //     onReturnPage:
        //     {
        //         hidenTabbar(0)
        //         cameraRect.visible = false
        //         capReal.camera.stop()
        //         mainPageTimer.start()
        //     }
        // }

        Connections
        {
            target: context
            function onMySignal(message)
            {
                if(message === "firstLoadStart")
                {
                    loadRect.text = "数据加载中..."
                    loadRect.visible = true
                }
                else if(message === "firstLoadEnd")
                {
                    loadRect.visible = false
                }
            }
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
        Flickable
        {
            id: flickable

            width: parent.width
            height: parent.height - 5
            contentHeight:  parent.height
            clip: true

            // onContentYChanged:
            // {
            //     // 当下拉超过顶部时触发（contentY为负值）
            //     if(contentY < -100 && !isTriggered && !loadRect.visible) {
            //         // console.log("下拉到位")
            //         isTriggered = true
            //     }
            // }
            // onMovementEnded:
            // {

            //     if(isTriggered && !loadRect.visible)
            //     {
            //         // console.log("下拉结束")
            //         loadRect.startLoad(3000)
            //     }

            //     isTriggered = false  // 重置状态
            // }
            // 下拉提示层
            // Rectangle
            // {
            //     id: refreshHeader
            //     width: parent.width
            //     height: srcDict.scaled(60)
            //     y: srcDict.scaled(30)
            //     visible: flickable.contentY < -20
            //     color: "transparent"
            //     // 渐显动画
            //     opacity: Math.min(1, -flickable.contentY/height)
            //     Behavior on opacity { NumberAnimation { duration: 200 } }
            //     Text
            //     {
            //         anchors.centerIn: parent
            //         text: flickable.contentY < -50 ? "松开刷新" : "下拉刷新"
            //         color: "white"
            //         font.pixelSize: 18
            //     }
            // }
            BatteryArc
            {

                anchors.top: parent.top
                // anchors.left: parent.left
                anchors.topMargin: srcDict.scaled(170)
                // anchors.leftMargin: srcDict.scaled(45)
                anchors.horizontalCenter: parent.horizontalCenter
                progress: (srcDict.soc === undefined ? 0 : srcDict.soc * 0.01)
                lineWidth: srcDict.scaled(10)
                backgroundColor: "#7A7E7D"
                progressColor: "white"
                textPrefix: getStatus()// 可调整线宽
                z: 1
            }
            Rectangle
            {

                height: parent.width / 1.88
                width: parent.width
                anchors.top: parent.top
                anchors.topMargin: srcDict.scaled(160)
                anchors.horizontalCenter: parent.horizontalCenter
                // border.color: "red"
                Image
                {

                    anchors.fill: parent
                    source: "../res/111.svg"
                }
            }

            // //总容量
            Rectangle
            {
                // border.color: "red"
                color: "transparent"

                height: srcDict.scaled(30)
                width: srcDict.scaled(100)
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: srcDict.scaled(40)
                anchors.topMargin: srcDict.scaled(370)
                Label
                {
                    id: lab1
                    text: qsTr("总容量")
                    color: "white"
                    font.pixelSize: 12
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
                Label
                {
                    // text: String(srcDict.fcc === undefined ? "0" : srcDict.fcc)+ "AH"
                    text: String(srcDict.fcc !== undefined ? (srcDict.fcc / 100).toFixed(2) : "0.00") + "AH"
                    color: "white"
                    font.pixelSize: 12
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: lab1.right
                    anchors.leftMargin: srcDict.scaled(10)
                }
            }

            //剩余容量
            Rectangle
            {
                // border.color: "red"
                color: "transparent"

                height: srcDict.scaled(30)
                width: srcDict.scaled(100)
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: srcDict.scaled(40)
                anchors.topMargin: srcDict.scaled(370)
                Label
                {
                    id: lab2
                    text: qsTr("剩余容量")
                    color: "white"
                    font.pixelSize: 12
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
                Label
                {
                    color: "white"
                    font.pixelSize: 12
                    font.bold: true
                    // text: String(srcDict.remaining_capacity === undefined ? "0" : srcDict.remaining_capacity) + "AH"
                    text: String(srcDict.remaining_capacity !== undefined ? (srcDict.remaining_capacity / 1000).toFixed(2) : "0.00") + "AH"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: lab2.right
                    anchors.leftMargin: srcDict.scaled(10)
                }
            }
            // 总电压
            Rectangle
            {
                color: "transparent"

                height: parent.height * 0.16
                width: height + srcDict.scaled(10)

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: srcDict.scaled(20)
                anchors.topMargin: srcDict.scaled(410)
                Image
                {
                    anchors.fill: parent
                    source: "../res/102.svg"
                }
                Text
                {
                    anchors.centerIn: parent
                    font.pixelSize: 20
                    color: "white"
                    text: String(srcDict.electYa === undefined ? "0" : srcDict.electYa) + " V"
                }

                Label
                {
                    anchors
                    {
                        top: parent.top
                        topMargin: srcDict.scaled(25)
                        horizontalCenter:parent.horizontalCenter
                    }
                    color: "white"
                    text: qsTr("电压")
                }
            }
            // 电流
            Rectangle
            {

                color: "transparent"
                height: parent.height * 0.16
                width: height + 10
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: srcDict.scaled(20)
                anchors.topMargin: srcDict.scaled(410)
                Image
                {
                    anchors.fill: parent
                    source: "../res/103.svg"
                }
                Text
                {
                    anchors.centerIn: parent
                    font.pixelSize: 20
                    color: "white"
                    text: String(srcDict.electLiu === undefined ? "0" : srcDict.electLiu) + " A"
                }
                Label
                {
                    anchors
                    {
                        top: parent.top

                        topMargin: srcDict.scaled(25)
                        horizontalCenter:parent.horizontalCenter
                    }
                    color: "white"
                    text: qsTr("电流")
                }
            }


            Rectangle
            {
                id: param1Rect
                radius: 10

                color: "transparent"
                height: srcDict.scaled(100)
                width: parent.width - srcDict.scaled(40)
                anchors.top: parent.top
                anchors.topMargin: srcDict.scaled(540)
                anchors.horizontalCenter: parent.horizontalCenter
                Image
                {
                    anchors.fill: parent
                    source: "../res/1081.svg"
                }
                Rectangle
                {
                    id: warm1
                    color: "transparent"
                    height: parent.height
                    anchors.left: parent.left
                    anchors.verticalCenter: param1Rect.verticalCenter
                    width: param1Rect.width / 4
                    // border.color: "red"
                    Image
                    {
                        id: img1
                        height: srcDict.scaled(50)
                        width: srcDict.scaled(50)
                        anchors.horizontalCenter: warm1.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        source: "../res/warm.svg"
                    }
                    Label
                    {
                        anchors.top: img1.bottom
                        text: qsTr("电池温度")
                        color: "white"
                        anchors.horizontalCenter: warm1.horizontalCenter
                    }
                }
                Rectangle
                {
                    id: warm2
                    color: "transparent"
                    height: parent.height
                    anchors.left: warm1.right
                    width: param1Rect.width / 4
                    // border.color: "red"
                    Label
                    {
                        anchors.top: parent.top
                        anchors.topMargin: srcDict.scaled(20)
                        font.pixelSize: 20
                        text: qsTr("T1")
                        color: "white"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Label
                    {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: srcDict.scaled(10)
                        color: "white"
                        font.pixelSize: 20
                        text: srcDict.temperature1 === undefined ? "" : (srcDict.temperature1 + "℃")
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                Rectangle
                {
                    id: warm3
                    color: "transparent"
                    height: parent.height
                    width: param1Rect.width / 4
                    anchors.left: warm2.right
                    // border.color: "red"
                    Label
                    {
                        anchors.top: parent.top
                        anchors.topMargin: srcDict.scaled(20)
                        font.pixelSize: 20
                        text: qsTr("T2")
                        color: "white"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Label
                    {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: srcDict.scaled(10)
                        color: "white"
                        font.pixelSize: 20
                        text: srcDict.temperature2 === undefined ? "" : (srcDict.temperature2 + "℃")
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                Rectangle
                {
                    id: warm4
                    color: "transparent"
                    height: parent.height
                    width: param1Rect.width / 4
                    // border.color: "red"
                    anchors.left: warm3.right
                    Label
                    {
                        anchors.top: parent.top
                        anchors.topMargin: srcDict.scaled(20)
                        font.pixelSize: 20
                        text: qsTr("mos")
                        color: "white"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Label
                    {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: srcDict.scaled(10)
                        color: "white"
                        font.pixelSize: 20
                        text: srcDict.mosTemperature === undefined ? "" : (srcDict.mosTemperature  + "℃")
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

            }
            Rectangle
            {
                id: param2Rect
                radius: 10

                color: "transparent"
                height: srcDict.scaled(100)
                width: parent.width - srcDict.scaled(40)
                anchors.top: param1Rect.bottom
                anchors.topMargin: srcDict.scaled(10)
                anchors.horizontalCenter: parent.horizontalCenter
                Image
                {
                    anchors.fill: parent
                    source: "../res/1081.svg"
                }

                Rectangle
                {
                    id: bao1
                    color: "transparent"
                    height: parent.height
                    anchors.left: parent.left
                    anchors.verticalCenter: param2Rect.verticalCenrter
                    width: param2Rect.width / 3
                    // border.color: "red"
                    Image
                    {
                        id: img
                        height: srcDict.scaled(50)
                        width: srcDict.scaled(50)
                        // anchors.verticalCenter: bao1.verticalCenter
                        anchors.top: parent.top
                        anchors.topMargin: srcDict.scaled(20)
                        anchors.left: parent.left
                        anchors.leftMargin: srcDict.scaled(20)
                        source: "../res/jingbao.svg"
                    }
                    Label
                    {
                        anchors.top: img.bottom
                        text: qsTr("异常警报")
                        anchors.left: parent.left
                        anchors.leftMargin: srcDict.scaled(20)
                        color: "white"
                    }
                    Label
                    {
                        anchors.right: parent.right
                        anchors.rightMargin: srcDict.scaled(25)
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: img.right
                        font.pixelSize: 20
                        text: srcDict.alarmCount === undefined ? "0" : String(srcDict.alarmCount)
                    }
                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked:
                        {
                            stackView1.push("AlarmMsgPage.qml")
                            // if(srcDict.alarmlStatus === undefined || srcDict.alarmlStatus === "")
                            // {
                            //     return
                            // }
                            // else
                            // {

                            // }
                        }
                    }

                }
                Rectangle
                {
                    id: bao2
                    color: "transparent"
                    height: parent.height
                    anchors.left: bao1.right
                    width: param2Rect.width / 3
                    // border.color: "red"
                    Image
                    {
                        id: imgCir
                        height: srcDict.scaled(50)
                        width: srcDict.scaled(50)
                        anchors.left: parent.left
                        anchors.leftMargin: srcDict.scaled(20)
                        // anchors.verticalCenter: parent.verticalCenter
                        anchors.top: parent.top
                        anchors.topMargin: srcDict.scaled(20)
                        source: "../res/100.svg"
                    }
                    Label
                    {
                        anchors.top: imgCir.bottom
                        text: qsTr("循环次数")
                        anchors.left: parent.left
                        anchors.leftMargin: srcDict.scaled(20)
                        color: "white"
                    }
                    Label
                    {
                        anchors.right: parent.right
                        anchors.rightMargin: srcDict.scaled(25)
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: imgCir.right
                        font.pixelSize: 20
                        text: srcDict.cycles_number === undefined ? "0" : srcDict.cycles_number
                    }
                }
                Rectangle
                {
                    id: bao3

                    color: "transparent"
                    height: parent.height
                    width: param2Rect.width / 3
                    anchors.left: bao2.right
                    // border.color: "red"
                    Image
                    {
                        id: imgYc
                        height: srcDict.scaled(50)
                        width: srcDict.scaled(50)
                        // anchors.verticalCenter: parent.verticalCenter
                        anchors.top: parent.top
                        anchors.topMargin: srcDict.scaled(20)
                        anchors.left: parent.left
                        anchors.leftMargin: srcDict.scaled(20)
                        source: "../res/yacha.svg"
                    }
                    Label
                    {
                        id: yachaLab
                        anchors.top: imgYc.bottom
                        text: qsTr("压   差")
                        width: 4 * (font.pixelSize * 1.2)
                        horizontalAlignment: Text.AlignLeft
                        anchors.left: parent.left
                        anchors.leftMargin: srcDict.scaled(20)
                        color: "white"
                    }
                    Label
                    {
                        // anchors.leftMargin: srcDict.scaled(20)
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: imgYc.right
                        font.pixelSize: 20
                        text: srcDict.yaCha === undefined ? "0" : String(srcDict.yaCha)
                    }
                }

            }

            Rectangle
            {

                id: rectBlueTiele
                y: srcDict.scaled(90)
                anchors.horizontalCenter: parent.horizontalCenter
                width: srcDict.scaled(270)
                height: srcDict.scaled(47)
                color: "transparent"
                radius: 10
                Label
                {
                    id: label6
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 14
                    anchors.centerIn: parent
                    color: "white"
                    text: srcDict.conectedBlueName === undefined ? srcDict.conectedBlueName : srcDict.conectedBlueName.trim()
                }
            }
        }
    }
}
