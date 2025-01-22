import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 300
    height: 400
    title: "Calculator"

    property string displayText: "0" // Display text for the calculator

    // Function to append numbers or operators
    function appendNumber(num) {
        if (displayText === "0" || displayText === "Error") {
            displayText = num;
        } else {
            displayText += num;
        }
    }

    // Function to evaluate the expression
    function calculate() {
        try {
            displayText = eval(displayText).toString();
        } catch (e) {
            displayText = "Error"; // Handle invalid expressions
        }
    }

    // Function to clear the display
    function clearDisplay() {
        displayText = "0";
    }

    Rectangle {
        anchors.fill: parent
        color: "#f5f5f5" // Light gray background
        radius: 10

        Column {
            anchors.fill: parent
            spacing: 10
            padding: 10

            // Display Field
            Rectangle {
                width: parent.width
                height: 60
                radius: 10
                color: "#ffffff"
                border.color: "#e0e0e0"
                border.width: 2

                // Manual Shadow Effect
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 5
                    radius: 10
                    color: "#00000033" // Semi-transparent black for shadow
                    z: -1
                }

                Text {
                    text: displayText
                    anchors.centerIn: parent
                    font.pixelSize: 24
                    horizontalAlignment: Text.AlignRight
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.rightMargin: 10
                    color: "#333333" // Dark gray text
                }
            }

            // Buttons Grid
            GridLayout {
                id: buttonGrid
                columns: 4
                columnSpacing: 10
                rowSpacing: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    model: [
                        "7", "8", "9", "/",
                        "4", "5", "6", "*",
                        "1", "2", "3", "-",
                        "C", "0", "=", "+"
                    ]

                    Rectangle {
                        width: 60
                        height: 60
                        radius: 10
                        gradient: Gradient {
                            GradientStop { position: 0; color: modelData === "=" ? "#4caf50" : (modelData === "C" ? "#f44336" : "#e0e0e0") }
                            GradientStop { position: 1; color: modelData === "=" ? "#388e3c" : (modelData === "C" ? "#d32f2f" : "#d6d6d6") }
                        }
                        border.color: "#b0b0b0"

                        // Manual Shadow Effect
                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 5
                            radius: 10
                            color: "#00000033" // Semi-transparent black for shadow
                            z: -1
                        }

                        Text {
                            text: modelData
                            anchors.centerIn: parent
                            font.pixelSize: 20
                            color: modelData === "=" || modelData === "C" ? "white" : "black"
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                if (modelData === "C") {
                                    clearDisplay();
                                } else if (modelData === "=") {
                                    calculate();
                                } else {
                                    appendNumber(modelData);
                                }
                            }

                            onPressed: parent.opacity = 0.7
                            onReleased: parent.opacity = 1.0
                        }
                    }
                }
            }
        }
    }
}
