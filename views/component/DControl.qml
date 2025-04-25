import QtQuick 2.5
import QtQuick.Controls
Page
{
    title: qsTr("设备控制")



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
            x: srcDict.scaled(8)
            y: srcDict.scaled(31)
            width: srcDict.scaled(194)
            height: srcDict.scaled(15)

            text: qsTr("强制充电控制")

        }

        Label {
            id: label
            x: srcDict.scaled(248)
            y: srcDict.scaled(31)
            width: srcDict.scaled(194)
            height: srcDict.scaled(15)
            text: qsTr("强制放电控制")
        }

        Switch {
            id: _switch
            x: srcDict.scaled(8)
            y: srcDict.scaled(71)
            text: qsTr("")
        }

        Switch {
            id: _switch1
            x: srcDict.scaled(248)
            y: srcDict.scaled(71)
            text: qsTr("")
        }
    }

    Rectangle
    {
        id: rectangle1
        x: srcDict.scaled(0)
        y: srcDict.scaled(187)
        width: parent.width
        height: srcDict.scaled(200)
        color: "transparent"

            Rectangle
            {
                x: srcDict.scaled(15)
                y: srcDict.scaled(4)
                width: parent.width - 30
                height: srcDict.scaled(60)
                border.color: "red"
                Text {
                    id: name
                    text: qsTr("系统关机")
                }
            }
            Rectangle
            {
                x: srcDict.scaled(15)
                y: srcDict.scaled(136)
                width: parent.width - srcDict.scaled(30)
                height: srcDict.scaled(60)
                border.color: "red"
                Text {
                    id: name1
                    text: qsTr("重启系统")
                }
            }
            Rectangle
            {
                x: srcDict.scaled(15)
                y: srcDict.scaled(70)
                width: parent.width - srcDict.scaled(30)
                height: srcDict.scaled(60)
                border.color: "red"
                Text {
                    id: name2
                    text: qsTr("恢复出厂")
                }
            }
    }

    Rectangle {
        id: rectangle2
        x: srcDict.scaled(12)
        y: srcDict.scaled(427)
        width: srcDict.scaled(427)
        height: srcDict.scaled(90)
        color: "#ffffff"

        Label {
            id: label1
            x: srcDict.scaled(19)
            y: srcDict.scaled(18)
            width: srcDict.scaled(117)
            height: srcDict.scaled(55)
            text: qsTr("弱电开关")
        }

        Switch {
            id: control
            x: srcDict.scaled(310)
            y: srcDict.scaled(31)
            text: qsTr("")
            indicator: Rectangle {
                      implicitWidth: srcDict.scaled(48)
                      implicitHeight: srcDict.scaled(26)
                      x: control.leftPadding
                      y: parent.height / 2 - height / 2

                      radius: 13
                      color: control.checked ? "green" : "#ffffff"
                      border.color: control.checked ? "green" : "#cccccc"

                      //小圆点
                      Rectangle {
                          id : smallRect
                          width: srcDict.scaled(26)
                          height: srcDict.scaled(26)
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
