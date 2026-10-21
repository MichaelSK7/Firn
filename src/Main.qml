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

    property string generalFontFamily: "Inter"
    property int generalFontSize: 12
    property int generalRadius: 4
    property int generalBorderWidth: 1
    property color generaltextColor: "#C4CCC3"

    property color mainBackgroundColor: "#313831"
    property color secondaryBackgroundColor: "#0e130e"
    property color mainBorderColor: "#000000"
    property color mainColor: "#495149"
    property color mainMiscColor: "#71833b"
    property color accentColor: "#2d682d"

    property color primaryButtonBackgroundColor: "#495149"
    property color secondaryButtonBackgroundColor: "#313831"

    property color mainButtonColor: "#213a21"

    Rectangle {
        id: screen
        anchors.fill: parent
        radius: window.visibility === Window.Maximized ? 0 : window.generalRadius
        antialiasing: true
        color: window.mainBackgroundColor
        clip: true
        border.width: window.generalBorderWidth
        border.color: "black"

        Item {
            id: titleBar
            height: 30
            z: 100
            width: titleBarButtons.implicitWidth
            antialiasing: true
            anchors {
                top: screen.top
                left: screen.left
                right: screen.right
                leftMargin: 4
                rightMargin: 5
            }

            Item {
                id: appIcon
                width: 16

                anchors {
                    left: titleBar.left
                    top: titleBar.top
                    bottom: titleBar.bottom
                    leftMargin: 4
                }

                Image {
                    source: "qrc:/qt/qml/Firn/res/assets/Firn_appIcon.png"
                    width: 16
                    height: 16
                    anchors.centerIn: parent
                }
            }

            Row {
                id: titleBarButtons
                anchors {
                    left: appIcon.right
                    leftMargin: 0
                    verticalCenter: parent.verticalCenter
                }

                BubbleButton {
                    id: fileButton
                    text: "File"
                    mouseArea.onClicked: filePopup.visible = !filePopup.visible

                    VTextBoxGroup {
                        id: filePopup
                        z: 1
                        anchors {
                            left: fileButton.left
                            top: fileButton.bottom
                            margins: 0
                        }
                        visible: false
                        texts: ["New file", "Open file", "Open folder"]
                    }
                }
                BubbleButton {
                    id: editButton
                    text: "Edit"
                }
                BubbleButton {
                    id: viewButton
                    text: "View"
                }
                BubbleButton {
                    id: goButton
                    text: "Go"
                }
                BubbleButton {
                    id: runButton
                    text: "Run"
                }
                BubbleButton {
                    id: terminalButton
                    text: "Terminal"
                }
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

                    //Rectangle {
                    //    id: maximize
                    //    width: 20
                    //    height: 20
                    //    radius: titleBarWindowButtons.titleBarWindowButtonsRadius
                    //    color: maximizeMouseArea.containsMouse ? "dark orange" /* window.primaryButtonBackgroundColor */ : window.secondaryButtonBackgroundColor
                    //
                    //    Rectangle {
                    //        width: 8
                    //        height: 8
                    //        color: window.generaltextColor
                    //        anchors.centerIn: parent
                    //
                    //        Rectangle {
                    //            width: 4
                    //            height: 4
                    //            color: window.visibility === Window.Maximized ? parent.color : maximize.color
                    //            anchors.centerIn: parent
                    //        }
                    //    }
                    //
                    //    MouseArea {
                    //        id: maximizeMouseArea
                    //        anchors.fill: maximize
                    //        hoverEnabled: true
                    //        onClicked: {
                    //            if (window.visibility === Window.Maximized) {
                    //                window.showNormal();
                    //            } else {
                    //                window.showMaximized();
                    //            }
                    //        }
                    //    }
                    //}

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

        // ==================================================
        // CONTENT
        Item {
            id: content
            anchors {
                top: titleBar.bottom
                left: screen.left
                right: screen.right
                bottom: screen.bottom
                margins: 4
                topMargin: -2
            }

            BubbleRect {
                id: leftPanel
                width: 140
                color: window.mainColor
                border.color: "black"
                border.width: window.generalBorderWidth
                rectRadius: window.generalRadius
                anchors {
                    left: content.left
                    top: content.top
                    bottom: content.bottom
                    rightMargin: 3
                }

                Grid {
                    property int buttonCount: columns + rows
                    columns: 2
                    rows: 6
                    spacing: 4
                    anchors {
                        left: parent.left
                        top: parent.top
                        leftMargin: 4
                        topMargin: 4
                    }

                    Repeater {
                        id: repeater
                        model: 12
                        ScriptButton {
                            id: scriptbutton
                            required property int index
                            Text {
                                anchors.centerIn: parent
                                text: (scriptbutton.index + 1).toString()
                                font.bold: true
                                font.pixelSize: 16
                            }
                        }
                    }
                }
            }

            BubbleRect {
                id: mainPanel
                color: window.mainColor
                border.color: "black"
                border.width: window.generalBorderWidth
                rectRadius: window.generalRadius
                anchors {
                    left: leftPanel.right
                    right: content.right
                    top: content.top
                    bottom: content.bottom
                    leftMargin: 3
                }

                Button {
                    text: "Open File Explorer"
                    anchors.centerIn: parent
                    onClicked: {
                        fileDialog.open();
                    }
                }

                FileDialog {
                    id: fileDialog
                    title: "Select a file"
                    onAccepted: {
                        console.log("Selected file: " + selectedFile);
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
