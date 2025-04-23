import QtQuick 2.5
import QtQuick.Controls

Item
{
    id: pageMain
    property var realTimer: mainPageTimer

    signal hidenTabbar(var type)
    Timer
    {
        id: mainPageTimer
        interval: 0       // 初始立即触发
        repeat: false     // 首次不重复
        onTriggered:
        {
            srcDict.sendToBlue(20)
            srcDict.sendToBlue(4)
            srcDict.sendToBlue(6)
            srcDict.sendToBlue(0)
            srcDict.sendToBlue(1)
            srcDict.sendToBlue(2)
            srcDict.sendToBlue(14)
            srcDict.sendToBlue(26)

            // 调整间隔和重复模式
            interval = 5000
            repeat = true
            start()
        }
    }
    Rectangle
    {
        id: appName
        visible: !cameraRect.visible
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 42
        width: 80
        height: 40
        color: "transparent"
        Label
        {
            text: qsTr("Ultra BMS")
            color: "#33C3FF"
            font.pixelSize: 25
            anchors.centerIn: parent
        }
    }
    Component.onCompleted:
    {
        print("首页加载")
    }
    Component.onDestruction:
    {
        print("首页销毁")
    }
    BatteryArc
    {
        visible: !cameraRect.visible
        anchors.top: parent.top
        // anchors.left: parent.left
        anchors.topMargin: srcDict.scaled(170)
        // anchors.leftMargin: srcDict.scaled(45)
        anchors.horizontalCenter: parent.horizontalCenter
        progress: (srcDict.soc === undefined ? 0 : srcDict.soc * 0.01)
        lineWidth: 10
        backgroundColor: "#7A7E7D"
        progressColor: "white"
        textPrefix: getStatus()// 可调整线宽
        z: 1
    }
    Rectangle
    {
        visible: !cameraRect.visible
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

    Rectangle
    {
        id: buttonSacn
        visible: !cameraRect.visible
        anchors.left: parent.left
        anchors.leftMargin: srcDict.scaled(25)
        Label
        {
            text: qsTr("设备列表")
            color: "white"
            font.pixelSize: 25
            anchors.centerIn: parent
        }

        y: 42

        width: 80
        height: 40
        color: "transparent"
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                // srcDict.startSearch()
                // blueModel.clear()
                myLoader.source = "./component/BlueList.qml"
            }
        }
    }
    Rectangle
    {
        id: buttonCode
        visible: !cameraRect.visible
        anchors.right: parent.right
        anchors.rightMargin: srcDict.scaled(20)
        y: 42
        width: 80
        height: 40
        color: "transparent"
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                hidenTabbar(1)
                // cameraRect.realTimer.start()
                srcDict.sendCodeData(1)
                cameraRect.visible = true
                cameraRect.capReal.camera.start()
            }
        }

        Image
        {
            width: 40
            height: 40
            anchors.centerIn: parent
            source: "../res/sacn.svg"
        }
    }

    CamerView
    {
        id: cameraRect
        anchors.fill: parent
        visible: false
        onReturnPage:
        {
            hidenTabbar(0)
            cameraRect.visible = false
            capReal.camera.stop()
        }
    }
    // CameraImg
    // {
    //     id: cameraRect
    //     visible: false
    //     // border.color: "black"
    //     // border.width: 2
    //     // radius: 10
    //     // width: parent.width * 0.75
    //     // height: parent.height * 0.5
    //     anchors.fill: parent
    //     Button
    //     {
    //         text: "返回"
    //         onClicked:
    //         {
    //             realTimer.stop()
    //             srcDict.sendCodeData(0)
    //             cameraRect.visible = false
    //         }
    //     }

    //     onUpdateImageView: //槽函数
    //     {
    //         cameraRect.updateImg(HMStmViewContext.getImageFrmeBase64())
    //     }
    //     Component.onCompleted:
    //     {

    //         // realTimer.start()
    //     }
    //     Component.onDestruction:
    //     {
    //     }
    // }
    // //总容量
    // Rectangle
    // {
    //     // border.color: "red"
    //     color: "transparent"
    //     visible: !cameraRect.visible
    //     height: srcDict.scaled(30)
    //     width: srcDict.scaled(100)
    //     anchors.left: parent.left
    //     anchors.top: parent.top
    //     anchors.leftMargin: srcDict.scaled(40)
    //     anchors.topMargin: srcDict.scaled(370)
    //     Label
    //     {
    //         id: lab1
    //         text: "总容量"
    //         color: "white"
    //         font.pixelSize: 12
    //         font.bold: true
    //         anchors.verticalCenter: parent.verticalCenter
    //     }
    //     Label
    //     {
    //         text: String(srcDict.fcc === undefined ? "0" : srcDict.fcc)+ "AH"
    //         color: "white"
    //         font.pixelSize: 12
    //         font.bold: true
    //         anchors.verticalCenter: parent.verticalCenter
    //         anchors.left: lab1.right
    //         anchors.leftMargin: srcDict.scaled(10)
    //     }
    // }

    //剩余容量
    Rectangle
    {
        // border.color: "red"
        color: "transparent"
        visible: !cameraRect.visible
        height: srcDict.scaled(30)
        width: srcDict.scaled(100)
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: srcDict.scaled(40)
        anchors.topMargin: srcDict.scaled(370)
        Label
        {
            id: lab2
            text: "剩余容量"
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
            text: String(srcDict.remaining_capacity === undefined ? "0" : srcDict.remaining_capacity) + "AH"
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
        width: height + 10
        visible: !cameraRect.visible
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
            text: String(srcDict.electYa === undefined ? "0" : srcDict.electYa)
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
        visible: !cameraRect.visible
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
            text: String(srcDict.electLiu === undefined ? "0" : srcDict.electLiu)
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
        visible: !cameraRect.visible
        color: "transparent"
        height: 100
        width: parent.width - 40
        anchors.top: parent.top
        anchors.topMargin: 540
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
                height: 50
                width: 50
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
                anchors.topMargin: 20
                font.pixelSize: 20
                text: qsTr("T1")
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label
            {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                color: "white"
                font.pixelSize: 30
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
                anchors.topMargin: 20
                font.pixelSize: 20
                text: qsTr("T2")
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label
            {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                color: "white"
                font.pixelSize: 30
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
                anchors.topMargin: 20
                font.pixelSize: 20
                text: qsTr("mos")
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label
            {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                color: "white"
                font.pixelSize: 30
                text: srcDict.mosTemperature === undefined ? "" : (srcDict.mosTemperature  + "℃")
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

    }
    Rectangle
    {
        id: param2Rect
        radius: 10
        visible: !cameraRect.visible
        color: "transparent"
        height: 100
        width: parent.width - 40
        anchors.top: param1Rect.bottom
        anchors.topMargin: 10
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
                height: 50
                width: 50
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
                font.pixelSize: {
                            const length = text.length
                            return length > 2 ? 24 : 30
                        }
                text: srcDict.alarmlStatus === undefined ? "0" : String(srcDict.alarmlStatus)
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
                height: 50
                width: 50
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
                font.pixelSize: {
                            const length = text.length
                            return length > 2 ? 24 : 30
                        }
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
                height: 50
                width: 50
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
                font.pixelSize: {
                            const length = text.length
                            return length > 2 ? 24 : 30
                        }
                text: srcDict.yaCha === undefined ? "0" : String(srcDict.yaCha)
            }
        }


    }

    Rectangle
    {
        visible: !cameraRect.visible
        id: rectBlueTiele
        y: 88
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
            text: srcDict.conectedBlueName
        }
    }

}
