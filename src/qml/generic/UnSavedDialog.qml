pragma ComponentBehavior: Bound
import QtQuick

BubbleRect {
    id: root
    signal closeRequested
    color: "#1f2326"
    width: 250
    height: 150
    antialiasing: true
    border.color: "black"
    border.width: 2

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
            width: content.width - 16
            height: 80

            color: root.primaryColor
            border.color: "black"
            border.width: 2
            anchors {
                left: content.left
                top: content.top
                leftMargin: 8
                topMargin: 16
            }

            Text {
                id: textItem
                text: "Are you sure you don't want to\n save your precious preset :("
                color: root.textColor
                font.family: root.fontFamily
                font.pixelSize: root.fontSize
                font.bold: root.bold
                font.weight: Font.Bold

                anchors {
                    centerIn: contentField
                }

                Keys.onReturnPressed: {
                    root.closeRequested();
                }

                Keys.onEnterPressed: {
                    root.closeRequested();
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
                text: "Save"
                antialiasing: true
                border {
                    color: "black"
                    width: 2
                }
                bubbleButtonMouseArea.onClicked: {
                    userData.savePreset();
                    Qt.quit();
                }
                focus: true
                onActiveFocusChanged: {
                    border.color = "white";
                }
            }

            BubbleButton {
                id: saveDenial
                text: "Don't save"
                antialiasing: true

                bubbleButtonMouseArea.onClicked: Qt.quit()
                border {
                    color: "black"
                    width: 2
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
