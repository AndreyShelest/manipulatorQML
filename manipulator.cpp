#include "manipulator.h"
#include "ui_manipulator.h"
#include <QDebug>
Manipulator::Manipulator(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Manipulator)
{
    ui->setupUi(this);
palette=new CustomPalette;
engine=new QQmlEngine;

//search for root element
engine->rootContext()->setContextProperty("window",this);
qmlView=new QQmlComponent(engine);
qmlView->loadUrl(QUrl("qrc:/Manipulator.qml"));
Root=engine->rootContext();
    window = qobject_cast<QQuickWindow *>(qmlView->create());
    if (!window) qDebug()<< "Window is null"<<endl;



//qmlView->setFixedSize(300,300);
//create Layout
layout = new QVBoxLayout(this);
layout->addWidget(QWidget::createWindowContainer(window));
ui->qmlWgt->setLayout(layout);
//this->setLayout(layout);
//connect(ui->posX,SIGNAL(valueChanged(int)),this,SLOT(slot_setXcoord(int)));
//connect(ui->posY,SIGNAL(valueChanged(int)),this,SLOT(slot_setYcoord(int)));
connect(window,SIGNAL(movedToX(int)),this,SLOT(slot_pushXcoord(int)));
connect(window,SIGNAL(movedToY(int)),this,SLOT(slot_pushYcoord(int)));

}

Manipulator::~Manipulator()
{
    delete ui;
    delete palette;
    delete qmlView;
    delete Root;
}


CustomPalette::CustomPalette()
{
}

void Manipulator::slot_setXcoord(int centerX)
{
        //Найдем button
            QObject* button = NULL;
            button = window->findChild<QObject*>("button");
            if(button){
                QVariant returnedValue;
                QVariant posX = centerX;
                QMetaObject::invokeMethod(button, "moveToX",
                        Q_RETURN_ARG(QVariant, returnedValue),
                        Q_ARG(QVariant, posX));
}
            else qDebug()<<"button in QML no found";
}
void Manipulator::slot_setYcoord(int centerY)
{
        //Найдем button
            QObject* button = NULL;
            button=window->findChild<QObject*>("button");
            if (button){
                QVariant returnedValue;
                QVariant posY = centerY;
                QMetaObject::invokeMethod(button, "moveToY",
                        Q_RETURN_ARG(QVariant, returnedValue),
                        Q_ARG(QVariant, posY));
}
            else qDebug()<<"button in QML no found";
}

void Manipulator::slot_pushXcoord(int centerX)
{
    ui->posX->setValue(centerX);
}

void Manipulator::slot_pushYcoord(int centerY)
{
    ui->posY->setValue(centerY);
}

