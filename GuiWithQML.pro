#-------------------------------------------------
#
# Project created by QtCreator 2013-07-13T20:45:21
#
#-------------------------------------------------

QT       += core gui quick qml
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = GuiWithQML
TEMPLATE = app
qtHaveModule(widgets) {
    QT += widgets
}

SOURCES += main.cpp \
    manipulator.cpp

HEADERS  += \
    manipulator.h

FORMS    += \
    manipulator.ui

OTHER_FILES += \
    Manipulator.qml \
    MButton.qml

RESOURCES += \
    res.qrc
