import QtQuick
import QtQuick.Controls
import "./component"
import "./js" as HMFunc
import QtQuick.Window
// 主窗口

Rectangle
{
    visible: true
    property variant context: HMStmViewContext
    property variant fields:  HMStmViewContext.fields

    property int currIndex: 1

    width: srcDict.winWidth
    height: srcDict.winHeight

    function putOp(command,params)
    {
        if(params)
        {
            HMStmViewContext.invoke(command, params);
        }
    }
    HMFunc.HMJs
    {
        id: srcDict
    }

    Loader
    {
        focus: true
        id:myLoader
        anchors.fill: parent
    }

    Component.onCompleted:
    {
        myLoader.source = "InitView.qml"
    }



}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.25;height:1080;width:1920}
}
##^##*/
