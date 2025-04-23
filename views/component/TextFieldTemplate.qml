import QtQuick
import QtQuick.Controls

Rectangle
{
    property alias inputObj: input
    TextField
    {
        anchors.centerIn: parent
        width: parent.width
        id: input
        placeholderText: ""
        text: ""
        placeholderTextColor:"grey"
        background: null
    }
    border.color: "yellow"
}


