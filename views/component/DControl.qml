import QtQuick 2.5
import QtQuick.Controls
Page
{
    title: "设备控制"



    Rectangle
    {
        id: rectangle
        x: 0
        y: 0
        width: parent.width
        height: 150
        color: "#ffffff"
        Label
        {
            x: 8
            y: 31
            width: 194
            height: 15

            text: "强制充电控制"

        }

        Label {
            id: label
            x: 248
            y: 31
            width: 194
            height: 15
            text: qsTr("强制放电控制")
        }

        Switch {
            id: _switch
            x: 8
            y: 71
            text: qsTr("")
        }

        Switch {
            id: _switch1
            x: 248
            y: 71
            text: qsTr("")
        }
    }

    Rectangle
    {
        id: rectangle1
        x: 0
        y: 187
        width: parent.width
        height: 200
        color: "transparent"

            Rectangle
            {
                x: 15
                y: 4
                width: parent.width - 30
                height: 60
                border.color: "red"
                Text {
                    id: name
                    text: qsTr("系统关机")
                }
            }
            Rectangle
            {
                x: 15
                y: 136
                width: parent.width - 30
                height: 60
                border.color: "red"
                Text {
                    id: name1
                    text: qsTr("重启系统")
                }
            }
            Rectangle
            {
                x: 15
                y: 70
                width: parent.width - 30
                height: 60
                border.color: "red"
                Text {
                    id: name2
                    text: qsTr("恢复出厂")
                }
            }
    }

    Rectangle {
        id: rectangle2
        x: 12
        y: 427
        width: 427
        height: 90
        color: "#ffffff"

        Label {
            id: label1
            x: 19
            y: 18
            width: 117
            height: 55
            text: qsTr("弱电开关")
        }

        Switch {
            id: control
            x: 310
            y: 31
            text: qsTr("")
            indicator: Rectangle {
                      implicitWidth: 48
                      implicitHeight: 26
                      x: control.leftPadding
                      y: parent.height / 2 - height / 2

                      radius: 13
                      color: control.checked ? "green" : "#ffffff"
                      border.color: control.checked ? "green" : "#cccccc"

                      //小圆点
                      Rectangle {
                          id : smallRect
                          width: 26
                          height: 26
                          radius: 13
                          color: control.down ? "#cccccc" : "#ffffff"
                          border.color: control.checked ? (control.down ? "#17a81a" : "#21be2b") : "#999999"

                        //改变小圆点的位置
                          NumberAnimation on x{
                              to: smallRect.width
                              running: control.checked ? true : false
                              duration: 200
                          }

                        //改变小圆点的位置
                          NumberAnimation on x{
                              to: 0
                              running: control.checked ? false : true
                              duration: 200
                          }
                      }
                  }

                  //要显示的文本
                  contentItem: Text {
                      text: control.checked.toString()
                      font.pixelSize: 50
                      //鼠标按下时  control.down
                      color: control.down ? "green" : "red"
                      verticalAlignment: Text.AlignVCenter
                      anchors.left: control.indicator.right
                  }
        }
    }


}
