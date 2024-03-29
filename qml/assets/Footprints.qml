import QtQuick 2.6
import QtLocation 5.0
MapQuickItem {
    property alias diameter: image.width
    sourceItem: Image {
        id: image
        source: Qt.resolvedUrl("../graphics/footprints.svg")
        width: objectSize
        height: width
        fillMode: Image.PreserveAspectFit
    }
    anchorPoint { x: width / 2; y: height / 2 }
}
