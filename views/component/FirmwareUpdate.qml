import QtQuick 2.5
import QtQuick.Controls
Page
{
    title: qsTr("固件升级")

    background: Rectangle
    {
        color: "transparent"  // 完全透明
    }

    // Button
    // {
    //     height: 80
    //     width: 80

    //     onClicked:
    //     {
    //         HMStmViewContext.switchLanguage("english")
    //     }
    // }
    //写一个有三个rectangle的Column
    Column
    {
        spacing: 10
        anchors.centerIn: parent
        width: parent.width
        Rectangle
        {
            width: parent.width
            height: srcDict.scaled(100)
            color: "red"
            //水平居中的label

            Text
            {
                text: qsTr("固件版本")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: srcDict.scaled(30)
                color: "white"
            }
            Text
            {
                text: srcDict.mainVer === undefined ? "v1.0.0" : ("v" + srcDict.mainVer + ".0")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: srcDict.scaled(18)
                font.pixelSize: srcDict.scaled(24)
                color: "white"
            }
        }

        Rectangle
        {
            width: parent.width
            height: srcDict.scaled(100)
            color: "green"
            Text
            {
                text: qsTr("软件版本")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: srcDict.scaled(30)
                color: "white"
            }

            Text
            {
                text: srcDict.version
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: srcDict.scaled(18)
                font.pixelSize: srcDict.scaled(24)
                color: "white"
            }
        }

        Rectangle
        {
            width: parent.width
            height: srcDict.scaled(100)
            color: "blue"
            Text
            {
                text: qsTr("检查更新")
                anchors.centerIn: parent
                font.pixelSize: srcDict.scaled(30)
                color: "white"
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {

                }
            }
        }
    }

}
