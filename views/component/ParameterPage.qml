
import QtQuick 2.15
import QtQuick.Layouts 1.15


ColumnLayout
{

    spacing: 20
    property var paramList: []      // 参数数据模型（JSON数组）
    property var temBtnText: qsTr("设置")
    property var celldata: ""
    property var userInput: ""
    property var operaCode: srcDict.operaCode
    property bool isProcessing: false  // 保证独立处理标识
    property var temDataName: ""
    property var temDataValue: ""
    LoadingIndicator
    {
        id: loadRect
        Layout.preferredWidth: srcDict.scaled(300)
        Layout.preferredHeight: srcDict.scaled(110)
        Layout.alignment: Qt.AlignCenter
        z: 999
        bgColor: "#CC303030"
        textColor: "#00FF00"
        iconColor: "#FFA500"
        text: qsTr("设置成功")
    }
    // 表头
    RowLayout {
        Layout.fillWidth: true
        // Layout.preferredHeight: 40
        Text { text: qsTr("项目"); font.bold: true; Layout.preferredWidth: 120; color: "white" ;horizontalAlignment: Text.AlignHCenter}
        Text { text: qsTr("参数"); font.bold: true; Layout.preferredWidth: 120; color: "white" ;horizontalAlignment: Text.AlignHCenter}
        Text { text: qsTr("设定"); font.bold: true; Layout.preferredWidth: 120; color: "white" ;horizontalAlignment: Text.AlignHCenter}
    }


    // 动态生成参数项
    Repeater
    {
        id: repeater
        model: paramList
        delegate: ParameterItem {
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: 10
            paramName: modelData.name       // 数据模型字段：name
            paramValue: modelData.value     // 数据模型字段：value
            paramUnit: modelData.unit || "℃"// 默认单位为℃

            onClicked:
            {
                if(isProcessing)
                {
                    loadRect.text = qsTr("请求处理中，请稍后")
                    loadRect.startLoad(2000)
                    return
                }
                srcDict.itemIndex = index
                celldata = modelData.cellData
                userInput = realValueEditor.text
                if(celldata !== 526)
                {
                    if(userInput.indexOf(".") !== -1)
                    {
                        loadRect.text = qsTr("不能包含小数点")
                        loadRect.startLoad(3000)
                        return
                    }
                }

                if(srcDict.setPassFlag)
                {
                    temDataName = modelData.name + "(" + modelData.unit + ")"
                    temDataValue = modelData.value
                    passwordDialog.open()
                }
                else
                {
                    confirmDialog.changeName = modelData.name + "(" + modelData.unit + ")"
                    confirmDialog.changeold = modelData.value
                    confirmDialog.changeNew = userInput
                    confirmDialog.showDialog = true
                }
            }
        }
    }
    function okBtnSignal()
    {
        var item = repeater.itemAt(srcDict.itemIndex)
        item.btnText = qsTr("请稍后...")
        isProcessing = true
        srcDict.writeToBlue(celldata, userInput)
    }

    Connections
    {
        target: context
        function onMySignal(message)
        {
            var item = repeater.itemAt(srcDict.itemIndex)
            if(message === "66")
            {
                if(celldata === 1026)
                {
                    return
                }
                if(srcDict.temType === 513)
                {
                    srcDict.temType = 0
                    loadRect.text = qsTr("设置成功")
                    loadRect.startLoad(3000)
                    return
                }

                item.btnText = qsTr("设置成功")
                item.resetTimer.start()

                if(celldata === 512)
                {
                    srcDict.sendToBlue(24)
                    chuanTimer.start()
                }
                else
                {
                    srcDict.sendToBlue(-celldata)
                }
                if(celldata === 1028)
                {
                    srcDict.writeToBlue(1026, userInput)
                    celldata = 1026
                }

            }
            else if(message === "-66")
            {
                item.btnText = qsTr("超时失败")
                item.resetTimer.start()
            }
            else if(message === "-67")
            {
                item.btnText = qsTr("服务无效")
                item.resetTimer.start()
            }
            isProcessing = false
        }
    }
    Timer
    {
        id: chuanTimer
        interval: 500
        repeat: false
        onTriggered:
        {
            srcDict.getProtectMessage(1)
        }
    }

    PasswordDialog
    {
        id: passwordDialog
        x: srcDict.scaled(50)
        y: srcDict.scaled(200)
        title: qsTr("安全验证")
        message: qsTr("请输入管理员密码")
        onConfirmed: (pwd) =>
        {
            if(pwd === "8257")
            {
                srcDict.setPassFlag = false
                // var item = repeater.itemAt(srcDict.itemIndex)
                // item.btnText = qsTr("请稍后...")
                // isProcessing = true
                // srcDict.writeToBlue(celldata, userInput)
                passwordDialog.close()
                confirmDialog.changeName = temDataName
                confirmDialog.changeold = temDataValue
                confirmDialog.changeNew = userInput
                confirmDialog.showDialog = true
            }
            else
            {
                passwordDialog.message = qsTr("密码错误请重新输入")
            }
        }
        onCanceled:
        {}
    }
}

