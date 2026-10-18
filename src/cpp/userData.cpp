#include "userData.hpp"
#include <QDebug>

foo::foo(QObject* parent)
    : QObject(parent) {
}

void foo::callMe() {
    qDebug() << "I am being called!";
}