pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
    id: box
    width: customWidth > 0 ? customWidth : textItem.implicitWidth + horizontalPadding * 2
    height: buttonHeight
    radius: buttonRadius
    antialiasing: true
    color: mouseArea.containsMouse ? secondaryColor : primaryColor
    border.width: borderWidth
    border.color: "black"

    property string text: ""
    property string fontFamily: "Soegoe UI"
    property int fontSize: 14
    property bool bold: false

    property int buttonWidth: 20
    property int buttonHeight: 20
    property int buttonRadius: 8
    property int borderWidth: 2

    property int horizontalPadding: 8
    property real customWidth: 0

    property color primaryColor: "#495149"
    property color secondaryColor: "#313831"
    property color textColor: "#D4D4D4"

    Text {
        id: textItem
        color: box.textColor

        anchors.fill: parent
        anchors.leftMargin: box.horizontalPadding
        anchors.rightMargin: box.horizontalPadding

        verticalAlignment: Text.AlignVCenter
        text: box.text
        font.pixelSize: box.fontSize
        font.bold: box.bold
        font.family: box.fontFamily
        font.weight: Font.Thin
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
