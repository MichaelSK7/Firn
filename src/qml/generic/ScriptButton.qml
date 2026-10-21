pragma ComponentBehavior: Bound
import QtQuick

BubbleRect {
    width: 64
    height: 48
    border.width: borderWidth
    border.color: borderColor

    property int borderWidth: 2
    property color borderColor: mouseArea.containsMouse ? secondaryBorderColor : "black"
    property color secondaryBorderColor: "#C4CCC3"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
