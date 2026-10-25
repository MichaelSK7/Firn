pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
    id: root
    signal actionTriggered
    width: contentColumn.implicitWidth + 8
    height: contentColumn.implicitHeight + 8
    radius: boxRadius
    color: secondaryColor
    border.width: borderWidth
    border.color: "black"
    antialiasing: false

    property var items: []

    property int boxWidth: 150
    property int boxHeight: 20
    property int boxSpacing: 5

    property string fontFamily: "Inter"
    property int fontSize: 12
    property bool bold: false

    property int borderWidth: 2
    property int boxRadius: 4

    property color primaryColor: "#50565c"
    property color secondaryColor: "#3f4449"
    property color textColor: "#C4CCC3"

    Column {
        id: contentColumn
        spacing: root.boxSpacing
        anchors.centerIn: parent

        Repeater {
            id: boxRepeater
            model: root.items

            delegate: BubbleRect {
                id: box
                required property int index
                required property var modelData

                width: root.boxWidth
                height: root.boxHeight

                radius: 4
                antialiasing: true
                color: boxMouseArea.containsMouse ? root.primaryColor : root.secondaryColor
                MouseArea {
                    id: boxMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if (box.modelData.action) {
                            box.modelData.action();
                            root.actionTriggered();
                        }
                    }
                }
                Text {
                    id: boxText
                    text: box.modelData.text
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
                    text: box.modelData.helpText
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
