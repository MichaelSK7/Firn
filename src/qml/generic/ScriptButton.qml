pragma ComponentBehavior: Bound
import QtQuick

BubbleRect {
    width: 64
    height: 48
    border.width: borderWidth
    border.color: borderColor
    color: mainColor

    property int borderWidth: 2
    property color borderColor: mouseArea.containsMouse ? secondaryBorderColor : "black"
    property color secondaryBorderColor: "#320051"
    property color mainColor: "#50565c"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
