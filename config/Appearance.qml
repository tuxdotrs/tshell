pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

Singleton {
    id: root
    property QtObject colors
    property QtObject font

    property int margin
    property int radius
    property int spacing
    property int padding
    property int duration

    margin: 8
    radius: 8
    spacing: 8
    padding: 8
    duration: 150

    font: QtObject {
        property string family: "FiraCode Nerd Font Mono SemBd"
        property int pointSize: 9
    }

    colors: QtObject {
        property color accent: "#6791c9"
        property color foreground: "#ffffff"
        property color background: "#101213"
        property color inActive: "#1b1d1e"
    }
}
