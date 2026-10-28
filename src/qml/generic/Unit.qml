pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Dialogs

Item {
    id: root
    width: 310
    height: 86

    property string sourcePath: sourceText.text
    property string destinationPath: destinationText.text
    property int unitIDCount: 0
    property var userDataObject

    BubbleRect {
        id: unit
        width: 310
        height: 86
        color: "#3f4449"
        border.color: "black"
        border.width: 2
        rectRadius: 4

        ScriptButton {
            id: selectButton
            antialiasing: true
            width: 64
            height: 64
            property bool selected: false
            color: selected ? "#660099" : "#50565c"
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 4
                topMargin: 4
            }
            Text {
                anchors.centerIn: parent
                text: "SELECT"
                font.pixelSize: 12
                font.bold: true
                font.family: "Inter"
                font.weight: Font.Bold
                color: "#C4CCC3"
            }
            MouseArea {
                id: mArea
                anchors.fill: parent
                onClicked: selectButton.selected = !selectButton.selected
            }
        }

        ScriptButton {
            id: sourceDialogButton
            width: 30
            height: 30

            anchors {
                right: selectButton.left
                top: selectButton.top
                rightMargin: 2
            }
            Text {
                anchors.centerIn: parent
                text: "S"
                font.pixelSize: 12
                font.bold: true
                font.family: "Inter"
                font.weight: Font.Bold
                color: "#C4CCC3"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: sourcefolderDialog.open()
            }
            FolderDialog {
                id: sourcefolderDialog
                onAccepted: {
                    userData.setUnitData(root.unitIDCount, folderPathHelper.toLocalPath(sourcefolderDialog.selectedFolder), true);
                }
            }
        }

        BubbleRect {
            id: sourceLabel
            width: 32
            height: 20
            color: "#50565c"
            border.color: "black"
            border.width: 2
            rectRadius: 4
            clip: true
            anchors {
                verticalCenter: sourceDialogButton.verticalCenter
                left: unit.left
                leftMargin: 6
                right: sourceDialogButton.left
                rightMargin: 4
            }
            Item {
                id: sourceTextViewport
                anchors {
                    left: parent.left
                    leftMargin: 4
                    right: parent.right
                    rightMargin: 4
                    top: parent.top
                    bottom: parent.bottom
                }
                clip: true
                Text {
                    id: sourceText
                    text: userData.units[root.unitIDCount].source //folderPathHelper.toLocalPath(sourcefolderDialog.selectedFolder)
                    font.pixelSize: 10
                    font.bold: true
                    font.family: "Inter"
                    color: "#C4CCC3"

                    y: (parent.height - height) / 2
                    onTextChanged: {
                        sourceScrollAnimation.stop();
                        x = 0;
                    }
                }
            }
            MouseArea {
                id: sourceLabelMouseArea
                anchors.fill: parent
                hoverEnabled: true
            }
            NumberAnimation {
                id: sourceScrollAnimation
                target: sourceText
                property: "x"
                from: 0
                to: -sourceText.width
                duration: 5000
                loops: Animation.Infinite

                running: sourceLabelMouseArea.containsMouse && sourceText.width > sourceTextViewport.width

                easing.type: Easing.Linear
            }
        }

        ScriptButton {
            id: destinationDialogButton
            width: 30
            height: 30
            anchors {
                right: selectButton.left
                bottom: selectButton.bottom
                rightMargin: 2
            }
            Text {
                x: 11
                y: 8
                text: "D"
                font.pixelSize: 12
                font.bold: true
                font.family: "Inter"
                font.weight: Font.Bold
                color: "#C4CCC3"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: destinationFolderDialog.open()
            }
            FolderDialog {
                id: destinationFolderDialog
                onAccepted: {
                    userData.setUnitData(root.unitIDCount, folderPathHelper.toLocalPath(destinationFolderDialog.selectedFolder), false);
                }
            }
        }

        BubbleRect {
            id: destinationLabel
            width: 32
            height: 20
            color: "#50565c"
            border.color: "black"
            border.width: 2
            rectRadius: 4
            anchors {
                verticalCenter: destinationDialogButton.verticalCenter
                left: unit.left
                leftMargin: 6
                right: destinationDialogButton.left
                rightMargin: 4
            }
            Item {
                id: destinationTextViewport

                anchors {
                    left: parent.left
                    leftMargin: 4
                    right: parent.right
                    rightMargin: 4
                    top: parent.top
                    bottom: parent.bottom
                }

                clip: true

                Text {
                    id: destinationText
                    text: userData.units[root.unitIDCount].destination //folderPathHelper.toLocalPath(destinationFolderDialog.selectedFolder)
                    font.pixelSize: 10
                    font.bold: true
                    font.family: "Inter"
                    color: "#C4CCC3"

                    y: (parent.height - height) / 2
                    onTextChanged: {
                        destinationScrollAnimation.stop();
                        x = 0;
                    }
                }
            }
            MouseArea {
                id: destinationLabelMouseArea
                anchors.fill: parent
                hoverEnabled: true
            }
            NumberAnimation {
                id: destinationScrollAnimation
                target: destinationText
                property: "x"
                from: 0
                to: -destinationText.width
                duration: 5000
                loops: Animation.Infinite

                running: destinationLabelMouseArea.containsMouse && destinationText.width > destinationTextViewport.width

                easing.type: Easing.Linear
            }
        }
    }
}
