import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQml 2.2

Item{
    id: information
    property string backgroundImage:"../res/4.png"
//    property string leftImage:"../res/5.png"
//    property string leftText:"献佛三三支香\r\文明又吉祥"
//    property string rightImage:"../res/5.png"
//    property string rightText:"佛法大智慧\r\n心诚福寿长"
//    property string middleTitleText:"文明敬香"
//    property string middleContexText:"免费入寺\r\n请自觉取 三支好香\r\n文明敬香 随喜功德\r\n外带香火 禁止入寺"
    Image {
        id: image
        source: backgroundImage
        anchors.fill: parent

//        Image {
//            id: leftImageId
//            source: leftImage
//            width: hmjs.getRate(74)
//            height: hmjs.getRate(74)
//            anchors.top:parent.top
//            anchors.topMargin: hmjs.getRate(86)
//            anchors.left: parent.left
//            anchors.leftMargin: hmjs.getRate(108)
//        }

//        Text {
//            id: leftTextId
//            text: leftText
//        }

//        Image {
//            id: rightImageId
//            source: rightImage
//            width: hmjs.getRate(74)
//            height: hmjs.getRate(74)
//        }

//        Text {
//            id: rightTextId
//            text: rightText
//        }

//        Text{
//            id: middleTitleId
//            text:middleTitleText
//        }

//        Text{
//            id: middleContextId
//            text:middleContexText
//        }
    }
}
