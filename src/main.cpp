#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <filesystem>
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
    /* ==========================================
        Phase 1:
            user's data will be found and loaded into memory
        Phase 2:
            App specific data (units) will be loaded
    */

    // Phase 1 start:
    // -----------------
    // If userData.json exist, don't make a plain one.
    if (!std::filesystem::exists(USERDATA_DIR "/userData.json")) {
        userData.createUserData();
        userData.makePlainPreset("defaultPreset");
        mklog::getInstance().info("userData did not exist. Making userData.json");
    };

    userData.loadUserSettings();

    // Phase 2 start:
    // -----------------
    userData.start();
    // ==========================================

    return app.exec();
}