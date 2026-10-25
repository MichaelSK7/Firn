#include <QDebug>

#include <fstream>
#include <string>
#include <utility>

#include "nlohmann/json.hpp"

#include "userData.hpp"
#include "util/mklog.hpp"

using json = nlohmann::json;

void UserData::createUserSettings() {
    json data = {
        {"defaultPresetPath", "userdata/defaultPreset.json"},
        {"presets", json::array()},
    };

    for (int i = 0; i < 10; i++) {
        data["presets"].push_back({{"presetName", ""}, {"pathToPreset", ""}});
    }

    outputStream.open(USERDATA_DIR "/userSettings.json");
    if (!outputStream.is_open()) {
        mklog::getInstance().error("failed to open \"/userSettings.json\"");
        return;
    }

    outputStream << data.dump(4);
    outputStream.close();
    return;
}

void UserData::loadUserSettings() {
    // Will always be at the same path
    inputStream.open(USERDATA_DIR "/userSettings.json");
    if (!inputStream.is_open()) {
        mklog::getInstance().error("inputstream: Failed to open \"/userSettings.json\"");
        return;
    }
    userDataJson = json::parse(inputStream);
    std::string temp = userDataJson["defaultPresetPath"];
    defaultPresetPath = temp;
    inputStream.close();
}

void UserData::makePreset(QString presetName) {
    json data = {{"units", json::array()}};

    std::vector<std::pair<std::string, std::string>> converted;
    for (const auto& unit : m_currentUnits) {
        converted.emplace_back(unit.first.toStdString(), unit.second.toStdString());
    }
    for (int i = 0; i < 10; i++) {
        data["units"].push_back({{"source", converted[i].first}, {"destination", converted[i].second}});
    }

    std::string Cpp_presetName = presetName.toStdString();
    outputStream.open(USERDATA_DIR "/presets/" + Cpp_presetName + ".json");
    if (!outputStream.is_open()) {
        mklog::getInstance().error("failed to open \"/presets/" + Cpp_presetName + ".json\"");
        return;
    }
    outputStream << data.dump(4);
    outputStream.close();
    return;
}

void UserData::loadPreset(std::string presetName, fs::path pathToPreset) {
    inputStream.open(pathToPreset);
    if (!inputStream.is_open()) {
        mklog::getInstance().error("inputstream: Failed to open ");
        return;
    }
    json preset;
    preset = json::parse(inputStream);
    inputStream.close();

    m_currentPresetName = QString::fromStdString(presetName);

    // Load all the units from the json to std::vector<std::pair<std::string, std::string>>
    std::vector<std::pair<std::string, std::string>> CPairVector;
    for (int i = 0; i < 10; i++) {
        CPairVector[i].first = preset["units"][i]["source"];
        CPairVector[i].second = preset["units"][i]["destination"];
    }

    // Load the c++ vector to the class QVector
    for (int i = 0; i < 10; i++) {
        QString source = QString::fromStdString(CPairVector.at(i).first);
        QString destination = QString::fromStdString(CPairVector.at(i).second);
        m_units[i].first = source;
        m_units[i].second = destination;
    }
}
