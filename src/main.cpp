#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <iostream>

#include "src/cpp/folderPathHelper.hpp"
#include "src/cpp/userData.hpp"
#include "src/cpp/util/mklog.hpp"

int main(int argc, char* argv[]) {
    QGuiApplication app(argc, argv);

    FolderPathHelper folderPathHelper;
    UserData userData;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("userData", &userData);
    engine.rootContext()->setContextProperty("folderPathHelper", &folderPathHelper);
    engine.loadFromModule("Firn", "Main");

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}