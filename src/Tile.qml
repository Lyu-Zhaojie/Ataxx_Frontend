import QtQuick 2.3
import QtGraphicalEffects 1.15
Rectangle {
    width: 72
    height: 72
    property int cellX;
    property int cellY;
    property int state;
    property bool enabled: (state == gameData.player && (gameData.state == 1 || gameData.state == 2)) || (state == 3 && gameData.state == 2)
    function abs(x) {
        return x > 0 ? x : -x;
    }
    property bool inR1: state == 3 && ((abs(cellX - gameData.startX) == 1 && abs(cellY - gameData.startY) <= 1) || (abs(cellY - gameData.startY) == 1 && abs(cellX - gameData.startX) <= 1))
    property bool inR2: state == 3 && ((abs(cellX - gameData.startX) == 2 && abs(cellY - gameData.startY) <= 2) || (abs(cellY - gameData.startY) == 2 && abs(cellX - gameData.startX) <= 2))
    border.width: area.containsMouse || ((inR1 || inR2) && gameData.state == 2) ? 2 : 0
    border.color: {
        if (gameData.state == 2)
        {
            if (inR1)
                return "#bdecd2";
            if (inR2)
                return "#efc5ba";
        }
        return "#ffffff";
    }
    color: {
        if (cellX == gameData.startX && cellY == gameData.startY && gameData.state == 2)
            return "#eeffffff";
        if (gameData.state == 2)
        {
            if (inR1)
                return "#ee94e0b6";
            if (inR2)
                return "#eee69f8e";
        }
        return "#aaffffff";
    }
    Behavior on color { ColorAnimation { duration: 200 } }
    Behavior on border.color { ColorAnimation { duration: 200 } }
    // color: "#aaffffff"
    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if (parent.enabled) {
                if (parent.state == gameData.player) {
                    gameData.startX = parent.cellX;
                    gameData.startY = parent.cellY;
                    gameData.state = 2;
                }
                if (inR1 || inR2)
                    gameData.move(gameData.startX, gameData.startY, cellX, cellY);
            }
        }
        // cursorShape: Qt.PointingHandCursor
        clip: true
        Rectangle {
            id: rec
            width: 200
            height: 200
            x: area.mouseX - 100
            y: area.mouseY - 100
            visible: area.containsMouse
            radius: 50
            color: "#00000000"
            RadialGradient {
                anchors.fill: rec
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: "#a0ffffff"
                    }
                    GradientStop {
                        position: 0.5
                        color: "#00ffffff"
                    }
                }
            }
        }
    }
    PropertyAnimation on opacity {
        from: 0
        to: 1
        duration: 250
    }
    Image {
        id: whiteChessPiece
        sourceSize: Qt.size(64, 64)
        x:4
        y:4
        width:64
        height:64
        source: "qrc:/White.png"
        opacity: 0
    }
    Image {
        id: blackChessPiece
        sourceSize: Qt.size(64, 64)
        x:4
        y:4
        width:64
        height:64
        source: "qrc:/Black.png"
        opacity: 0
    }
    states: [
        State {
            name: "empty"
            when: state == 3
            PropertyChanges {
                target: whiteChessPiece
                opacity: 0
            }
            PropertyChanges {
                target: blackChessPiece
                opacity: 0
            }
        },
        State {
            name: "black"
            when: state == 0
            PropertyChanges {
                target: whiteChessPiece
                opacity: 0
            }
            PropertyChanges {
                target: blackChessPiece
                opacity: 1
            }
        },
        State {
            name: "white"
            when: state == 1
            PropertyChanges {
                target: whiteChessPiece
                opacity: 1
            }
            PropertyChanges {
                target: blackChessPiece
                opacity: 0
            }
        }
    ]
    transitions: Transition {
        NumberAnimation {
            target: whiteChessPiece
            properties: "opacity"
            duration: 250
        }
        NumberAnimation {
            target: blackChessPiece
            properties: "opacity"
            duration: 250
        }
    }
}
