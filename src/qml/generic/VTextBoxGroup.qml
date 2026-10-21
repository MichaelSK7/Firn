pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
    id: root
    width: contentColumn.implicitWidth + 8
    height: contentColumn.implicitHeight + 8
    radius: boxRadius
    color: secondaryColor
    border.width: borderWidth
    border.color: "black"
    antialiasing: false

    property list<string> texts: ["First", "Second", "Third"]
    property list<string> helpTexts: ["First", "Second", "Third"]
    property int boxWidth: 150
    property int boxHeight: 20
    property int boxSpacing: 5

    property string fontFamily: "Inter"
    property int fontSize: 12
    property bool bold: false

    property int borderWidth: 1
    property int boxRadius: 4

    property color primaryColor: "#495149"
    property color secondaryColor: "#313831"
    property color textColor: "#C4CCC3"

    Column {
        id: contentColumn
        spacing: root.boxSpacing
        anchors.centerIn: parent

        Repeater {
            id: boxRepeater
            model: root.texts.length

            BubbleButton {
                id: box
                required property int index
                width: root.boxWidth
                height: root.boxHeight
                radius: 4
                antialiasing: true

                Text {
                    id: boxText
                    text: root.texts[box.index]
                    font.pixelSize: root.fontSize
                    font.bold: root.bold
                    font.family: root.fontFamily
                    font.weight: Font.Bold
                    color: root.textColor

                    anchors {
                        fill: parent
                        left: box.left

                        leftMargin: 5
                    }

                    verticalAlignment: TextInput.AlignVCenter
                }
                Text {
                    id: helpText
                    text: root.helpTexts[box.index]
                    font.pixelSize: root.fontSize
                    font.bold: root.bold
                    font.family: root.fontFamily
                    font.weight: Font.Bold
                    opacity: 0.5
                    color: root.textColor

                    anchors {
                        verticalCenter: boxText.verticalCenter
                        right: box.right
                        rightMargin: 5
                    }

                    verticalAlignment: TextInput.AlignVCenter
                }
            }
        }
    }
}
