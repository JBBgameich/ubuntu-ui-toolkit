TEMPLATE = lib
TARGET = ../UbuntuComponents
QT += declarative core gui
CONFIG += qt plugin #no_keywords

TARGET = $$qtLibraryTarget($$TARGET)
uri = Ubuntu.Components

HEADERS += plugin.h \
        i18n.h

SOURCES += plugin.cpp \
        i18n.cpp

# deployment rules for the plugin
installPath = $$[QT_INSTALL_IMPORTS]/$$replace(uri, \\., /)
target.path = $$installPath
INSTALLS += target

