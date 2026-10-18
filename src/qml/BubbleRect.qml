pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
    id: bubbleButton
    color: defaultColor

    property int buttonWidth: 20
    property int buttonHeight: 20
    property int buttonRadius: 10

    property color defaultColor: "#660099"
    property color hoverColor: "#d1b2e0"
}
