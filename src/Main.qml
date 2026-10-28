import QtQuick
import QtQuick.Controls.Basic
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

    property var popups: [presetPopup]
    function closeAllPopups() {
        for (let popup of popups) {
            popup.visible = false;
        }
    }

    function tryQuit() {
        if (userData.isUnsaved === true) {
            console.log("wow");
            unSavedDialog.setSource("qml/generic/UnSavedDialog.qml");
        } else {
            Qt.quit();
            return;
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

        focus: true
        Keys.onPressed: event => {
            if (event.modifiers === Qt.ControlModifier && event.key === Qt.Key_E) {
                window.tryQuit();
            }
            if (event.modifiers === Qt.ControlModifier && event.key === Qt.Key_S) {
                userData.savePreset();
            }
            if (event.modifiers === Qt.ControlModifier && event.key === Qt.Key_N) {
                newPresetLoader.setSource("qml/generic/NewPresetPopup.qml", {
                    "userDataObject": userData
                });
            }
        }
        Loader {
            id: unSavedDialog
            anchors.centerIn: parent
            width: 250
            height: 150
            z: 120
            Connections {
                target: unSavedDialog.item

                function onCloseRequested() {
                    unSavedDialog.source = "";
                }
            }
        }
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
                    },
                    {
                        text: "Save preset",
                        helpText: "Ctrl+S",
                        action: () => {
                            userData.savePreset();
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
                            onClicked: window.tryQuit()
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
            width: 250
            height: 100
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
            width: 250
            height: 100
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

                Unit {
                    id: unit0
                    unitIDCount: 0
                }
                Unit {
                    id: unit1
                    unitIDCount: 1
                }
                Unit {
                    id: unit2
                    unitIDCount: 2
                }
                Unit {
                    id: unit3
                    unitIDCount: 3
                }
                Unit {
                    id: unit4
                    unitIDCount: 4
                }
                Unit {
                    id: unit5
                    unitIDCount: 5
                }
                Unit {
                    id: unit6
                    unitIDCount: 6
                }
                Unit {
                    id: unit7
                    unitIDCount: 7
                }
                Unit {
                    id: unit8
                    unitIDCount: 8
                }
                Unit {
                    id: unit9
                    unitIDCount: 9
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
