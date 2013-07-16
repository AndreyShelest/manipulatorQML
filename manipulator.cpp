#include "manipulator.h"
#include "ui_manipulator.h"
#include <QDebug>
Manipulator::Manipulator(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Manipulator)
{
    ui->setupUi(this);
qmlView = new QDeclarativeView;
palette=new CustomPalette;
qmlView->setRenderHints(QPainter::Antialiasing | QPainter::SmoothPixmapTransform);
qmlView->setResizeMode( QDeclarativeView::SizeRootObjectToView );
qmlView->setSource(QUrl("qrc:/Manipulator.qml"));
qmlView->setResizeMode(QDeclarativeView::SizeRootObjectToView);

//search for root element
Root=(QObject*)qmlView->rootObject();
qmlView->rootContext()->setContextProperty("window",this);
//qmlView->setFixedSize(300,300);
//create Layout
QVBoxLayout *layout = new QVBoxLayout(this);
layout->addWidget(qmlView);
ui->qmlWgt->setLayout(layout);
//this->setLayout(layout);
connect(ui->posX,SIGNAL(valueChanged(int)),this,SLOT(slot_setXcoord(int)));
connect(ui->posY,SIGNAL(valueChanged(int)),this,SLOT(slot_setYcoord(int)));
}

Manipulator::~Manipulator()
{
    delete ui;
    delete palette;
    delete qmlView;
}

//void Manipulator::FunctionC()
//{
//    //Найдем строку ввода
//        QObject* textinput = Root->findChild<QObject*>("textinput");

//        //Найдем поле вывода
//        QObject* memo = Root->findChild<QObject*>("coordXY");

//        QString str;//Создадим новую строковую переменную

//        //Считаем информацию со строки ввода через свойство text
//        str=(textinput->property("text")).toString();

//        int a;
//        a=str.toInt();//Переведем строку в число
//        a++;//Добавим к числу 1

//        QString str2;//Создадим еще одну строковую переменную
//        str2=QString::number(a);//Переведем число в строку

//        //Ну и наконец выведем в поле вывода нашу информацию
//        memo->setProperty("text", str+"+1="+str2);

//}


CustomPalette::CustomPalette()
{
}

void Manipulator::slot_setXcoord(int centerX)
{
        //Найдем button
            QObject* button = Root->findChild<QObject*>("button");
            int posx=centerX-button->property("r").toInt();
            button->setProperty("x",QString::number(posx));

}
void Manipulator::slot_setYcoord(int centerY)
{
        //Найдем button
            QObject* button = Root->findChild<QObject*>("button");
           int posy=centerY-button->property("r").toInt();
           button->setProperty("y",QString::number(posy));

}

void Manipulator::slot_pushXcoord(int centerX)
{
    ui->posX->setValue(centerX);
}

void Manipulator::slot_pushYcoord(int centerY)
{
    ui->posY->setValue(centerY);
}

