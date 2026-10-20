pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
    id: box
    width: rectWidth
    height: rectHeight
    radius: rectRadius
    antialiasing: false
    color: "#313831"

    property string text: ""
    property string fontFamily: "Soegoe UI"
    property int fontSize: 14
    property bool bold: false

    property int rectWidth: 20
    property int rectHeight: 20
    property int rectRadius: 8
    property int borderWidth: 2

    property int horizontalPadding: 8
}
