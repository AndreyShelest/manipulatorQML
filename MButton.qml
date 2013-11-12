import QtQuick 2.0

Rectangle {
    property alias text: textElement.text // свойство ссылка, для обращения на верхнем уровне
    property alias dragMouse: mouse.drag

    property string rsGradientStop0: "#FF7C7C7C" // свойство для хранения цвета
    property string rsGradientStop1: "#FF4E4E4E"

    property string clGradientStop0: "#287c994e" // click color
    property string clGradientStop1: "#3dd8ec4e"

    property int posX: x+btn_center
    property int posY: y+btn_center

    property int btn_center: width/2
    property int max_X: 65535
    property int max_Y: 65535
    property int min_X: -65535
    property int min_Y: -65535

    id: greyButton

    width: 85
    height: 23

    border.color: "Wheat"
    gradient: Gradient { // добавление градиента

        GradientStop {
            id: gradientStop0
            position: 0
            color: rsGradientStop0
        }

        GradientStop {
            id: gradientStop1
            position: 1
            color: rsGradientStop1
        }

    }

    Text {

        id: textElement
        color: "Wheat"
        text: qsTr("Ok")
        clip: false
        font.underline: false
        font.bold: false
        font.pixelSize: 12
        anchors.centerIn: parent

    }

    ParallelAnimation {

        id: mouseEnterAnim
        PropertyAnimation {
            target: gradientStop0
            properties: "color"
            to: rsGradientStop1
            duration: 300
        }

        PropertyAnimation {
            target: gradientStop1
            properties: "color"
            to: rsGradientStop0
            duration: 300
        }

    }

    ParallelAnimation {

        id: mouseExitAnim
        PropertyAnimation {
            target: gradientStop0
            properties: "color"
            to: rsGradientStop0
            duration: 300
        }

        PropertyAnimation {
            target: gradientStop1
            properties: "color"
            to: rsGradientStop1
            duration: 300
        }

    }


    ParallelAnimation {

        id: mouseClickAnim
        PropertyAnimation {
            target: gradientStop0
            properties: "color"
            to: clGradientStop1
            duration: 300
        }

        PropertyAnimation {
            target: gradientStop1
            properties: "color"
            to: clGradientStop0
            duration: 300
        }

    }


    MouseArea {
        id: mouse
        drag.target: parent
        drag.axis: Drag.XandYAxis
        anchors.fill: greyButton
        hoverEnabled: true
        onEntered: mouseEnterAnim.start()
        onExited: mouseExitAnim.start()
        onPressed: mouseClickAnim.start()
        onReleased: mouseEnterAnim.start()
        onDoubleClicked: {
            resetTextRect(true)
            textinputRect.visible=!textinputRect.visible
        }

    }

    // Set an 'elastic' behavior on the focusRect's x property.
    Behavior on x {
        NumberAnimation { easing.type: Easing.OutElastic; easing.amplitude: 2.25; easing.period: 2; duration: 500 }
    }

    // Set an 'elastic' behavior on the focusRect's y property.
    Behavior on y {
        NumberAnimation { easing.type: Easing.OutElastic; easing.amplitude: 2.25; easing.period: 2.0; duration: 500 }
    }
    //Строка ввода
    Rectangle {
        id: textinputRect //Имя строки ввода
        visible: false
        //Размещаем ниже
//        x: greyButton.x - 10;
//        y: greyButton.y-10;

        //Размеры строки ввода
        width: 50
        height: 18

        //цвет строки ввода
        color: "gray"
        border.color: "Wheat"

        TextInput {
            id: textinput
            objectName: "textinput"
            color: "#151515";
            font.family: "Baskerville"
            selectionColor: "blue"
            font.pixelSize: 12
            width: parent.width-4
            anchors.centerIn: parent
//            focus: true
            validator: RegExpValidator { regExp: /\d+,\d+/ }
//            cursorVisible: true
            onActiveFocusChanged: resetTextRect(false)
            Keys.onReturnPressed: {
                var input =textinput.text
                var words = input.split(",")
                console.log(event.key)
                greyButton.x=words[0]-greyButton.btn_center
                greyButton.y=words[1]-greyButton.btn_center
                resetTextRect(true)
                textinputRect.visible=false
            }
            Keys.onEscapePressed: parent.visible=false;

        }
    }
    function horizontalMove (count){
        if (count<0)
            x = Math.max(min_X, x+count)
        else
            x = Math.min(max_X, x+count)
        resetTextRect(true)
        textinputRect.visible=false
    }
    function verticalMove (count){
        if (count<0)
            y = Math.max(min_Y, y+count)
        else
            y = Math.min(max_X, y+count)
resetTextRect(true)
        textinputRect.visible=false
    }
    function moveToXY (posX,posY){
        x = posX-btn_center
        y = posY-btn_center
        resetTextRect(true)
        textinputRect.visible=false
    }
    function resetTextRect(reset){
        if (!reset){
            textinput.color="#151515"
            textinput.text=""
        }
else{
        textinput.color="lightgrey"
        textinput.text="X,Y"
        textinput.focus=false
}
    }
}
