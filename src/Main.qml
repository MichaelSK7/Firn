import QtQuick
import QtQuick.Controls.Basic
import "qml"

ApplicationWindow {
    id: window
    width: 640
    height: 480
    minimumWidth: 138
    minimumHeight: 68
    title: "Firn"
    visible: true
    color: "transparent"

    flags: Qt.Window | Qt.FramelessWindowHint

    property string generalFontFamily: "Inter"
    property int generalFontSize: 12
    property int generalRadius: 8
    property int generalBorderWidth: 2
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
        border.color: window.mainBorderColor

        Rectangle {
            id: titleBar
            height: 30
            radius: window.generalRadius
            antialiasing: true
            color: window.mainColor
            border.width: window.generalBorderWidth
            border.color: window.mainBorderColor

            anchors {
                top: screen.top
                left: screen.left
                right: screen.right
                margins: 5
            }

            Row {
                id: titleBarButtons
                spacing: 5

                anchors {
                    verticalCenter: titleBar.verticalCenter
                    margins: 10
                    left: titleBar.left
                }

                BubbleButton {
                    id: fileButton1
                    text: "File"
                    fontFamily: window.generalFontFamily
                    fontSize: window.generalFontSize
                }
                BubbleButton {
                    id: fileButton2
                    text: "Edit"
                    fontFamily: window.generalFontFamily
                    fontSize: window.generalFontSize
                }
                BubbleButton {
                    id: fileButton3
                    text: "View"
                    fontFamily: window.generalFontFamily
                    fontSize: window.generalFontSize
                }
                BubbleButton {
                    id: fileButton4
                    text: "Go"
                    fontFamily: window.generalFontFamily
                    fontSize: window.generalFontSize
                }
                BubbleButton {
                    id: fileButton5
                    text: "Run"
                    fontFamily: window.generalFontFamily
                    fontSize: window.generalFontSize
                }
                BubbleButton {
                    id: fileButton6
                    text: "Terminal"
                    fontFamily: window.generalFontFamily
                    fontSize: window.generalFontSize
                }
            }

            Row {
                id: titleBarWindowButtons
                spacing: 5
                property int titleBarWindowButtonsRadius: 8

                anchors {
                    verticalCenter: titleBar.verticalCenter
                    margins: 10
                    right: titleBar.right
                }

                Rectangle {
                    id: minimize
                    width: 20
                    height: 20
                    radius: titleBarWindowButtons.titleBarWindowButtonsRadius
                    antialiasing: true
                    color: minimizeMouseArea.containsMouse ? window.secondaryButtonBackgroundColor : window.primaryButtonBackgroundColor
                    border.width: window.generalBorderWidth
                    border.color: window.mainBorderColor

                    MouseArea {
                        id: minimizeMouseArea
                        anchors.fill: minimize
                        hoverEnabled: true
                        onClicked: window.showMinimized()
                    }

                    Rectangle {
                        width: 8
                        height: 2
                        anchors.centerIn: parent
                        color: window.generaltextColor
                    }
                }

                Rectangle {
                    id: maximize
                    width: 20
                    height: 20
                    radius: titleBarWindowButtons.titleBarWindowButtonsRadius
                    antialiasing: true
                    color: maximizeMouseArea.containsMouse ? window.secondaryButtonBackgroundColor : window.primaryButtonBackgroundColor
                    border.width: window.generalBorderWidth
                    border.color: window.mainBorderColor

                    Rectangle {
                        width: 8
                        height: 8
                        color: window.generaltextColor
                        anchors.centerIn: parent

                        Rectangle {
                            width: 4
                            height: 4
                            color: window.visibility === Window.Maximized ? parent.color : maximize.color
                            anchors.centerIn: parent
                        }
                    }

                    MouseArea {
                        id: maximizeMouseArea
                        anchors.fill: maximize
                        hoverEnabled: true
                        onClicked: {
                            if (window.visibility === Window.Maximized) {
                                window.showNormal();
                            } else {
                                window.showMaximized();
                            }
                        }
                    }
                }

                Rectangle {
                    id: exitProgram
                    width: 20
                    height: 20
                    radius: titleBarWindowButtons.titleBarWindowButtonsRadius
                    antialiasing: true
                    color: exitMouseArea.containsMouse ? "#c92032" : window.primaryButtonBackgroundColor
                    property color crossIconColor: "black"
                    border.width: window.generalBorderWidth
                    border.color: window.mainBorderColor

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

            DragHandler {
                target: null
                onActiveChanged: {
                    if (active) {
                        window.startSystemMove();
                    }
                }
            }

            Item {
                Component {
                    id: fileMenu
                    Row {
                        spacing: 30
                        anchors.centerIn: parent

                        VTextBoxGroup {
                            id: d
                            texts: ["New Text File", "New File", "New Window"]
                            helpTexts: ["Ctrl + N", "", ""]
                        }
                    }
                }

                Loader {
                    id: menuLoader
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // Unload or toggle the component
                        menuLoader.sourceComponent = menuLoader.sourceComponent === undefined ? fileMenu : undefined;
                    }
                }
            }
        }
        // ==================================================
        // CONTENT
        Rectangle {
            id: content
            color: window.mainColor
            height: 32
            radius: window.generalRadius
            antialiasing: true
            border.width: window.generalBorderWidth
            border.color: window.mainBorderColor

            anchors {
                top: titleBar.bottom
                left: screen.left
                right: screen.right
                bottom: screen.bottom
                margins: 5
            }

            Text {
                text: "This app is called Firn"
                anchors.centerIn: parent
                font.bold: true
                color: window.generaltextColor
            }
        }
    }
}
