import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami 2.20 as Kirigami
import Qt.labs.platform 1.1
import org.kde.plasma.plasma5support 2.0 as P5Support

PlasmoidItem {
    id: root
    
    property string displayText: "starting"
    
    P5Support.DataSource {
        id: fileReader
        engine: "executable"
        
        onNewData: function(sourceName, data) {
            if (data.stdout) {
                var content = data.stdout.trim()
                
                if (content === "NOFILE") {
                    displayText = "no file" 
                    return
                }
                
                if (content === "") {
                    displayText = "empty file"
                    return
                }
                
                var words = content.split(/\s+/)
                if (words.length < 2) {
                    displayText = "need 2+ words"
                    return
                }
                
                if (words[1] === "STOP") {
                    displayText = "No Job"
                    return
                }
                
                displayText = words[1]
            } else {
                displayText = "read error"
            }
        }
    }
    
    function updateText() {
        var command = "test -f $HOME/jobtimer.log && tail -n 1 $HOME/jobtimer.log || echo 'NOFILE' # " + Date.now()
        fileReader.connectSource(command)
    }
    
    preferredRepresentation: fullRepresentation
    
    Component.onCompleted: {
        updateText()
        updateTimer.start()
    }
    
    Timer {
        id: updateTimer
        interval: 1000
        repeat: true
        onTriggered: updateText()
    }
    
    fullRepresentation: Item {
        Layout.minimumWidth: testText.implicitWidth + 20
        Layout.minimumHeight: testText.implicitHeight + 10
        Layout.preferredWidth: testText.implicitWidth + 20
        Layout.preferredHeight: testText.implicitHeight + 10
        
        Text {
            id: testText
            anchors.centerIn: parent
            text: root.displayText
            font.pixelSize: 14
            color: Kirigami.Theme.textColor
        }
    }
}