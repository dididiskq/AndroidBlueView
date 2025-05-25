import QtQuick
import QtQuick.Controls
Page
{
    property var alarmMsgList: srcDict.alarmMsgList
    property var afeList: srcDict.afeList
    property var statusMsgList: srcDict.statusMsgList
    background: Rectangle
    {
        color: "transparent"
    }

    onAlarmMsgListChanged:
    {
        if(alarmMsgList === undefined)
        {
            return
        }
        blueModel.clear()
        for(var i = 0; i < alarmMsgList.length; i++)
        {
            blueModel.append({text: alarmMsgList[i]})
        }
    }

    onAfeListChanged:
    {
        if(afeList === undefined)
        {
            return
        }
        blueModelAfe.clear()
        for(var i = 0; i < afeList.length; i++)
        {
            blueModelAfe.append({text: afeList[i]})
        }
    }
    onStatusMsgListChanged:
    {
        if(statusMsgList === undefined)
        {
            return
        }
        blueModelStatus.clear()
        for(var i = 0; i < statusMsgList.length; i++)
        {
            blueModelStatus.append({text: statusMsgList[i]})
        }
    }

    ListModel
    {
        id: blueModelAfe
    }
    ListModel
    {
        id: blueModelStatus
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
            text: qsTr("异常信息")
            color: "#33C3FF"
            font.pixelSize: 25
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
                    stackView1.pop()
                }
            }
        }
    }
    ListModel
    {
        id: blueModel
    }
    Component.onCompleted:
    {

    }

    Rectangle
    {
        id: mainRect
        // anchors.bottom: parent.bottom
        // anchors.bottomMargin: srcDict.scaled(0)
        anchors
        {
            top: parent.top
            topMargin: rect1.height
        }

        height: (parent.height - rect1.height) / 3
        // border.color: "white"
        radius: 10
        color: "transparent"
        width: parent.width
        Label
        {
            id: labelName
            text: qsTr("告警信息：")
            color: "white"
            font.pixelSize: 25
            anchors
            {
                left: parent.left
                top: parent.top
            }
        }
        Flickable
        {
            id: blueFlickable
            width: parent.width
            height: parent.height - labelName.height
            clip: true // 确保内容在边界内剪裁
            contentWidth: blueColumn.width
            contentHeight: blueColumn.height
            anchors
            {
                bottom: parent.bottom
            }

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
    Rectangle
    {
        id: rectProtect
        // border.color: "white"
        anchors
        {
            top:mainRect.bottom
        }
        color: "transparent"
        width: parent.width
        height: mainRect.height

        Label
        {
            text: qsTr("保护信息：")
            color: "white"
            font.pixelSize: 25
            anchors
            {
                left: parent.left
                top: parent.top
            }
        }
        Flickable
        {
            id: blueFlickable1
            width: parent.width
            height: parent.height - labelName.height
            clip: true // 确保内容在边界内剪裁
            contentWidth: blueColumn.width
            contentHeight: blueColumn.height
            anchors
            {
                bottom: parent.bottom
            }

            Column
            {
                id: blueColumn1
                width: blueFlickable1.width
                spacing: 10

                // 每条消息的显示方式
                Repeater
                {
                    model: blueModelAfe
                    delegate: Rectangle
                    {
                        id: deRect1
                        width: messageText1.implicitWidth + srcDict.scaled(20)
                        height: messageText1.implicitHeight + srcDict.scaled(40)
                        color: "transparent"
                        border.color: "white"
                        radius: 10
                        anchors.horizontalCenter:parent.horizontalCenter
                        Text
                        {
                            id: messageText1
                            color:  "white"
                            anchors.centerIn: parent
                            width: parent.width
                            wrapMode: Text.Wrap
                            text: model.text
                            horizontalAlignment: Text.AlignHCenter // 关键修改：水平居中
                            font.pixelSize: 20
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
    Rectangle
    {
        id: cellStatus
        // border.color: "white"
        color: "transparent"
        anchors
        {
            top:rectProtect.bottom
        }
        width: parent.width
        height: mainRect.height

        Label
        {
            text: qsTr("电池状态：")
            color: "white"
            font.pixelSize: 25
            anchors
            {
                left: parent.left
                top: parent.top
            }
        }
        Flickable
        {
            id: blueFlickable2
            width: parent.width
            height: parent.height - labelName.height
            clip: true // 确保内容在边界内剪裁
            contentWidth: blueColumn2.width
            contentHeight: blueColumn2.height
            anchors
            {
                bottom: parent.bottom
            }

            Column
            {
                id: blueColumn2
                width: blueFlickable1.width
                spacing: 10

                // 每条消息的显示方式
                Repeater
                {
                    model: blueModelStatus
                    delegate: Rectangle
                    {
                        id: deRect2
                        width: messageText2.implicitWidth + srcDict.scaled(20)
                        height: messageText2.implicitHeight + srcDict.scaled(40)
                        color: "transparent"
                        border.color: "white"
                        radius: 10
                        anchors.horizontalCenter:parent.horizontalCenter
                        Text
                        {
                            id: messageText2
                            color:  "white"
                            anchors.centerIn: parent
                            width: parent.width
                            wrapMode: Text.Wrap
                            text: model.text
                            horizontalAlignment: Text.AlignHCenter // 关键修改：水平居中
                            font.pixelSize: 20
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
