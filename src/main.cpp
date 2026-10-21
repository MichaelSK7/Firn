#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "src/cpp/test.hpp"
#include "src/cpp/userData.hpp"

int main(int argc, char* argv[]) {

    QGuiApplication app(argc, argv);

    foo testClass;
    bob::fo();

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("classA", &testClass);

    engine.loadFromModule("Firn", "Main");

    return app.exec();
}