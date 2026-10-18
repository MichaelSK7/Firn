import QtQuick
import QtQuick.Controls.Basic
import "qml"

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
            width: titleBarButtons.implicitWidth
            antialiasing: true
            anchors {
                top: screen.top
                left: screen.left
                right: screen.right
                leftMargin: 5
                rightMargin: 5
            }

            Row {
                id: titleBarButtons
                anchors {
                    left: titleBar.left

                    verticalCenter: parent.verticalCenter
                }

                BubbleButton {
                    id: fileButton1
                    text: "File"
                    fontFamily: window.generalFontFamily
                    fontSize: window.generalFontSize
                    buttonRadius: window.generalRadius
                }
                BubbleButton {
                    id: fileButton2
                    text: "Edit"
                    fontFamily: window.generalFontFamily
                    fontSize: window.generalFontSize
                    buttonRadius: window.generalRadius
                }
                BubbleButton {
                    id: fileButton3
                    text: "View"
                    fontFamily: window.generalFontFamily
                    fontSize: window.generalFontSize
                    buttonRadius: window.generalRadius
                }
                BubbleButton {
                    id: fileButton4
                    text: "Go"
                    fontFamily: window.generalFontFamily
                    fontSize: window.generalFontSize
                    buttonRadius: window.generalRadius
                }
                BubbleButton {
                    id: fileButton5
                    text: "Run"
                    fontFamily: window.generalFontFamily
                    fontSize: window.generalFontSize
                    buttonRadius: window.generalRadius
                }
                BubbleButton {
                    id: fileButton6
                    text: "Terminal"
                    fontFamily: window.generalFontFamily
                    fontSize: window.generalFontSize
                    buttonRadius: window.generalRadius
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
                        right: parent.right
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
                            anchors.centerIn: parent
                            color: window.generaltextColor
                        }
                    }

                    Rectangle {
                        id: maximize
                        width: 20
                        height: 20
                        radius: titleBarWindowButtons.titleBarWindowButtonsRadius
                        color: maximizeMouseArea.containsMouse ? "dark orange" /* window.primaryButtonBackgroundColor */ : window.secondaryButtonBackgroundColor

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
            height: 32

            anchors {
                top: titleBar.bottom
                left: screen.left
                right: screen.right
                bottom: screen.bottom

                topMargin: 0
                margins: 4
            }

            BubbleRect {
                id: leftPanel
                width: 200
                height: 200
                color: window.mainColor
                border.color: "black"
                border.width: window.generalBorderWidth
                rectRadius: window.generalRadius
                anchors {
                    left: content.left
                    top: content.top
                    bottom: content.bottom
                    rightMargin: 2
                }
            }
            BubbleRect {
                id: mainPanel
                width: 200
                height: 200
                color: window.mainColor
                border.color: "black"
                border.width: window.generalBorderWidth
                rectRadius: window.generalRadius
                anchors {
                    left: leftPanel.right
                    right: content.right
                    top: content.top
                    bottom: content.bottom
                    leftMargin: 2
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
