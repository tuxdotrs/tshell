import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray
import qs.config

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

            implicitHeight: 50
            implicitWidth: 1150

            Rectangle {
                anchors.fill: parent
                anchors.topMargin: 10
                radius: Appearance.radius
                color: Appearance.colors.background

                FlexboxLayout {
                    id: flexLayout
                    anchors.fill: parent
                    anchors.margins: Appearance.margin

                    wrap: FlexboxLayout.Wrap
                    direction: FlexboxLayout.Row
                    justifyContent: FlexboxLayout.JustifySpaceBetween

                    Rectangle {
                        color: 'transparent'
                        implicitHeight: parent.height
                        Layout.fillWidth: true

                        Row {
                            Layout.fillWidth: true
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            spacing: Appearance.spacing

                            Button {
                                padding: Appearance.padding
                                display: AbstractButton.IconOnly

                                icon.color: Appearance.colors.foreground
                                icon.source: Quickshell.shellPath("assets") + "/icons/nix.svg"
                                onClicked: {
                                    Quickshell.execDetached(["vicinae", "toggle"]);
                                }

                                hoverEnabled: true

                                HoverHandler {
                                    cursorShape: Qt.PointingHandCursor
                                }

                                background: Rectangle {
                                    anchors.fill: parent
                                    radius: Appearance.radius
                                    color: parent.hovered ? Appearance.colors.inActive : Appearance.colors.background

                                    Behavior on color {
                                        ColorAnimation {
                                            duration: Appearance.duration
                                        }
                                    }
                                }
                            }

                            Button {
                                property real percentage: Math.round(UPower.displayDevice.percentage * 100)
                                property real energyRate: UPower.displayDevice.changeRate
                                property string iconBase: Quickshell.shellPath("assets") + "/icons/"
                                property string iconName: parent.percentage < 30 ? "battery-low.svg" : parent.percentage < 70 ? "battery-medium.svg" : "battery-full.svg"

                                padding: Appearance.padding

                                text: `${percentage}% ${energyRate}W`
                                palette.buttonText: Appearance.colors.foreground
                                font.family: Appearance.font.family
                                font.pointSize: Appearance.font.pointSize

                                icon.color: Appearance.colors.foreground
                                icon.source: iconBase + iconName

                                background: Rectangle {
                                    anchors.fill: parent
                                    radius: Appearance.radius
                                    color: Appearance.colors.inActive
                                }
                            }
                        }
                    }

                    Rectangle {
                        color: 'transparent'
                        implicitHeight: parent.height
                        Layout.fillWidth: true

                        Row {
                            Layout.fillWidth: true
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: Appearance.spacing

                            Repeater {
                                model: 7

                                Rectangle {
                                    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                                    Layout.alignment: Qt.AlignVCenter
                                    radius: 1000
                                    implicitHeight: 15

                                    implicitWidth: isActive ? this.implicitHeight * 2.3 : this.implicitHeight

                                    color: {
                                        if (handler.hovered) {
                                            return Appearance.colors.accent;
                                        } else if (isActive || ws) {
                                            return Appearance.colors.accent;
                                        } else {
                                            return Appearance.colors.inActive;
                                        }
                                    }

                                    MouseArea {
                                        hoverEnabled: true
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: Hyprland.dispatch("workspace " + (index + 1))
                                    }

                                    Behavior on color {
                                        ColorAnimation {
                                            duration: Appearance.duration
                                        }
                                    }
                                    HoverHandler {
                                        id: handler
                                    }

                                    Behavior on implicitWidth {
                                        NumberAnimation {
                                            duration: Appearance.duration
                                            easing.type: Easing.OutQuad
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Rectangle {
                        color: 'transparent'
                        implicitHeight: parent.height
                        Layout.fillWidth: true

                        Row {
                            Layout.fillWidth: true
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            spacing: Appearance.spacing

                            Button {
                                padding: Appearance.padding
                                display: AbstractButton.IconOnly

                                icon.color: Appearance.colors.foreground
                                icon.source: Quickshell.shellPath("assets") + "/icons/wifi.svg"
                                onClicked: {
                                    Quickshell.execDetached(["vicinae", "vicinae://extensions/dagimg-dot/wifi-commander/scan-wifi"]);
                                }

                                hoverEnabled: true

                                HoverHandler {
                                    cursorShape: Qt.PointingHandCursor
                                }

                                background: Rectangle {
                                    anchors.fill: parent
                                    radius: Appearance.radius
                                    color: parent.hovered ? Appearance.colors.inActive : Appearance.colors.background

                                    Behavior on color {
                                        ColorAnimation {
                                            duration: Appearance.duration
                                        }
                                    }
                                }
                            }

                            Button {
                                padding: Appearance.padding
                                display: AbstractButton.IconOnly

                                icon.color: Appearance.colors.foreground
                                icon.source: Quickshell.shellPath("assets") + "/icons/bluetooth.svg"
                                onClicked: {
                                    Quickshell.execDetached(["vicinae", "vicinae://extensions/Gelei/bluetooth/devices"]);
                                }

                                hoverEnabled: true

                                HoverHandler {
                                    cursorShape: Qt.PointingHandCursor
                                }

                                background: Rectangle {
                                    anchors.fill: parent
                                    radius: Appearance.radius
                                    color: parent.hovered ? Appearance.colors.inActive : Appearance.colors.background

                                    Behavior on color {
                                        ColorAnimation {
                                            duration: Appearance.duration
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                implicitWidth: sysTrayRow.implicitWidth + 10
                                implicitHeight: parent.height
                                radius: Appearance.radius
                                color: Appearance.colors.inActive

                                Row {
                                    id: sysTrayRow

                                    anchors.centerIn: parent
                                    spacing: Appearance.spacing

                                    Repeater {
                                        model: SystemTray.items.values.length
                                        Image {
                                            source: SystemTray.items.values[index].icon
                                            height: parent.parent.height - 15
                                            width: parent.parent.height - 15
                                        }
                                    }
                                }
                            }

                            Button {
                                padding: Appearance.padding
                                text: Time.time

                                palette.buttonText: Appearance.colors.foreground
                                font.family: Appearance.font.family
                                font.pointSize: Appearance.font.pointSize

                                background: Rectangle {
                                    anchors.fill: parent
                                    radius: Appearance.radius
                                    color: Appearance.colors.inActive
                                }
                            }

                            Button {
                                padding: Appearance.padding
                                display: AbstractButton.IconOnly

                                icon.color: Appearance.colors.foreground
                                icon.source: Quickshell.shellPath("assets") + "/icons/ghost.svg"

                                hoverEnabled: true

                                HoverHandler {
                                    cursorShape: Qt.PointingHandCursor
                                }

                                background: Rectangle {
                                    anchors.fill: parent
                                    radius: Appearance.radius
                                    color: parent.hovered ? Appearance.colors.inActive : Appearance.colors.background

                                    Behavior on color {
                                        ColorAnimation {
                                            duration: Appearance.duration
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
