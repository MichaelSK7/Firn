pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
    id: box
    width: buttonWidth > textItem.implicitWidth + horizontalPadding * 2 ? buttonWidth : textItem.implicitWidth + horizontalPadding * 2
    height: buttonHeight
    radius: buttonRadius
    antialiasing: false
    color: mouseArea.containsMouse ? primaryColor : "transparent " // mouseArea.containsMouse ? secondaryColor : primaryColor

    property string text: ""
    property string fontFamily: "Soegoe UI"
    property int fontSize: 14
    property bool bold: false

    property int buttonWidth: 20
    property int buttonHeight: 20
    property int borderWidth: 2
    property int buttonRadius: 8

    property int horizontalPadding: 8

    property color primaryColor: "#495149"
    property color secondaryColor: "#313831"
    property color textColor: "#C4CCC3"

    property alias mouseArea: mArea

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
        font.weight: Font.Bold
    }

    MouseArea {
        id: mArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
