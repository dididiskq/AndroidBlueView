import QtQuick
import QtQuick.Controls
Page
{
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

    }
    Label
    {
        id: blueName
        text: "66666666666666666"
        visible: false
        anchors.top: parent.top
        anchors.topMargin: srcDict.scaled(70)
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
        width: parent.width
        height: srcDict.scaled(88)
        anchors.top: parent.top
        anchors.topMargin: srcDict.scaled(0)
        color: "#f2f8ed"
        radius: 10
        Label
        {
            text: "设备列表"
            font.pixelSize: 30
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle
        {
            height: 40
            width: 70
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            Label
            {
                text: "返回"
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
            height: 40
            width: 70
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            Label
            {
                id: sracchLab
                text: "搜索设备"
                anchors.centerIn: parent
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    blueModel.clear()
                    srcDict.startSearch()
                    sracchLab.text = "搜索中..."
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
                blueName.text = conectedName + "-已连接，请稍等"
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
                sracchLab.text = "搜索设备"
            }
        }
    }

    Rectangle
    {
        id: mainRect
        anchors.bottom: parent.bottom
        anchors.bottomMargin: srcDict.scaled(0)
        height: srcDict.scaled(720)

        radius: 10
        color: "#f2f8ed"
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
                        width: messageText.implicitWidth + 20
                        height: messageText.implicitHeight + 40
                        color: "white"
                        border.color: "#C1FFC1"
                        radius: 10
                        anchors.horizontalCenter:parent.horizontalCenter
                        Text
                        {
                            id: messageText
                            color:  "black"
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
                                model.text = model.text + "-正在连接"
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
                                    deRect.color = "white"
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
