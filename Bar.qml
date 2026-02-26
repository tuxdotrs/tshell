import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            color: "transparent"

            anchors {
                top: true
            }

            implicitHeight: 30
            implicitWidth: 1200

            Rectangle {
                anchors.fill: parent
                radius: 8
                color: "#101213"
                clip: true

                RowLayout {
                    anchors.fill: parent
                    Rectangle {
                        color: handler.hovered ? "purple" : "gray"
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                Quickshell.execDetached(["vicinae", "toggle"]);
                            }
                        }

                        HoverHandler {
                            id: handler
                        }

                        Image {
                            id: launcherIcon
                            anchors.centerIn: parent
                            source: Quickshell.shellPath("assets") + "/icons/nix-symbolic.svg"
                            height: parent.height * 0.7
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                    Rectangle {
                        color: 'magenta'
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }
                    Rectangle {
                        color: 'yellow'
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

                        Clock {
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        }
    }
}
