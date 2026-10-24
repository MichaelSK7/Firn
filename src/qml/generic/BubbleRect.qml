pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
    id: box
    width: rectWidth
    height: rectHeight
    radius: rectRadius
    antialiasing: false
    color: "#3f4449"

    property string fontFamily: "Inter"
    property int fontSize: 12
    property bool bold: false

    property int rectWidth: 64
    property int rectHeight: 64
    property int rectRadius: 4
}
