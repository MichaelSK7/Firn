pragma ComponentBehavior: Bound
import QtQuick

BubbleRect {
    id: root
    signal closeRequested
    color: "#1f2326"
    width: 250
    height: 100
    antialiasing: true
    border.color: "black"
    border.width: 2

    property var userDataObject

    property string text: ""
    property int buttonWidth: 20
    property int buttonHeight: 20
    property int buttonRadius: 4
    property int horizontalPadding: 8
    property color primaryColor: "#50565c"
    property color secondaryColor: "transparent"
    property color textColor: "#C4CCC3"

    BubbleRect {
        id: content
        width: root.width - 6
        height: root.height - 6
        anchors.centerIn: root
        border.color: "black"
        border.width: 2
        BubbleRect {
            id: contentField
            width: 200

            height: root.buttonHeight
            color: root.primaryColor
            border.color: "black"
            border.width: 2
            anchors.centerIn: content

            TextInput {
                id: textItem
                focus: true
                property int maxCharacters: 200
                text: root.text
                color: root.textColor
                font.family: root.fontFamily
                font.pixelSize: root.fontSize
                font.bold: root.bold
                font.weight: Font.Bold

                selectByMouse: true
                maximumLength: 20

                anchors {
                    left: contentField.left
                    leftMargin: root.horizontalPadding
                    verticalCenter: contentField.verticalCenter
                }

                Keys.onReturnPressed: {
                    root.userDataObject.currentPresetName = text;
                    root.closeRequested();
                }

                Keys.onEnterPressed: {
                    root.userDataObject.currentPresetName = text;
                    root.closeRequested();
                }
                Text {
                    id: placeholderText
                    text: "Enter a name..."
                    color: root.textColor
                    font.family: root.fontFamily
                    font.pixelSize: root.fontSize
                    opacity: 0.6
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                    }
                }
            }
        }

        Row {
            id: menuButtons
            anchors {
                right: content.right
                rightMargin: 4
                bottom: content.bottom
                bottomMargin: 4
            }
            spacing: 4
            BubbleButton {
                id: createButton
                text: "create"
                antialiasing: true

                border {
                    color: "black"
                    width: 2
                }
                bubbleButtonMouseArea.onClicked: {
                    root.userDataObject.currentPresetName = textItem.text;
                    root.userDataObject.makePreset(root.text);
                    root.closeRequested();
                }
            }
            BubbleButton {
                id: cancelButton
                text: "cancel"
                antialiasing: true

                bubbleButtonMouseArea.onClicked: root.closeRequested()
                border {
                    color: "black"
                    width: 2
                }
            }
        }
    }
}
