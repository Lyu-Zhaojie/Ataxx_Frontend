import QtQuick 2.3
import QtGraphicalEffects 1.15

Item {
    width:945
    height:643
    Grid {
        x: 60
        y: 60
        width: 522
        height: 522
        rows: 7
        columns: 7
        spacing: 3
        Tile { state: tileData0.state; cellX: 0; cellY: 0 }
        Tile { state: tileData1.state; cellX: 0; cellY: 1 }
        Tile { state: tileData2.state; cellX: 0; cellY: 2 }
        Tile { state: tileData3.state; cellX: 0; cellY: 3 }
        Tile { state: tileData4.state; cellX: 0; cellY: 4 }
        Tile { state: tileData5.state; cellX: 0; cellY: 5 }
        Tile { state: tileData6.state; cellX: 0; cellY: 6 }
        Tile { state: tileData7.state; cellX: 1; cellY: 0 }
        Tile { state: tileData8.state; cellX: 1; cellY: 1 }
        Tile { state: tileData9.state; cellX: 1; cellY: 2 }
        Tile { state: tileData10.state; cellX: 1; cellY: 3 }
        Tile { state: tileData11.state; cellX: 1; cellY: 4 }
        Tile { state: tileData12.state; cellX: 1; cellY: 5 }
        Tile { state: tileData13.state; cellX: 1; cellY: 6 }
        Tile { state: tileData14.state; cellX: 2; cellY: 0 }
        Tile { state: tileData15.state; cellX: 2; cellY: 1 }
        Tile { state: tileData16.state; cellX: 2; cellY: 2 }
        Tile { state: tileData17.state; cellX: 2; cellY: 3 }
        Tile { state: tileData18.state; cellX: 2; cellY: 4 }
        Tile { state: tileData19.state; cellX: 2; cellY: 5 }
        Tile { state: tileData20.state; cellX: 2; cellY: 6 }
        Tile { state: tileData21.state; cellX: 3; cellY: 0 }
        Tile { state: tileData22.state; cellX: 3; cellY: 1 }
        Tile { state: tileData23.state; cellX: 3; cellY: 2 }
        Tile { state: tileData24.state; cellX: 3; cellY: 3 }
        Tile { state: tileData25.state; cellX: 3; cellY: 4 }
        Tile { state: tileData26.state; cellX: 3; cellY: 5 }
        Tile { state: tileData27.state; cellX: 3; cellY: 6 }
        Tile { state: tileData28.state; cellX: 4; cellY: 0 }
        Tile { state: tileData29.state; cellX: 4; cellY: 1 }
        Tile { state: tileData30.state; cellX: 4; cellY: 2 }
        Tile { state: tileData31.state; cellX: 4; cellY: 3 }
        Tile { state: tileData32.state; cellX: 4; cellY: 4 }
        Tile { state: tileData33.state; cellX: 4; cellY: 5 }
        Tile { state: tileData34.state; cellX: 4; cellY: 6 }
        Tile { state: tileData35.state; cellX: 5; cellY: 0 }
        Tile { state: tileData36.state; cellX: 5; cellY: 1 }
        Tile { state: tileData37.state; cellX: 5; cellY: 2 }
        Tile { state: tileData38.state; cellX: 5; cellY: 3 }
        Tile { state: tileData39.state; cellX: 5; cellY: 4 }
        Tile { state: tileData40.state; cellX: 5; cellY: 5 }
        Tile { state: tileData41.state; cellX: 5; cellY: 6 }
        Tile { state: tileData42.state; cellX: 6; cellY: 0 }
        Tile { state: tileData43.state; cellX: 6; cellY: 1 }
        Tile { state: tileData44.state; cellX: 6; cellY: 2 }
        Tile { state: tileData45.state; cellX: 6; cellY: 3 }
        Tile { state: tileData46.state; cellX: 6; cellY: 4 }
        Tile { state: tileData47.state; cellX: 6; cellY: 5 }
        Tile { state: tileData48.state; cellX: 6; cellY: 6 }
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            samples: 17
            horizontalOffset: 0
            verticalOffset: 0
            radius: 12
            spread: 0
            color: "#40000000"
        }
    }
    Text {
        x: 650
        y: 80
        width: 126
        height: 32
        color: "#595959"
        text: gameData.minutes + " 分 " + gameData.seconds + " 秒";
        //horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 20
        font.family: "Microsoft YaHei UI Light"
        PropertyAnimation on opacity {
            from: 0
            to: 1
            duration: 250
        }
    }
    Text {
        x: 650
        y: 125
        width: 126
        height: 32
        color: "#595959"
        text: gameData.player == 0 ? "黑方行棋" : "白方行棋"
        //horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 20
        font.family: "Microsoft YaHei UI Light"
        PropertyAnimation on opacity {
            from: 0
            to: 1
            duration: 250
        }
    }
    Text {
        x: 650
        y: 170
        width: 126
        height: 32
        color: "#595959"
        text: gameData.steps + " 步"
        //horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 20
        font.family: "Microsoft YaHei UI Light"
        PropertyAnimation on opacity {
            from: 0
            to: 1
            duration: 250
        }
    }
    TextButton {
        x: 633
        y: 278
        text: "返回"
        width: 265
        height: 38
        enabled: gameData.state < 3
        onClicked: {
            gameData.clean();
            centerBlur.state = "visible";
            fullBlur.state = "hidden";
            windowLoader.source = "MainMenu.qml";
        }
    }
    TextButton {
        x: 633
        y: 411
        text: "保存"
        width: 265
        height: 38
        enabled: gameData.state < 3
        onClicked: gameData.save()
    }
    TextButton {
        x: 633
        y: 544
        text: "退出"
        width: 265
        height: 38
        enabled: gameData.state < 3
        onClicked: Qt.exit(0)
    }
    Timer {
        interval: 1000
        running: gameData.enableTimer
        repeat: true
        onTriggered: gameData.secondsPlus()
    }
    Rectangle {
        id: whiteWin
        visible: gameData.state > 4
        opacity: gameData.state > 4 ? 1 : 0
        color: "#66000000"
        width: 945
        height: 300
        y: 171
        Text {
            y: 100
            width: 126
            height: 32
            color: "#ffffff"
            text: gameData.state == 5 ? "游戏结束，黑方胜利" : "游戏结束，白方胜利"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 25
            font.family: "Microsoft YaHei UI Light"
        }
        TextButton {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 200
            text: "返回"
            width: 265
            height: 38
            onClicked: {
                gameData.clean();
                centerBlur.state = "visible";
                fullBlur.state = "hidden";
                windowLoader.source = "MainMenu.qml";
            }
        }
        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }
    }
}
