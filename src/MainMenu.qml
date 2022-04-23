import QtQuick 2.3

Item {
    width: 945
    height: 643
    Text {
        y: 84
        width: 126
        height: 32
        color: "#595959"
        text: "同化棋"
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 25
        font.family: "Microsoft YaHei UI Light"
        PropertyAnimation on opacity {
            from: 0
            to: 1
            duration: 250
        }
    }
    TextButton {
        id: newGameButton
        enabled: !newGameMenu.visible
        anchors.horizontalCenter: parent.horizontalCenter
        y: 200
        text: "新游戏"
        width: 265
        height: 38
        onClicked: newGameMenu.visible = true
    }
    TextButton {
        id: loadGameButton
        enabled: !newGameMenu.visible
        anchors.horizontalCenter: parent.horizontalCenter
        y: 335
        text: "加载存档"
        width: 265
        height: 38
        onClicked: {
            centerBlur.state = "hidden";
            fullBlur.state = "visible";
            gameData.start(true, false, false)
            windowLoader.source = "qrc:/Game.qml";
        }
    }
    TextButton {
        id: aboutButton
        enabled: !newGameMenu.visible
        anchors.horizontalCenter: parent.horizontalCenter
        y: 470
        text: "关于"
        anchors.horizontalCenterOffset: 0
        width: 265
        height: 38
        onClicked: {
            centerBlur.state = "hidden";
            fullBlur.state = "visible";
            windowLoader.source ="qrc:/About.qml";
        }
    }
    Rectangle {
        id: newGameMenu
        visible: false
        opacity: visible ? 1 : 0
        anchors.fill: parent
        color: "#dd777777"
        Text {
            y: 124
            width: 126
            height: 32
            color: "#eeeeee"
            text: "新游戏设置"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 25
            font.family: "Microsoft YaHei UI Light"
        }
        Text {
            y: 239
            width: 126
            height: 32
            color: "#ffffff"
            text: "双人游戏"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenterOffset: -65
            font.pointSize: 14
            font.family: "Microsoft YaHei UI Light"
        }
        Text {
            y: 306
            width: 126
            height: 32
            color: "#ffffff"
            text: "AI先手"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenterOffset: -65
            font.pointSize: 14
            font.family: "Microsoft YaHei UI Light"
        }
        Switch {
            id: pvp
            x: 542
            y: 245
            switched: true
        }
        Switch {
            id: aiFirst
            x: 542
            y: 312
            enabled: !pvp.switched
        }
        TextButton {
            id: start
            enabled: newGameMenu.visible
            anchors.horizontalCenter: parent.horizontalCenter
            y: 400
            text: "开始！"
            anchors.horizontalCenterOffset: -150
            width: 265
            height: 38
            onClicked: {
                centerBlur.state = "hidden";
                fullBlur.state = "visible";
                gameData.start(false, pvp.switched, aiFirst.switched);
                windowLoader.source = "qrc:/Game.qml";
            }
        }
        TextButton {
            id: backToMainMenu
            enabled: newGameMenu.visible
            anchors.horizontalCenter: parent.horizontalCenter
            y: 400
            text: "返回"
            anchors.horizontalCenterOffset: 150
            width: 265
            height: 38
            onClicked: newGameMenu.visible = false
        }
        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }
    }
}
