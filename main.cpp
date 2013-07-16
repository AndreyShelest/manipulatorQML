#include "manipulator.h"
#include <QApplication>

int main(int argc, char *argv[])
{

    QApplication a(argc, argv);
    Manipulator w;
    w.show();
    
    return a.exec();
}
