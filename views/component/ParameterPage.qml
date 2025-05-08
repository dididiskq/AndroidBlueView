
import QtQuick 2.15
import QtQuick.Layouts 1.15

ColumnLayout
{
    property var paramList: []      // 参数数据模型（JSON数组）
    property var temBtnText: qsTr("设置")
    property var celldata: ""
    property var userInput: ""
    property var operaCode: srcDict.operaCode
    spacing: 20
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
                console.log("设置参数：", modelData.name, modelData.cellData, realValueEditor.text);
                srcDict.itemIndex = index
                celldata = modelData.cellData
                userInput = realValueEditor.text
                passwordDialog.open()
            }
        }
    }

    Connections
    {
        target: context
        function onMySignal(message)
        {
            var item = repeater.itemAt(srcDict.itemIndex)
            if(message === "66")
            {
                item.btnText = qsTr("设置成功")
                item.resetTimer.start()
                console.log("设置成功")
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
            console.log("输入密码:", pwd)
            if(pwd)
            {
                var item = repeater.itemAt(srcDict.itemIndex)
                item.btnText = qsTr("请稍后...")
                srcDict.writeToBlue(celldata, userInput)
                passwordDialog.close()
            }
            else
            {
                passwordDialog.message = qsTr("密码错误请重新输入")
            }
        }
        onCanceled: console.log("操作取消")
    }
}

