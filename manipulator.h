#ifndef MANIPULATOR_H
#define MANIPULATOR_H

#include <QDialog>
#include <QDeclarativeContext>
#include<QDeclarativeView>
#include<QVBoxLayout>

namespace Ui {
class Manipulator;
class CustomPalette ;
}

class CustomPalette : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(QColor background READ background WRITE setBackground NOTIFY backgroundChanged)
//    Q_PROPERTY(QColor foreground READ foreground WRITE setForeground NOTIFY foregroundChanged)
public:
    CustomPalette();
//    QColor background() const;
//    void setBackground(const QColor &c);
//    QColor foreground() const;
//    void setForeground(const QColor &c);

signals:
    void manipulatorXCanged();
    void manipulatorYCanged(int y);
//private:
//    QColor m_background;
//    QColor m_foreground;
};

class Manipulator : public QDialog
{
    Q_OBJECT

public:
    explicit Manipulator(QWidget *parent = 0);
    ~Manipulator();
    CustomPalette * palette;
public slots:
void slot_setXcoord(int centerX);
void slot_setYcoord(int centerY);
void slot_pushXcoord(int centerX); //push coords to QML file
void slot_pushYcoord(int centerY);
private:
    Ui::Manipulator *ui;
QDeclarativeView *qmlView;
    QObject *Root;//корневой элемент QML модели
};

#endif // MANIPULATOR_H
