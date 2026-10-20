pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
    id: box
    width: Math.round(buttonWidth > textItem.implicitWidth + horizontalPadding * 2 ? buttonWidth : textItem.implicitWidth + horizontalPadding * 2)
    height: Math.round(buttonHeight)
    radius: buttonRadius
    antialiasing: true
    color: mouseArea.containsMouse ? primaryColor : "transparent "

    property string text: ""
    property string fontFamily: "Inter"
    property int fontSize: 12
    property bool bold: false

    property int buttonWidth: 20
    property int buttonHeight: 20
    property int borderWidth: 2
    property int buttonRadius: 4

    property int horizontalPadding: 8

    property color primaryColor: "#495149"
    property color secondaryColor: "#313831"
    property color textColor: "#C4CCC3"

    property alias mouseArea: mArea

    Text {
        id: textItem
        color: box.textColor

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: Math.round(box.horizontalPadding)

        width: Math.round(parent.width - (box.horizontalPadding * 2))

        renderType: Text.QtRendering

        verticalAlignment: Text.AlignVCenter

        text: box.text
        font.pixelSize: box.fontSize
        font.bold: box.bold
        font.family: box.fontFamily
        font.weight: Font.Bold
    }

    MouseArea {
        id: mArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
