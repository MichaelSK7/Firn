pragma ComponentBehavior: Bound
import QtQuick

Item {
    id: crossIcon

    property color crossIconColor: "black"
    property int lineLength: 12
    property int lineThickness: 1

    Rectangle {
        width: crossIcon.lineLength
        height: crossIcon.lineThickness
        rotation: 45

        color: crossIcon.crossIconColor
        anchors.centerIn: parent
    }
    Rectangle {
        width: crossIcon.lineLength
        height: crossIcon.lineThickness
        rotation: -45

        color: crossIcon.crossIconColor
        anchors.centerIn: parent
    }
}
