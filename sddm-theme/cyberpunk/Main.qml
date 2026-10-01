// Cyberpunk SDDM Theme — Main.qml
// Matches n0vip's Hyprland/Waybar/Rofi/Kitty setup perfectly!
// Includes exact 4s cyberShift animations, 2px/2px box-shadows, text-shadow glows,
// and exactly 600px width / 3px border / 15px padding to match Rofi.

import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

Pane {
    id: root

    height: config.ScreenHeight || Screen.height
    width:  config.ScreenWidth  || Screen.width
    padding: 0

    // ── 4-second animated colors matching waybar cyberShift ──
    // Phase 0 starts at cyan
    property color col0: "#00ffcc"
    SequentialAnimation on col0 {
        loops: Animation.Infinite
        ColorAnimation { to: "#ff00aa"; duration: 1333 }
        ColorAnimation { to: "#fcee0a"; duration: 1333 }
        ColorAnimation { to: "#00ffcc"; duration: 1333 }
    }
    property color shadow0: "#aa0055"
    SequentialAnimation on shadow0 {
        loops: Animation.Infinite
        ColorAnimation { to: "#bb9900"; duration: 1333 }
        ColorAnimation { to: "#00ffcc"; duration: 1333 }
        ColorAnimation { to: "#aa0055"; duration: 1333 }
    }

    // Phase 1 starts at magenta
    property color col1: "#ff00aa"
    SequentialAnimation on col1 {
        loops: Animation.Infinite
        ColorAnimation { to: "#fcee0a"; duration: 1333 }
        ColorAnimation { to: "#00ffcc"; duration: 1333 }
        ColorAnimation { to: "#ff00aa"; duration: 1333 }
    }
    property color shadow1: "#bb9900"
    SequentialAnimation on shadow1 {
        loops: Animation.Infinite
        ColorAnimation { to: "#00ffcc"; duration: 1333 }
        ColorAnimation { to: "#aa0055"; duration: 1333 }
        ColorAnimation { to: "#bb9900"; duration: 1333 }
    }

    // Phase 2 starts at yellow
    property color col2: "#fcee0a"
    SequentialAnimation on col2 {
        loops: Animation.Infinite
        ColorAnimation { to: "#00ffcc"; duration: 1333 }
        ColorAnimation { to: "#ff00aa"; duration: 1333 }
        ColorAnimation { to: "#fcee0a"; duration: 1333 }
    }
    property color shadow2: "#00ffcc"
    SequentialAnimation on shadow2 {
        loops: Animation.Infinite
        ColorAnimation { to: "#aa0055"; duration: 1333 }
        ColorAnimation { to: "#bb9900"; duration: 1333 }
        ColorAnimation { to: "#00ffcc"; duration: 1333 }
    }

    palette.window:          "#090a0f"
    palette.windowText:      col0
    palette.base:            "#090a0f"
    palette.text:            col0
    palette.highlight:       "#ff00aa"
    palette.highlightedText: "#ffffff"
    palette.button:          "transparent"
    palette.buttonText:      col0

    font.family:    config.Font || "JetBrainsMono Nerd Font"
    font.pointSize: config.FontSize !== "" ? config.FontSize : parseInt(height / 80)
    focus: true

    Image {
        id: wallpaper
        anchors.fill: parent
        source: config.Background || config.background || ""
        fillMode: config.ScaleImageCropped == "true" ? Image.PreserveAspectCrop : Image.PreserveAspectFit
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment:   Image.AlignVCenter
        asynchronous: true
        cache: true
        mipmap: true
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: parseFloat(config.DimBackgroundImage) || 0
        z: 1
    }

    ShaderEffectSource {
        id: blurSource
        sourceItem: wallpaper
        width:  formPanel.width
        height: formPanel.height
        anchors.centerIn: formPanel
        sourceRect: Qt.rect(formPanel.x, formPanel.y, formPanel.width, formPanel.height)
        visible: false
    }

    GaussianBlur {
        anchors.centerIn: formPanel
        width:  formPanel.width
        height: formPanel.height
        source: blurSource
        radius:  parseInt(config.BlurRadius) || 55
        samples: (parseInt(config.BlurRadius) || 55) * 2 + 1
        cached: true
        visible: config.PartialBlur == "true" || config.FullBlur == "true"
        z: 2
    }

    // ── Main Rofi-style Window Panel ──
    Rectangle {
        id: formPanel
        anchors.centerIn: parent
        width: 600
        height: mainColumn.implicitHeight + 30
        color: Qt.rgba(9/255, 10/255, 15/255, 0.65) // 65% opacity like kitty
        border.color: "#ff00aa"
        border.width: 3
        z: 3

        ColumnLayout {
            id: mainColumn
            anchors.fill: parent
            anchors.margins: 15
            spacing: 15
            property bool failed: false

            // ── Header & Clock ──
            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 5

                Label {
                    text: config.HeaderText || "ACCESS TERMINAL"
                    Layout.alignment: Qt.AlignHCenter
                    font.family: root.font.family
                    font.pointSize: root.font.pointSize * 0.85
                    font.weight: Font.Bold
                    color: root.col1
                    layer.enabled: true
                    layer.effect: DropShadow { color: root.col1; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }
                }

                Label {
                    id: timeLabel
                    Layout.alignment: Qt.AlignHCenter
                    font.family: root.font.family
                    font.pointSize: root.font.pointSize * 3.2
                    font.weight: Font.Bold
                    color: root.col0
                    layer.enabled: true
                    layer.effect: DropShadow { color: root.col0; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }
                    function update() { text = new Date().toLocaleTimeString(Qt.locale(config.Locale || ""), config.HourFormat == "long" ? Locale.LongFormat : config.HourFormat !== "" ? config.HourFormat : Locale.ShortFormat) }
                }

                Label {
                    id: dateLabel
                    Layout.alignment: Qt.AlignHCenter
                    font.family: root.font.family
                    font.pointSize: root.font.pointSize * 0.95
                    font.weight: Font.Bold
                    color: root.col2
                    layer.enabled: true
                    layer.effect: DropShadow { color: root.col2; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }
                    function update() { text = new Date().toLocaleDateString(Qt.locale(config.Locale || ""), config.DateFormat == "short" ? Locale.ShortFormat : config.DateFormat !== "" ? config.DateFormat : Locale.LongFormat) }
                }
            }

            Timer {
                interval: 1000; repeat: true; running: true
                onTriggered: { timeLabel.update(); dateLabel.update() }
            }

            // ── Username ──
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 5

                Label {
                    text: config.TranslatePlaceholderUsername || "USER_ID"
                    Layout.alignment: Qt.AlignHCenter
                    font.family: root.font.family
                    font.pointSize: root.font.pointSize * 0.75
                    font.weight: Font.Bold
                    color: root.col0
                    layer.enabled: true
                    layer.effect: DropShadow { color: root.col0; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    color: "#090a0f"
                    border.color: root.col0
                    border.width: 2
                    
                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        color: root.shadow0
                        horizontalOffset: 2
                        verticalOffset: 2
                        radius: 5
                        samples: 11
                    }

                    TextInput {
                        id: username
                        anchors.fill: parent
                        anchors.margins: 10
                        verticalAlignment: TextInput.AlignVCenter
                        horizontalAlignment: TextInput.AlignHCenter
                        font.family: root.font.family
                        font.pointSize: root.font.pointSize
                        color: root.col0
                        selectionColor: "#ff00aa"
                        selectedTextColor: "#ffffff"
                        text: config.ForceLastUser == "true" ? userModel.lastUser : ""
                        KeyNavigation.tab: password
                        Keys.onReturnPressed: password.forceActiveFocus()
                        layer.enabled: true
                        layer.effect: DropShadow { color: root.col0; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }
                    }
                }
            }

            // ── Password ──
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 5

                Label {
                    text: config.TranslatePlaceholderPassword || "PASSKEY"
                    Layout.alignment: Qt.AlignHCenter
                    font.family: root.font.family
                    font.pointSize: root.font.pointSize * 0.75
                    font.weight: Font.Bold
                    color: root.col1
                    layer.enabled: true
                    layer.effect: DropShadow { color: root.col1; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    color: "#090a0f"
                    border.color: root.col1
                    border.width: 2
                    
                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        color: root.shadow1
                        horizontalOffset: 2
                        verticalOffset: 2
                        radius: 5
                        samples: 11
                    }

                    TextInput {
                        id: password
                        anchors.fill: parent
                        anchors.margins: 10
                        verticalAlignment: TextInput.AlignVCenter
                        horizontalAlignment: TextInput.AlignHCenter
                        font.family: "sans-serif"
                        font.pointSize: root.font.pointSize
                        font.letterSpacing: 2
                        color: root.col1
                        echoMode: TextInput.Password
                        passwordCharacter: "*"
                        selectionColor: "#ff00aa"
                        selectedTextColor: "#ffffff"
                        KeyNavigation.tab: loginButton
                        Keys.onReturnPressed: doLogin()
                        Keys.onEnterPressed: doLogin()
                        layer.enabled: true
                        layer.effect: DropShadow { color: root.col1; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }
                    }
                }
            }

            // ── Error / CapsLock ──
            Label {
                id: errorMsg
                Layout.fillWidth: true
                height: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: root.font.family
                font.pointSize: root.font.pointSize * 0.8
                font.italic: true
                color: "#ff0000"
                opacity: 0
                layer.enabled: true
                layer.effect: DropShadow { color: "#ff0000"; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }

                states: [
                    State { name: "fail"; when: mainColumn.failed; PropertyChanges { target: errorMsg; opacity: 1; text: config.TranslateLoginFailedWarning || "ACCESS DENIED" } },
                    State { name: "capslock"; when: keyboard.capsLock; PropertyChanges { target: errorMsg; opacity: 1; text: config.TranslateCapslockWarning || "⚠ CAPS LOCK" } }
                ]
                transitions: [ Transition { PropertyAnimation { properties: "opacity"; duration: 100 } } ]
            }

            // ── Login Button ──
            Rectangle {
                id: loginButton
                Layout.fillWidth: true
                height: 45
                color: loginEnabled ? root.col2 : "#090a0f"
                border.color: root.col2
                border.width: 2
                
                property bool loginEnabled: username.text !== "" && password.text !== ""
                activeFocusOnTab: true
                Keys.onReturnPressed: doLogin()
                Keys.onEnterPressed: doLogin()
                KeyNavigation.tab: selectSession

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    color: root.shadow2
                    horizontalOffset: 2
                    verticalOffset: 2
                    radius: 5
                    samples: 11
                }

                Label {
                    anchors.centerIn: parent
                    text: config.TranslateLogin || "AUTHENTICATE"
                    font.family: root.font.family
                    font.pointSize: root.font.pointSize
                    font.weight: Font.Bold
                    color: loginButton.loginEnabled ? "#090a0f" : root.col2
                    layer.enabled: !loginButton.loginEnabled
                    layer.effect: DropShadow { color: root.col2; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }
                }

                MouseArea {
                    id: loginMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: doLogin()
                }

                states: [
                    State { name: "hovered"; when: loginMouseArea.containsMouse && loginButton.loginEnabled; PropertyChanges { target: loginButton; color: "#ffffff" } },
                    State { name: "pressed"; when: loginMouseArea.pressed && loginButton.loginEnabled; PropertyChanges { target: loginButton; color: "#aaaaaa" } }
                ]
            }

            // ── Session & Power ──
            RowLayout {
                Layout.fillWidth: true
                spacing: 15

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    Label {
                        text: "SESSION:"
                        font.family: root.font.family
                        font.pointSize: root.font.pointSize * 0.7
                        font.weight: Font.Bold
                        color: root.col0
                        layer.enabled: true
                        layer.effect: DropShadow { color: root.col0; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }
                    }

                    ComboBox {
                        id: selectSession
                        Layout.fillWidth: true
                        hoverEnabled: true
                        model: sessionModel
                        currentIndex: model.lastIndex
                        textRole: "name"

                        indicator { visible: false }

                        contentItem: Text {
                            text: selectSession.currentText
                            font.family: root.font.family
                            font.pointSize: root.font.pointSize * 0.8
                            color: root.col0
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            layer.enabled: true
                            layer.effect: DropShadow { color: root.col0; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }
                        }

                        background: Rectangle {
                            color: "#090a0f"
                            border.color: root.col0
                            border.width: 2
                            layer.enabled: true
                            layer.effect: DropShadow { color: root.shadow0; horizontalOffset: 2; verticalOffset: 2; radius: 5; samples: 11; transparentBorder: true }
                        }

                        delegate: ItemDelegate {
                            width: parent.width
                            height: root.font.pointSize * 2.8
                            contentItem: Text {
                                text: model.name
                                font.pointSize: root.font.pointSize * 0.8
                                font.family: root.font.family
                                font.weight: Font.Bold
                                color: selectSession.highlightedIndex === index ? "#ffffff" : root.col0
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                layer.enabled: true
                                layer.effect: DropShadow { color: selectSession.highlightedIndex === index ? "#ffffff" : root.col0; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }
                            }
                            highlighted: selectSession.highlightedIndex === index
                            background: Rectangle {
                                color: selectSession.highlightedIndex === index ? "#ff00aa" : "transparent"
                                border.color: selectSession.highlightedIndex === index ? root.col2 : "transparent"
                                border.width: selectSession.highlightedIndex === index ? 2 : 0
                            }
                        }

                        popup: Popup {
                            y: selectSession.height + 5
                            width: selectSession.width
                            padding: 10
                            contentItem: ListView {
                                clip: true
                                implicitHeight: contentHeight
                                spacing: 5
                                model: selectSession.popup.visible ? selectSession.delegateModel : null
                                currentIndex: selectSession.highlightedIndex
                            }
                            background: Rectangle {
                                color: "#090a0f"
                                border.color: root.col0
                                border.width: 2
                                layer.enabled: true
                                layer.effect: DropShadow { color: root.shadow0; horizontalOffset: 2; verticalOffset: 2; radius: 5; samples: 11; transparentBorder: true }
                            }
                        }
                    }
                }

                RowLayout {
                    spacing: 12
                    visible: config.ForceHideSystemButtons != "true"

                    Repeater {
                        model: ListModel {
                            ListElement { label: ""; action: "suspend" }
                            ListElement { label: ""; action: "reboot" }
                            ListElement { label: ""; action: "shutdown" }
                        }

                        delegate: Rectangle {
                            visible: (model.action === "suspend" && sddm.canSuspend) || (model.action === "reboot" && sddm.canReboot) || (model.action === "shutdown" && sddm.canPowerOff)
                            width: 35
                            height: 35
                            color: "#090a0f"
                            border.color: root.col2
                            border.width: 2
                            
                            layer.enabled: true
                            layer.effect: DropShadow { color: root.shadow2; horizontalOffset: 2; verticalOffset: 2; radius: 5; samples: 11; transparentBorder: true }

                            Label {
                                anchors.centerIn: parent
                                text: model.label
                                font.family: root.font.family
                                font.pointSize: root.font.pointSize * 1.2
                                color: pArea.containsMouse ? "#ffffff" : root.col2
                                layer.enabled: true
                                layer.effect: DropShadow { color: root.col2; radius: 4; samples: 9; horizontalOffset: 0; verticalOffset: 0; transparentBorder: true }
                            }

                            MouseArea {
                                id: pArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: {
                                    if (model.action === "suspend") sddm.suspend()
                                    if (model.action === "reboot") sddm.reboot()
                                    if (model.action === "shutdown") sddm.powerOff()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function doLogin() {
        if (username.text !== "" && password.text !== "") {
            mainColumn.failed = false
            sddm.login(config.AllowBadUsernames == "false" ? username.text.toLowerCase() : username.text, password.text, selectSession.currentIndex)
        }
    }

    Connections {
        target: sddm
        onLoginSucceeded: {}
        onLoginFailed: {
            mainColumn.failed = true
            password.text = ""
            resetError.running ? resetError.stop() && resetError.start() : resetError.start()
        }
    }

    Timer {
        id: resetError
        interval: 2500
        onTriggered: mainColumn.failed = false
        running: false
    }

    Component.onCompleted: {
        timeLabel.update()
        dateLabel.update()
        if (config.ForcePasswordFocus == "true" && username.text !== "") password.forceActiveFocus()
        else username.forceActiveFocus()
    }
}
