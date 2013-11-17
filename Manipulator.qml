import QtQuick 2.1
import QtQuick.Controls 1.0

ApplicationWindow {
    width: 300
    height: 300
    id: mainQml
    minimumWidth: 300
    minimumHeight: 300
    signal movedToX(int x)
    signal movedToY(int y)
    Rectangle {
        id: rectangle1
   anchors.fill: parent
        border.color: "Wheat"
        color: "#FF4E4E4E"

        //Перемещение кнопки при помощи клавиш
        focus: true
             Keys.onLeftPressed: greybutton.horizontalMove(-5)
             Keys.onRightPressed: greybutton.horizontalMove(5)
             Keys.onDownPressed: greybutton.verticalMove(5)
             Keys.onUpPressed: greybutton.verticalMove(-5)

             Image {
                 id: lineH
                 width: parent.width
                 height: parent.height
                 source: "lineH.svg"
                 opacity: 0.6
                 anchors.verticalCenter: greybutton.verticalCenter
             }
             Image {
                 id: lineV
                 width: parent.width
                 height: parent.height
                 source: "lineV.svg"
                 opacity: 0.6
                 anchors.horizontalCenter: greybutton.horizontalCenter
             }
     Text {

                 id: positionText
                 color: "Wheat"
                 text: qsTr("  posX: ")+greybutton.posX+"\n"
                       +qsTr("  posY: ")+greybutton.posY
                 clip: false
                 font.underline: false
                 font.bold: false
                 font.pixelSize: 12
                 anchors.bottomMargin: parent.BottomLeft

             }
        MouseArea {
                 id: paletteMouse
                 anchors.fill: parent
                 onDoubleClicked: greybutton.moveToXY(mouseX,mouseY)
                 onWheel: {
                     if (Qt.ControlModifier) {
                         if (wheel.angleDelta.y > 0)
                             greybutton.verticalMove(-1);
                         else greybutton.verticalMove(1);
                     }
                 }
             }
        MButton {
            id: greybutton
            objectName: "button"
            radius: width*0.4
            width: 25
            height: width
            x:parent.width/2-btn_center
            y:parent.height/2-btn_center

            max_X: parent.width-btn_center
            min_X: 0-btn_center
            max_Y: parent.width-btn_center
            min_Y: 0-btn_center
            dragMouse.axis: Drag.XAndYAxis
            dragMouse.maximumX: max_X
            dragMouse.minimumX: min_X
            dragMouse.maximumY: max_Y
            dragMouse.minimumY: min_Y
            //привязка к C++
        onXChanged: mainQml.movedToX(greybutton.posX)
        onYChanged: mainQml.movedToY(greybutton.posY)

            text: ""
            clip: false
            clGradientStop1: "#226024"
            clGradientStop0: "#85dd86"
        }


    }

//Image {
//    id:back
//    width: 300
//    height: 300
//    source: "background.svg"
//    anchors.fill: parent
//    smooth: true

//    // Действие мыши на основном виджете
//    MouseArea {
//        anchors.fill: parent
//        id: mouseFilledArea
//        //При нажатии вызвать переместить
//        onClicked: {
//            button.x=mouseX-button.r
//            button.y=mouseY-button.r
//        }
//        //        drag.target: parent
//        //        drag.axis: Drag.XandYAxis
//        //        onPressed:  click.visible = true
//        //        onReleased: click.visible=false
//           }
//    MouseArea{
//        //anchors.fill: parent
//        width: button.width
//        height: button.height
//        anchors.verticalCenter: parent.verticalCenter;
//        anchors.horizontalCenter: parent.horizontalCenter;
//        id: mouseCenter
//        onDoubleClicked: {button.x=back.width/2-button.r
//                            button.y=back.height/2-button.r}
//    }
//    Image {
//        id: vLine
//        source: "lineV.svg"
//        width: back.width;
//        height: back.height;
//        //Привязываем размещение к кнопке
//        anchors.horizontalCenter: button.horizontalCenter;
//        anchors.verticalCenter: parent.verticalCenter;
//    }
//    Image {
//        id: hLine
//        source: "lineH.svg"
//        width: back.width;
//        height: back.height;
//        // fillMode: Image.TileVertically
//        //Привязываем размещение к кнопке по горизонтали
//        anchors.horizontalCenter: parent.horizontalCenter;
//        anchors.verticalCenter: button.verticalCenter;
//    }


//    //Кнопка
//    Image {
//        id: button //Имя кнопки
//        objectName: "button"
//        source: "button.svg"
//        smooth: true ;
//        //ограничим перемещение краями палитры
//        property int r: Math.round(button.width/2);
//        property int centerX: Math.round(back.width/2);
//        property int centerY: Math.round(back.height/2);
//        property bool anhorX: false;
//        property bool anhorY: false;
//        x:back.width/2-r;
//        y:back.height/2-r;
//        onXChanged: {moveButton();
//            window.slot_pushXcoord(centerX);
//        }
//        onYChanged: {moveButton();
//            window.slot_pushYcoord(centerY);
//        }

//             //Размеры кнопки
//        width: back.width / 10
//        height: width
//        //        height: back.height / 10

//        //Действие мыши
//        MouseArea {
//            anchors.fill: parent
//            id: mouseArea
//            //При изменении положения вызвать слоты
//            drag.target: parent
//            drag.axis: Drag.XandYAxis
//            drag.maximumX: back.width-button.r
//            drag.minimumX: 0-button.r
//            drag.maximumY: back.height-button.r
//            drag.minimumY: 0-button.r
//            onPressed:  click.visible = true
//            onReleased: click.visible=false
//            onDoubleClicked: textinputRect.visible=!textinputRect.visible
//        }
//        Image { //кнопка нажата
//            id: click
//            smooth: true
//            source: "button_pressed.svg"
//            visible: false //hidden by default
//            width: parent.width;
//            height: parent.height;
//            anchors.centerIn: parent
//        }
//        //Строка ввода
//        Rectangle {
//            id: textinputRect //Имя строки ввода
//            visible: false
//            //            //Размещаем ниже
//            //            x: button.x - 10;
//            //            y: button.y-10;

//            //Размеры строки ввода
//            width: 50
//            height: 18

//            //цвет строки ввода
//            color: "gray"

//            TextInput {
//                id: textinput
//                objectName: "textinput"
//                color: "#151515";
//                font.family: "DejaVu Sans Mono"
//                selectionColor: "blue"
//                font.pixelSize: 12
//                width: parent.width-4
//                anchors.centerIn: parent
//                focus: true
//                Keys.onReturnPressed: {
//                    var input =textinput.text
//                    var words = input.split(",")
//                    console.log(event.key)
//                    button.x=words[0]-button.r
//                    button.y=words[1]-button.r
//                }
//                Keys.onEscapePressed: parent.visible=false;

//            }
//        }

//    }
//            //привязки к направляющим
//    Image {
//        id: hCatch
//        source: "pointer.svg"
//        width: back.width/25
//        height: width
//        rotation: 270
//        smooth: true
//        anchors.verticalCenter: back.verticalCenter
//        MouseArea{
//            anchors.fill: parent
//            id: mouseCatchH
//            drag.target: hCatch
//            drag.axis: Drag.YAxis
//            onDoubleClicked: {
//                //привязка к оси X
//                parent.anchors.verticalCenter=undefined
//                if(button.anhorX){
//                    button.anchors.verticalCenter=undefined;
//                    button.anhorX=false;
//                }
//                else {
//                    button.anchors.verticalCenter=hCatch.verticalCenter;
//                    button.anhorX=true;
//                }
//            }
//        }

//    }
//    //Привязки
//    Image {
//        id: vCatch
//        smooth: true
//        source: "pointer.svg"
//        width: back.width/25
//        height: width
//        anchors.horizontalCenter: back.horizontalCenter
//        MouseArea{
//            anchors.fill: parent
//            id: mouseCatchV
//            drag.target: vCatch
//            drag.axis: Drag.XAxis
//            onDoubleClicked: {
//                //привязка к оси Y
//                parent.anchors.horizontalCenter=undefined
//                if(button.anhorY){
//                    button.anchors.horizontalCenter=undefined;
//                    button.anhorY=false;
//                }
//                else {
//                    button.anchors.horizontalCenter=vCatch.horizontalCenter;
//                    button.anhorY=true;
//                }
//            }
//        }

//    }

//    TextEdit{
//        id: coordXY
//        x:back.width/60
//        y:back.height/60
//        objectName: "coordX"
//        wrapMode: TextEdit.Wrap
//        width:parent.width;
//        color: "#ee2222"
//        readOnly:true

//    }
//}
//    function moveButton()
//    {
//        button.centerX=Math.round(button.x+button.r);
//        button.centerY=Math.round(button.y+button.r);
//        coordXY.text="X: "+(button.centerX) + " | "+"Y: "+(button.centerY)
//        console.debug("X: "+(button.centerX) + " | "+"Y: "+(button.centerY))

//    }

}
