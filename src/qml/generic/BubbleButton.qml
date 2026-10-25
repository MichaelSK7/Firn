pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
    id: box

    width: Math.max(buttonWidth, textItem.implicitWidth + horizontalPadding * 2)
    height: buttonHeight
    radius: buttonRadius
    color: bubbleButtonMouseArea.containsMouse ? primaryColor : secondaryColor

    property string text: ""
    property string fontFamily: "Inter"
    property int fontSize: 12
    property bool bold: false

    property int buttonWidth: 20
    property int buttonHeight: 20
    property int buttonRadius: 4
    property int horizontalPadding: 8

    property color primaryColor: "#50565c"
    property color secondaryColor: "transparent"
    property color textColor: "#C4CCC3"

    property alias bubbleButtonMouseArea: bubbleButtonMouseArea1

    Text {
        id: textItem

        text: box.text
        color: box.textColor
        font.family: box.fontFamily
        font.pixelSize: box.fontSize
        font.bold: box.bold
        font.weight: Font.Bold

        anchors {
            left: parent.left
            leftMargin: box.horizontalPadding
            verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        id: bubbleButtonMouseArea1
        anchors.fill: parent
        hoverEnabled: true
    }
}
