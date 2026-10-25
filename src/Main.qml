import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Dialogs
import "qml/generic"

ApplicationWindow {
    id: window
    width: 640
    height: 480
    minimumWidth: 640
    minimumHeight: 480
    title: "Firn"
    visible: true
    color: "transparent"

    flags: Qt.Window | Qt.FramelessWindowHint

    property string currentPresetName: userData.currentPresetName

    property string generalFontFamily: "Inter"
    property int generalFontSize: 12
    property int generalRadius: 4
    property int generalBorderWidth: 1
    property color generaltextColor: "#C4CCC3"

    property color mainBackgroundColor: "#1f2326"
    property color secondaryBackgroundColor: "#0e130e"
    property color mainBorderColor: "#000000"
    property color mainColor: "#50565c"
    property color mainMiscColor: "#71833b"
    property color accentColor: "#2d682d"

    property color primaryButtonBackgroundColor: "#50565c"
    property color secondaryButtonBackgroundColor: "#1f2326"

    property color mainButtonColor: "#213a21"

    property var popups: [presetPopup, filePopup]
    function closeAllPopups() {
        for (let popup of popups) {
            popup.visible = false;
        }
    }

    Rectangle {
        id: screen
        z: 1
        anchors.fill: parent
        radius: window.visibility === Window.Maximized ? 0 : window.generalRadius
        antialiasing: true
        color: window.mainBackgroundColor
        border.width: window.generalBorderWidth
        border.color: "black"

        Item {
            id: titleBar
            height: 30
            z: 20
            width: titleBarButtons.implicitWidth
            antialiasing: true
            anchors {
                top: screen.top
                left: screen.left
                right: screen.right
                leftMargin: 4
                rightMargin: 5
            }
            Row {
                id: titleBarButtons
                z: 21

                anchors {
                    left: titleBar.left
                    leftMargin: 4
                    top: titleBar.top
                    topMargin: 5
                }

                BubbleButton {
                    id: fileButton
                    text: "Edit"
                    bubbleButtonMouseArea.onClicked: {
                        if (filePopup.visible == true) {
                            window.closeAllPopups();
                            return;
                        }
                        window.closeAllPopups();
                        filePopup.visible = true;
                    }
                    secondaryColor: {
                        if (filePopup.visible == true) {
                            return "#50565c";
                        } else {
                            return "transparent";
                        }
                    }
                }

                BubbleButton {
                    id: presetButton
                    text: "Presets"
                    bubbleButtonMouseArea.onClicked: {
                        if (presetPopup.visible == true) {
                            window.closeAllPopups();
                            return;
                        }
                        window.closeAllPopups();
                        presetPopup.visible = true;
                    }
                    secondaryColor: {
                        if (presetPopup.visible == true) {
                            return "#50565c";
                        } else {
                            return "transparent";
                        }
                    }
                }

                BubbleButton {
                    id: titleBarRun
                    text: "Run"
                }
            }
            VTextBoxGroup {
                id: filePopup
                visible: false
                z: 22

                x: presetButton.x + 3
                y: titleBarButtons.y + presetButton.height

                onActionTriggered: {
                    visible = false;
                }

                items: [
                    {
                        text: "New preset",
                        helpText: "Ctrl+N",
                        action: () => {
                            presetListLoader.setSource("qml/generic/NewPresetPopup.qml", {
                                "userDataObject": userData
                            });
                        }
                    }
                ]
            }

            VTextBoxGroup {
                id: presetPopup
                visible: false
                z: 22

                x: presetButton.x + 3
                y: titleBarButtons.y + presetButton.height

                onActionTriggered: {
                    visible = false;
                }

                items: [
                    {
                        text: "New preset",
                        helpText: "Ctrl+N",
                        action: () => {
                            newPresetLoader.setSource("qml/generic/NewPresetPopup.qml", {
                                "userDataObject": userData
                            });
                        }
                    }
                ]
            }

            Text {
                id: currentPresetLabel
                z: 15
                anchors.centerIn: parent
                text: "Preset: " + window.currentPresetName
                font.pixelSize: 12
                font.bold: true
                font.family: "Inter"
                font.weight: Font.Bold
                color: "#C4CCC3"
                opacity: 0.8
            }

            Item {
                id: titleBarWindow
                height: 30
                width: titleBarWindowButtons.width + 20
                antialiasing: true
                anchors {
                    top: screen.top
                    right: titleBar.right
                    verticalCenter: titleBar.verticalCenter
                }

                Row {
                    id: titleBarWindowButtons
                    spacing: 5
                    property int titleBarWindowButtonsRadius: 8

                    anchors {
                        verticalCenter: titleBarWindow.verticalCenter
                        right: titleBarWindow.right
                    }

                    Rectangle {
                        id: minimize
                        width: 20
                        height: 20
                        radius: titleBarWindowButtons.titleBarWindowButtonsRadius
                        color: minimizeMouseArea.containsMouse ? "dark green" /* window.primaryButtonBackgroundColor */ : window.secondaryButtonBackgroundColor

                        MouseArea {
                            id: minimizeMouseArea
                            anchors.fill: minimize
                            hoverEnabled: true
                            onClicked: window.showMinimized()
                        }

                        Rectangle {
                            width: 8
                            height: 2
                            color: window.generaltextColor
                            anchors.centerIn: parent
                        }
                    }

                    Rectangle {
                        id: exitProgram
                        width: 20
                        height: 20
                        radius: titleBarWindowButtons.titleBarWindowButtonsRadius
                        color: exitMouseArea.containsMouse ? "#c92032" : window.secondaryButtonBackgroundColor

                        property color crossIconColor: "black"

                        MouseArea {
                            id: exitMouseArea
                            anchors.fill: exitProgram
                            hoverEnabled: true
                            onClicked: Qt.quit()
                        }

                        Cross {
                            id: crossIcon
                            anchors.centerIn: parent
                            crossIconColor: window.generaltextColor
                            lineLength: 10
                            lineThickness: 2
                        }
                    }
                }
            }
        }
        Loader {
            id: newPresetLoader
            anchors.centerIn: parent
            z: 120
            Connections {
                target: newPresetLoader.item

                function onCloseRequested() {
                    newPresetLoader.source = "";
                }
            }
        }

        Loader {
            id: presetListLoader
            anchors {}
            z: 120
            Connections {
                target: newPresetLoader.item

                function onCloseRequested() {
                    newPresetLoader.source = "";
                }
            }
        }
        // ==================================================
        // CONTENT
        Item {
            id: content
            z: 2
            anchors {
                top: titleBar.bottom
                left: screen.left
                right: screen.right
                bottom: screen.bottom
                margins: 4
                topMargin: -2
            }

            Grid {
                property int buttonCount: rows + columns
                columns: 2
                rows: 6
                spacing: 4
                anchors {
                    fill: parent
                    leftMargin: 4
                }
                Repeater {
                    id: repeater
                    model: 10
                    anchors.fill: parent

                    delegate: Item {
                        id: dUnit
                        required property int index
                        objectName: "unit_" + index
                        width: 310
                        height: 86

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
                                    onClicked: folderDialog.open()
                                }
                                FolderDialog {
                                    id: folderDialog

                                    onAccepted: {
                                        console.log("Selected folder:", folderPathHelper.toLocalPath(folderDialog.selectedFolder));
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

                                        text: folderPathHelper.toLocalPath(folderDialog.selectedFolder)
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
                                        console.log("Selected folder:", folderPathHelper.toLocalPath(destinationFolderDialog.selectedFolder));
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
                                        text: folderPathHelper.toLocalPath(destinationFolderDialog.selectedFolder)
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
                }
            }
        }

        // ==================================================
        DragHandler {
            target: null
            onActiveChanged: {
                if (active) {
                    window.startSystemMove();
                }
            }
        }
    }
}
