// PasswordDialog.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup
{
    id: root
    modal: true
    dim: true
    padding: 0

    closePolicy: Popup.NoAutoClose // 强制必须操作按钮

    // 可配置属性
    property string title: qsTr("提示")
    property string message: qsTr("请输入密码")
    property string placeholderText: qsTr("密码")
    property string cancelText: qsTr("取消")
    property string confirmText: qsTr("确定")

    // 信号
    signal confirmed(string password)
    signal canceled()

    // 主内容
    Rectangle
    {
        width: srcDict.winWidth - 90
        height: contentLayout.height + 40
        radius: 8
        color: "#FFFFFF"

        ColumnLayout
        {
            id: contentLayout
            width: parent.width - 40
            anchors.centerIn: parent
            spacing: 20

            // 标题
            Text
            {
                text: root.title
                font.bold: true
                font.pixelSize: 18
                Layout.alignment: Qt.AlignHCenter
            }

            // 提示信息
            Text {
                text: root.message
                color: "#666666"
                font.pixelSize: 14
                Layout.alignment: Qt.AlignHCenter
            }

            // 输入框
            TextField
            {
                id: passwordField
                placeholderText: root.placeholderText
                echoMode: TextInput.Password
                font.pixelSize: 14
                Layout.fillWidth: true
                background: Rectangle {
                    radius: 4
                    border.color: "#CCCCCC"
                    border.width: 1
                }
            }

            // 按钮行
            RowLayout
            {
                spacing: 20
                Layout.alignment: Qt.AlignHCenter

                Button
                {
                    text: root.cancelText
                    flat: true
                    onClicked: {
                        root.close()
                        root.canceled()
                        passwordField.clear()
                        message = "请输入管理员密码"
                    }
                }

                Button
                {
                    text: root.confirmText
                    highlighted: true
                    onClicked: {
                        root.confirmed(passwordField.text)
                        passwordField.clear()
                    }
                }
            }
        }
    }
}
