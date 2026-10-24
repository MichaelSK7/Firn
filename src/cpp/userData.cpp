#include <QDebug>

#include <fstream>

#include "nlohmann/json.hpp"

#include "userData.hpp"
#include "util/mklog.hpp"

using json = nlohmann::json;

userData::userData() {
}

void userData::loadUserSettings() {
    inputStream.open(USERDATA_DIR "/userSettings.json");
    if (!inputStream.is_open()) {
        mk.error("inputstream: Failed to open \"/userSettings.json\"");
        return;
    }
    userSettingsJson = json::parse(inputStream);
}

void userData::makePreset() {

};

void userData::createUserSettings() {
    json data = {
        {"defaultPresetPath", ""},

    };

    std::ofstream os(USERDATA_DIR "/userSettings.json");
    if (!os.is_open()) {
        mk.error("failed to open \"/userSettings.json\"");
        return;
    }

    os << data.dump(4);
    os.close();
    return;
}

void userData::createDefaultSettings() {
    json data = {{"units", json::array()}};

    for (int i = 0; i < 10; i++) {
        data["units"].push_back({{"source", ""}, {"destination", ""}});
    }

    std::ofstream os(USERDATA_DIR "/presets/userSettings.json");
    if (!os.is_open()) {
        mk.error("failed to open \"/presets/userSettings.json\"");
        return;
    }

    os << data.dump(4);
    os.close();
    return;
}