import QtQuick 2.3
import QtGraphicalEffects 1.15

Item {
    property Item target
    property bool withShadow: false
    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: blur
                opacity: 1
            }
            PropertyChanges {
                target: blurMask
                opacity: 1
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: blur
                opacity: 0
            }
            PropertyChanges {
                target: blurMask
                opacity: 0
            }
        }
    ]
    transitions: Transition {
        ParallelAnimation {
            NumberAnimation {
                target: blur
                property: "opacity"
                duration: 250
            }
            NumberAnimation {
                target: blurMask
                property: "opacity"
                duration: 250
            }
        }
    }
    ShaderEffectSource {
        id: blurMask
        sourceItem: parent.target
        width: parent.width
        height: parent.height
        sourceRect: Qt.rect(parent.x, parent.y, width, height)
    }
    FastBlur {
        id: blur
        cached: false
        height: parent.height
        width: parent.width
        source: blurMask
        radius: 128
//        samples: 128  // 使用高斯模糊时加入参数
        layer.enabled: withShadow
        layer.effect: DropShadow {
            id: s
            transparentBorder: true
            samples: 17
            horizontalOffset: 0
            verticalOffset: 0
            radius: 12
            spread: 0
            color: "#59000000"
        }
    }
}
