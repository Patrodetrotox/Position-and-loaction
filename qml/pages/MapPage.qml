import QtQuick 2.6
import QtQuick.Controls 2.2

import QtPositioning 5.3
import QtLocation 5.0
import "../assets"

Page {
    title: qsTr("Map")

    NmeaPositionSource { id: positionSource }
    Map {
        id: map
        anchors.fill: parent
        // ToDo: define plugin to work with OSM
        plugin: Plugin {
            allowExperimental: true
            name: "osm"
            required.mapping: Plugin.AnyMappingFeatures
            required.geocoding: Plugin.AnyGeocodingFeatures
        }
        // ToDo: enable gesture recognition
        // ToDo: bind zoomLevel property to slider value

        // ToDo: add binding of the map center to the position coordinate

        // ToDo: create MouseArea to handle clicks and holds

        Component.onCompleted: center = QtPositioning.coordinate(55.751244, 37.618423)

        MouseArea {
            anchors.fill: parent
            onPressAndHold: {
                var circle = Qt.createQmlObject("import QtLocation 5.0; MapCircle {}", map)
                circle.color = "green"
                circle.radius = 5
                circle.border.width = 0
                circle.center = map.toCoordinate(Qt.point(mouse.x, mouse.y))
                map.addMapItem(circle)
            }
            onClicked: {
                var circle = mapQuickCircleComponent.createObject(map)
                circle.color = "red"
                circle.border.width = 10
                circle.radius = 50
                circle.coordinate = map.toCoordinate(Qt.point(mouse.x, mouse.y))
                map.addMapItem(circle)
            }
        }

    }
    // ToDo: add a slider to control zoom level

    // ToDo: add a component corresponding to MapQuickCircle
    Slider {
        id: zoomLevelSlider
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        from: map.minimumZoomLevel
        to: map.maximumZoomLevel
        value: map.zoomLevel
        onValueChanged: map.zoomLevel = value
    }

    Footprints {
        id: footprints
        coordinate: positionSource.position.coordinate
        diameter: Math.min(map.width, map.height) / 16
    }

    // ToDo: add item at the current position
    Binding {
        target: map
        property: "center"
        value: positionSource.position.coordinate
        when: false //positionSource.position.coordinate.isValid
    }
    Component.onCompleted: {
        map.addMapItem(footprints)
    }
    Component {
        id: mapQuickCircleComponent

        MapQuickCircle { }
    }
}
