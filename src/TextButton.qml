import QtQuick 2.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.15

Rectangle {
    property alias text: t.text
    property alias textColor: t.color
    property alias enabled: area.enabled
    signal clicked
    color: "#b3ffffff"
    border.width: area.containsMouse ? 2 : 0
    border.color: "#ffffff"
    PropertyAnimation on opacity {
        from: 0
        to: 1
        duration: 250
    }
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        samples: 17
        horizontalOffset: 0
        verticalOffset: 0
        radius: 12
        spread: 0
        color: "#59000000"
    }
    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: area.enabled
        onClicked: parent.clicked()
        clip: true
        Rectangle { // 实现光效
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
    Text {
        id: t
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 14
        font.family: "Microsoft YaHei UI Light"
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        color: "#595959"
    }
}
