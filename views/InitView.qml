import QtQuick
import QtQuick.Controls
import "./component"
import "./js" as HMFunc
import QtQuick.Window

Page
{
    id: mainPageInit
    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom
        // bottomMargin: -Screen.safeArea.bottom
    }
    background: Rectangle {
        color: "transparent"
    }
    Image
    {
        id: allBg
        width: srcDict.winWidth
        height: srcDict.winHeight
        source: "./res/104.svg"
    }
    Keys.onBackPressed: {
        if(devPage.reallStackView.depth > 1)
        {
           devPage.reallStackView.pop()
        }
        else if(minePage.reallStackView.depth > 1)
        {
            minePage.reallStackView.pop()
        }
        else
        {
            exitDialog.open()
        }
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
            mainPageInit.forceActiveFocus();
        }
    }

    TabBar
    {
        id: tabBar
        visible: srcDict.isShowTool
        z: 1
        width: parent.width
        contentHeight: parent.height * 0.08
        anchors.bottom: parent.bottom
        currentIndex: swipeView.currentIndex
        background: Rectangle {
            color: "transparent"
        }
        STabButton
        {
            id: btnMain
            buttonText: "设置"
            sour.source: "../res/setting.svg"
            sourP.source: "../res/settingP.svg"
            onClicked:
            {
                minePage.reallStackView.pop(null, StackView.Immediate);
                swipeView.currentIndex = 0
                devPage.realDrawer.close()
                srcDict.currentPageIndex = 1
                if(srcDict.isConnected)
                {
                    if (!devPage.realTimer.running)
                    {
                        devPage.realTimer.start()
                    }
                }
                // mainPage.realTimer.stop()
            }

        }
        STabButton
        {
            id: btnDevice
            buttonText: "实时"
            sour.source: "../res/main.svg"
            sourP.source: "../res/mainP.svg"
            onClicked:
            {
                devPage.reallStackView.pop(null, StackView.Immediate);
                minePage.reallStackView.pop(null, StackView.Immediate);
                swipeView.currentIndex = 1
                devPage.realDrawer.close()
                srcDict.currentPageIndex = 2
                if(srcDict.isConnected)
                {
                    if (!mainPage.realTimer.running)
                    {
                        mainPage.realTimer.start();
                    }
                }
                // mainPage.realTimer.start()
                // devPage.realTimer.stop()
            }
        }
        STabButton
        {
            id: btnMine
            buttonText: "我的"
            sour.source: "../res/mine.svg"
            sourP.source: "../res/mineP.svg"
            onClicked:
            {
                devPage.reallStackView.pop(null, StackView.Immediate);
                swipeView.currentIndex = 2
                devPage.realDrawer.close()
                srcDict.sendToBlue(31)
                srcDict.currentPageIndex = 3
                // devPage.realTimer.stop()
                // mainPage.realTimer.stop()
            }
        }
    }


    SwipeView
    {
        id: swipeView
        currentIndex: 1
        // currentIndex: tabBar.currentIndex
        width: parent.width
        anchors.top: parent.top
        height: parent.height - tabBar.height
        interactive: false
        DevicePage
        {
            id: devPage
        }
        MainPage
        {
            id: mainPage
            onHidenTabbar: (type) =>
            {
                console.log("收到信号参数:", type)
                if(type === 1)
                {
                    tabBar.visible = false
                }
                else if(type === 0)
                {
                    tabBar.visible = true
                }
            }
        }

        MinePage
        {
            id: minePage
        }

    }
    Connections
    {
        target: context
        function onMySignal(message)
        {
            if(message === "disconnected")
            {
                loadRectMain.text = srcDict.conectedBlueName + "已断开"
                loadRectMain.startLoad(3000)
                srcDict.conectedBlueName = "请先连接设备"
            }
        }
    }

    LoadingIndicator
    {
        id: loadRectMain
        anchors.centerIn: parent
        width: srcDict.scaled(300)  // 自定义尺寸
        height: srcDict.scaled(150)
        z: 999
        bgColor: "#CC303030"  // 自定义背景色
        textColor: "#00FF00"   // 自定义文字颜色
        iconColor: "#FFA500"   // 橙色加载图标
        text: qsTr("...") // 自定义提示内容
    }
    Component.onCompleted:
    {
        forceActiveFocus();
    }
}
