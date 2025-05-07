import QtQuick
import QtQuick.Controls
Page
{
    id: listViewBle
    property var blueData: srcDict.blueDataReal
    property string conectedName: ""
    property bool icConnecting: false
    background: Rectangle
    {
        color: "transparent"  // 完全透明
    }
    // 数据模型，存储对话内容
    onBlueDataChanged:
    {
        if(blueData === undefined)
        {
            return
        }

        simulateBotReply(blueData)
    }
    Component.onCompleted:
    {
        forceActiveFocus()
    }
    Keys.onBackPressed: {

        exitDialog.open()
    }
    Dialog
    {
        id: exitDialog
        title: "退出应用"
        Label { text: "确定要退出吗？" }
        anchors.centerIn: parent
        standardButtons: Dialog.Yes | Dialog.No

        onAccepted:
        {
            srcDict.closeApp()
        }
        onRejected:
        {
            listViewBle.forceActiveFocus();
        }
    }
    Label
    {
        id: blueName
        text: ""
        color: "white"
        // visible: false
        anchors.top: rect1.bottom
        anchors.topMargin: srcDict.scaled(10)
        anchors.left: parent.left
        anchors.leftMargin: (parent.width - width) / 2
    }

    ListModel
    {
        id: blueModel
    }
    function simulateBotReply(data)
    {
        var isDuplicate = false
        for( var i = 0; i < blueModel.count; i++)
        {
            if(blueModel.get(i).addr === data.address)
            {
                isDuplicate = true
                break;
            }
        }

        if(!isDuplicate)
        {
            blueModel.append({text: data.name, addr: data.address})
        }
    }


    Rectangle
    {
        id: rect1
        width: parent.width
        height: srcDict.scaled(88)
        anchors.top: parent.top
        anchors.topMargin: srcDict.scaled(0)
        color: "transparent"
        // border.color: "white"
        radius: 10
        Label
        {
            text: qsTr("设备列表")
            color: "white"
            font.pixelSize: 30
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle
        {
            height: srcDict.scaled(40)
            width: srcDict.scaled(70)
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            color: "transparent"
            border.color: "white"
            radius: 10
            Label
            {
                text: qsTr("返回")
                color: "white"
                anchors.centerIn: parent
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    myLoader.source = "InitView.qml"
                }
            }
        }
        Rectangle
        {
            height: srcDict.scaled(40)
            width: srcDict.scaled(70)
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            color: "transparent"
            border.color: "white"
            radius: 10
            Label
            {
                id: sracchLab
                text: qsTr("搜索设备")
                color: "white"
                anchors.centerIn: parent
            }

            MouseArea
            {
                id: searchBlue
                anchors.fill: parent
                onClicked:
                {
                    blueModel.clear()
                    srcDict.startSearch()
                    sracchLab.text = qsTr("搜索中...")
                    searchBlue.enabled = false
                }
            }
        }
    }
    Connections
    {
        target: context
        function onMySignal(message)
        {
            if(message === "1")
            {
                blueName.text = conectedName + qsTr("-已连接，请稍等")
                blueName.visible = true
                srcDict.conectedBlueName = conectedName
            }
            else if (message === "2")
            {
               myLoader.source = "InitView.qml"
            }
            else if(message === "over")
            {
                icConnecting = false
                sracchLab.text = qsTr("搜索设备")
                searchBlue.enabled = true
            }
        }
    }

    Rectangle
    {
        id: mainRect
        anchors.bottom: parent.bottom
        anchors.bottomMargin: srcDict.scaled(0)
        height: srcDict.scaled(720)
        border.color: "white"
        radius: 10
        color: "transparent"
        width: parent.width

        Flickable
        {
            id: blueFlickable
            width: parent.width
            height: parent.height
            clip: true // 确保内容在边界内剪裁
            contentWidth: blueColumn.width
            contentHeight: blueColumn.height

            Column
            {
                id: blueColumn
                width: blueFlickable.width
                spacing: 10

                // 每条消息的显示方式
                Repeater
                {
                    model: blueModel
                    delegate: Rectangle
                    {
                        id: deRect
                        width: messageText.implicitWidth + srcDict.scaled(20)
                        height: messageText.implicitHeight + srcDict.scaled(40)
                        color: "transparent"
                        border.color: "white"
                        radius: 10
                        anchors.horizontalCenter:parent.horizontalCenter
                        Text
                        {
                            id: messageText
                            color:  "white"
                            anchors.centerIn: parent
                            width: parent.width
                            wrapMode: Text.Wrap
                            text: model.text
                            horizontalAlignment: Text.AlignHCenter // 关键修改：水平居中
                            font.pixelSize: 20
                        }

                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked:
                            {
                                print("发送连接请求",model.text ,model.addr)
                                if(icConnecting)
                                {
                                    return
                                }
                                icConnecting = true
                                conectedName = model.text
                                model.text = model.text + qsTr("-正在连接")
                                deRect.color = "green"
                                srcDict.connectBlue(model.addr)

                            }
                            onPressed:
                            {
                            }
                            onReleased:
                            {
                                releaseTimer.start()
                            }
                            Timer
                            {
                                id: releaseTimer
                                interval: 250
                                repeat: false
                                onTriggered:
                                {
                                    deRect.color = "transparent"
                                }
                            }
                        }
                    }
                }
            }
            // 自动滚动到底部
            onContentHeightChanged:
            {
                // blueFlickable.contentY = blueColumn.height - blueFlickable.height
            }
        }
    }
}
