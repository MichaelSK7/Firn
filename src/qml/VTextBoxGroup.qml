pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
    id: root

    width: contentColumn.implicitWidth + 8
    height: contentColumn.implicitHeight + 8

    property list<string> texts: ["First", "Second", "Third"]
    property list<string> helpTexts: ["First", "Second", "Third"]
    property int boxWidth: 150
    property int boxHeight: 20
    property int boxSpacing: 5
    property bool isInputAllowed: false

    radius: 5
    color: "#eee6d6"

    border {
        color: "#660099"
        width: 1
    }

    Column {
        id: contentColumn

        spacing: root.boxSpacing
        anchors.centerIn: parent

        Repeater {
            id: boxRepeater
            model: root.texts.length

            Rectangle {
                id: box
                required property int index

                width: root.boxWidth
                height: root.boxHeight
                color: mouseArea.containsMouse ? "#d1b2e0" : "#eee6d6" // d1b2e0 eee6d6
                radius: 5
                antialiasing: true

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent

                    hoverEnabled: true
                }

                Text {
                    id: boxText
                    text: root.texts[box.index]
                    color: "#320051"

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
                    color: "#320051"
                    opacity: 0.5

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
