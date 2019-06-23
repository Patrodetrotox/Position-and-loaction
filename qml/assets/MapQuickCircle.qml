import QtQuick 2.6
import QtLocation 5.0

MapQuickItem {
    property alias radius: rectangle.radius
    property alias color: rectangle.color
    property alias border: rectangle.border

    width: rectangle.width
    height: rectangle.height

    sourceItem: Rectangle {
        id: rectangle
        border.color: "black"
        width: 2 * radius
        height: width
    }
    anchorPoint { x: width / 2; y: height / 2 }
}
