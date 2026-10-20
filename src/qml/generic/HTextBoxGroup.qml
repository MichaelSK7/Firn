pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
    id: root

    width: contentColumn.implicitWidth + 8
    height: contentColumn.implicitHeight + 8
    radius: 4
    color: "#eee6d6"

    property list<string> texts: ["First", "Second", "Third"]
    property int boxWidth: 150
    property int boxHeight: 30
    property int boxSpacing: 4

    Column {
        id: contentColumn

        spacing: root.boxSpacing
        anchors.centerIn: parent

        Repeater {
            model: root.texts.length

            Rectangle {
                id: box
                required property int index

                width: root.boxWidth
                height: 20
                color: mouseArea.containsMouse ? "#d1b2e0" : "#eee6d6" // d1b2e0 eee6d6
                radius: 4

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent

                    hoverEnabled: true
                }

                Text {
                    id: boxText

                    text: root.texts[box.index]

                    anchors {
                        fill: parent
                        left: box.left

                        leftMargin: 5
                    }

                    horizontalAlignment: TextInput.AlignHCenter
                }
            }
        }
    }
}
