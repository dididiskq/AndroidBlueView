import QtQuick 2.5
import QtQuick.Controls
Page
{
    title: qsTr("设备控制")
    property int flagOpen: -1
    property bool pendingSwitchState: false
    property bool isSystemOpera: false
    property var systemData: 0
    background: Rectangle
    {
        color: "transparent"  // 完全透明
    }

    Connections
    {
        target: context
        function onMySignal(message)
        {
            if(message === "66")
            {
                loadRect.text = qsTr("设置成功")
                loadRect.startLoad(3000)
            }
            else if(message === "-66")
            {
                loadRect.text = qsTr("超时失败")
                loadRect.startLoad(3000)
            }
            else if(message === "-67")
            {
                loadRect.text = qsTr("服务无效")
                loadRect.startLoad(3000)
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
    Rectangle
    {
        id: rectangle
        visible: false
        anchors.top: parent.top
        anchors.topMargin: srcDict.scaled(10)
        width: parent.width
        height: srcDict.scaled(150)
        border.color: "white"
        color: "transparent"
        radius: 10
        Label
        {
            x: srcDict.scaled(8)
            y: srcDict.scaled(31)
            width: srcDict.scaled(194)
            height: srcDict.scaled(15)
            color: "white"
            font.pixelSize: 20
            text: qsTr("强制充电控制")

        }

        Label {
            id: label
            x: srcDict.scaled(248)
            y: srcDict.scaled(31)
            width: srcDict.scaled(194)
            height: srcDict.scaled(15)
            color: "white"
            font.pixelSize: 20
            text: qsTr("强制放电控制")
        }

        Switch
        {
            id: _switch
            x: srcDict.scaled(8)
            y: srcDict.scaled(71)
            text: qsTr("")
            onCheckedChanged:
            {
                if(_switch.checked)
                {
                    // print("打开")
                }
                else
                {
                    // print("关闭")
                }
            }
        }

        Switch
        {
            id: _switch1
            x: srcDict.scaled(248)
            y: srcDict.scaled(71)
            text: qsTr("")
            onCheckedChanged:
            {
                if(_switch1.checked)
                {
                    // print("打开")
                }
                else
                {
                    // print("关闭")
                }
            }
        }
    }

    Rectangle
    {
        id: rectangle1
        anchors.top: parent.top
        anchors.topMargin: srcDict.scaled(10)
        width: parent.width
        height: srcDict.scaled(270)
        border.color: "white"
        color: "transparent"
        radius: 10
        Rectangle
        {
            id: shutDownRect
            x: srcDict.scaled(15)
            y: srcDict.scaled(4)
            width: parent.width - srcDict.scaled(30)
            height: srcDict.scaled(60)
            border.color: "white"
            color: "transparent"
            radius: 10
            Text {
                id: name
                color: "white"
                font.pixelSize: 25
                anchors.centerIn: parent
                text: qsTr("系统关机")
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    isSystemOpera = true
                    systemData = 1
                    shutDownRect.color = "white"
                }
                onReleased:
                {
                    releaseTimer1.start()
                }
                Timer
                {
                    id: releaseTimer1
                    interval: 150
                    repeat: false
                    onTriggered:
                    {
                        shutDownRect.color = "transparent"
                        if(srcDict.setPassFlag2)
                        {
                            passwordDialog.open()
                        }
                        else
                        {
                            if(!isSystemOpera)
                            {
                               control.checked = !pendingSwitchState
                               srcDict.writeToBlue(517, flagOpen)
                            }
                            else
                           {
                               srcDict.writeToBlue(systemData, 10000)
                            }
                        }
                    }
                }
            }
        }
        Rectangle
        {
            id: rebootDev
            x: srcDict.scaled(15)
            y: srcDict.scaled(136)
            width: parent.width - srcDict.scaled(30)
            height: srcDict.scaled(60)
            border.color: "white"
            color: "transparent"
            radius: 10
            Text
            {
                id: name1
                color: "white"
                font.pixelSize: 25
                anchors.centerIn: parent
                text: qsTr("重启系统")
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    isSystemOpera = true
                    systemData = 0
                    rebootDev.color = "white"

                }
                onReleased:
                {
                    releaseTimer2.start()
                }
                Timer
                {
                    id: releaseTimer2
                    interval: 150
                    repeat: false
                    onTriggered:
                    {
                        rebootDev.color = "transparent"
                        if(srcDict.setPassFlag2)
                        {
                            passwordDialog.open()
                        }
                        else
                        {
                            if(!isSystemOpera)
                            {
                               control.checked = !pendingSwitchState
                               srcDict.writeToBlue(517, flagOpen)
                            }
                            else
                           {
                               srcDict.writeToBlue(systemData, 10000)
                            }
                        }
                    }
                }
            }
        }
        Rectangle
        {
            id: recoverRect
            x: srcDict.scaled(15)
            y: srcDict.scaled(70)
            width: parent.width - 30
            height: srcDict.scaled(60)
            border.color: "white"
            color: "transparent"
            radius: 10
            Text {
                id: name2
                color: "white"
                font.pixelSize: 25
                anchors.centerIn: parent
                text: qsTr("恢复出厂")
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    isSystemOpera = true
                    systemData = 2
                    recoverRect.color = "white"
                }
                onReleased:
                {
                    releaseTimer3.start()
                }
                Timer
                {
                    id: releaseTimer3
                    interval: 150
                    repeat: false
                    onTriggered:
                    {
                        recoverRect.color = "transparent"
                        if(srcDict.setPassFlag2)
                        {
                            passwordDialog.open()
                        }
                        else
                        {
                            if(!isSystemOpera)
                            {
                               control.checked = !pendingSwitchState
                               srcDict.writeToBlue(517, flagOpen)
                            }
                            else
                           {
                               srcDict.writeToBlue(systemData, 10000)
                            }
                        }
                    }
                }
            }
        }
        Rectangle
        {
            id: changeLanguage
            width: parent.width - 30
            height: srcDict.scaled(60)
            anchors.top: rebootDev.bottom
            anchors.topMargin: srcDict.scaled(5)
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: "white"
            color: "transparent"
            radius: 10
            Text
            {
                color: "white"
                font.pixelSize: 25
                anchors.centerIn: parent
                text: qsTr("切换为英文")
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    changeLanguage.color = "white"
                }
                onReleased:
                {
                    releaseTimer4.start()
                }
                Timer
                {
                    id: releaseTimer4
                    interval: 150
                    repeat: false
                    onTriggered:
                    {
                        changeLanguage.color = "transparent"
                        if(srcDict.isChinese)
                        {
                            HMStmViewContext.switchLanguage("english")
                            srcDict.isChinese = false
                        }
                        else
                        {
                            HMStmViewContext.switchLanguage("chinese")
                            srcDict.isChinese = true
                        }

                    }
                }
            }
        }
    }
    PasswordDialog
    {
        id: passwordDialog
        x: srcDict.scaled(50)
        y: srcDict.scaled(200)
        title: qsTr("安全验证")
        message: qsTr("请输入管理员密码")
        onConfirmed: (pwd) =>
        {
            if(pwd === "0909")
            {
                srcDict.setPassFlag2 = false
                 if(!isSystemOpera)
                 {
                    control.checked = !pendingSwitchState
                    srcDict.writeToBlue(517, flagOpen)
                 }
                 else
                {
                    srcDict.writeToBlue(systemData, 10000)
                 }

                passwordDialog.close()
            }
            else
            {
                passwordDialog.message = qsTr("密码错误请重新输入")
            }
        }
        onCanceled:
        {
        }
    }

    Rectangle
    {
        id: rectangle2
        anchors.top: rectangle1.bottom
        anchors.topMargin: srcDict.scaled(30)
        width: parent.width
        height: srcDict.scaled(90)
        border.color: "white"
        color: "transparent"
        radius: 10
        Label
        {
            id: label1
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 30
            width: srcDict.scaled(117)
            // height: srcDict.scaled(55)
            color: "white"
            font.pixelSize: 25
            text: qsTr("弱电开关")
        }

        Switch
        {
            id: control
            // x: srcDict.scaled(310)
            // y: srcDict.scaled(31)
            anchors.verticalCenter: rectangle2.verticalCenter
            anchors.right: rectangle2.right
            anchors.rightMargin: srcDict.scaled(30)
            text: qsTr("")
            checked: srcDict.functionConfig === 1
            onClicked:
            {
                pendingSwitchState = !checked
                checked = !checked
                flagOpen = pendingSwitchState ? 0 : 1
                if(srcDict.setPassFlag2)
                {
                    passwordDialog.open()
                }
                else
                {
                    if(!isSystemOpera)
                    {
                       control.checked = !pendingSwitchState
                       srcDict.writeToBlue(517, flagOpen)
                    }
                    else
                   {
                       srcDict.writeToBlue(systemData, 10000)
                    }
                }
            }


            indicator: Rectangle
            {
                implicitWidth: srcDict.scaled(48)
                implicitHeight: srcDict.scaled(26)
                x: control.leftPadding
                y: parent.height / 2 - height / 2

                radius: 13
                color: control.checked ? "green" : "#ffffff"
                border.color: control.checked ? "green" : "#cccccc"

                //小圆点
                Rectangle
                {
                    id : smallRect
                    width: srcDict.scaled(26)
                    height: srcDict.scaled(26)
                    radius: 13
                    color: control.down ? "#cccccc" : "#ffffff"
                    border.color: control.checked ? (control.down ? "#17a81a" : "#21be2b") : "#999999"

                  //改变小圆点的位置
                    NumberAnimation on x
                    {
                        to: smallRect.width
                        running: control.checked ? true : false
                        duration: 200
                    }

                  //改变小圆点的位置
                    NumberAnimation on x
                    {
                        to: 0
                        running: control.checked ? false : true
                        duration: 200
                    }
                }
            }
        }
    }
    Component.onCompleted:
    {
        srcDict.sendToBlue(31)
    }
}
