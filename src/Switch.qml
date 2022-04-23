import QtQuick 2.3

Rectangle {
    width: 40
    height: 20
    color: "#c7bfbf"
    radius: 10
    property bool enabled: true
    property bool switched: false
    Rectangle {
        id: little
        x: 3
        y: 3
        width: 14
        height: 14
        color: "#d44545"
        radius: 20
    }
    MouseArea {
        enabled: parent.enabled
        anchors.fill: parent
        onClicked: parent.switched = !parent.switched
    }
    states: [
        State {
            name: "enabledSwitched"
            when: enabled && switched
            PropertyChanges {
                target: little
                x: 23
            }
            PropertyChanges {
                target: little
                color: "#13af42"
            }
        },
        State {
            name: "enabledUnswitched"
            when: enabled && !switched
            PropertyChanges {
                target: little
                x: 3
            }
            PropertyChanges {
                target: little
                color: "#d44545"
            }
        },
        State {
            name: "disabledswitched"
            when: !enabled && switched
            PropertyChanges {
                target: little
                x: 23
            }
            PropertyChanges {
                target: little
                color: "#777777"
            }
        },
        State {
            name: "disabledUnswitched"
            when: !enabled && !switched
            PropertyChanges {
                target: little
                x: 3
            }
            PropertyChanges {
                target: little
                color: "#777777"
            }
        }
    ]
    transitions: Transition {
        NumberAnimation {
            target: little
            properties: "x"
            duration: 100
        }
        ColorAnimation {
            target: little
            duration: 100
        }
    }
}
