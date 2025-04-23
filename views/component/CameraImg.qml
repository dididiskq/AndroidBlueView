import QtQuick

import QtQuick.Controls
Page
{
    property alias realTimer: imgTimer
    property string temBase64: ""
    property string base64: ""


    // color: "transparent"
    id: cameraImg
    signal updateImageView()


    Image
    {
        id: oldView
        anchors.fill: parent
    }
    Image
    {
        id: currentView
        anchors.fill: parent
    }


    Timer
    {
        id: imgTimer
        interval: 30 //毫秒
        repeat: true
        onTriggered:
        {
            cameraImg.updateImageView()
        }
    }

    function updateImg(base64str)
    {
        if(temBase64 === base64str)
        {
            return
        }

        oldView.source = base64
        base64 = "data:image/jpeg;base64," + base64str

        currentView.source = base64
        //计算帧率
    }
}

