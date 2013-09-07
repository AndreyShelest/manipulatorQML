#include "manipulator.h"
#include <QApplication>
#include <QtQml>

int main(int argc, char *argv[])
{

    QApplication a(argc, argv);
    qmlRegisterType<Manipulator>("Andrey_progs", 1, 0, "Manipulator");
    Manipulator w;
    w.show();
    
    return a.exec();
}
