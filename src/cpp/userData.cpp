#include <QDebug>

#include <fstream>
#include <iostream>
#include <string>
#include <utility>

#include "nlohmann/json.hpp"

#include "userData.hpp"
#include "util/mklog.hpp"

using json = nlohmann::json;

UserData::UserData(QObject* parent)
    : QObject(parent) {
    defaultPresetsDirPath = PRESETS_DIR;
    m_units.resize(10);
};

void UserData::createUserData() {
    // USE THIS FUNCTION ONLY FOR FIRST STARTUP
    json data = {
        {"defaultPreset", "defaultPreset.json"},
        {"presets", json::array()},
    };

    for (int i = 0; i < 10; i++) {
        data["presets"].push_back({{"presetName", ""}, {"pathToPreset", ""}});
    }

    // Open userSettings (created if not existant) and data dumped
    outputStream.open(USERDATA_DIR "/userData.json");

    if (!outputStream.is_open()) {
        mklog::getInstance().error("failed to open \"/userData.json\"");
        return;
    }
    outputStream << data.dump(4);
    outputStream.close();
    return;
}

void UserData::loadUserSettings() {
    // userSettings.json will always be the same path: "userdata/userSettings.json".
    inputStream.open(USERDATA_DIR "/userData.json");
    if (!inputStream.is_open()) {
        mklog::getInstance().error("inputstream: Failed to open /userData.json");
        return;
    }
    // Load all of the user's data into json object.
    userDataJson = json::parse(inputStream);
    // using a temp string to convert json string to cpp string

    defaultPresetPath = userDataJson["defaultPreset"].get<std::string>();
    inputStream.close();
}

void UserData::start() {
    loadPreset("DefaultPreset", defaultPresetPath);
}

void UserData::newPreset() {

};

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
    outputStream.open(PRESETS_DIR + Cpp_presetName + ".json");
    if (!outputStream.is_open()) {
        mklog::getInstance().error("failed to open \"/presets/" + Cpp_presetName + ".json\"");
        return;
    }
    outputStream << data.dump(4);
    outputStream.close();
    return;
}

void UserData::makePlainPreset(std::string presetName) {
    json data = {{"units", json::array()}};

    for (int i = 0; i < 10; i++) {
        data["units"].push_back({{"source", ""}, {"destination", ""}});
    }

    outputStream.open(PRESETS_DIR + presetName + ".json");

    if (!outputStream.is_open()) {
        mklog::getInstance().error("failed to open \"/presets/" + presetName + ".json\"");
        return;
    }

    outputStream << data.dump(4);

    outputStream.close();
    return;
};

void UserData::loadPreset(std::string presetName, fs::path pathToPreset) {
    json preset;
    inputStream.open(PRESETS_DIR "/defaultPreset.json");
    if (!inputStream.is_open()) {
        mklog::getInstance().error("inputstream: Failed to open " + pathToPreset.string());
        return;
    }
    preset = json::parse(inputStream);
    inputStream.close();

    setCurrentPresetName(QString::fromStdString(presetName));
    currentPresetpath = PRESETS_DIR "/defaultPreset.json";

    // Load all the units from the json to pair-vector
    std::vector<std::pair<std::string, std::string>> CPairVector;
    CPairVector.resize(preset["units"].size());
    for (int i = 0; i < 10; i++) {
        CPairVector[i].first = preset["units"][i]["source"].get<std::string>();
        CPairVector[i].second = preset["units"][i]["destination"].get<std::string>();
    }

    for (const auto& i : CPairVector) {
        qDebug() << i.first;
        qDebug() << i.second;
    }

    // Load the c++ vector to the class QVector
    for (int i = 0; i < 10; i++) {
        QString source = QString::fromStdString(CPairVector[i].first);
        QString destination = QString::fromStdString(CPairVector[i].second);
        m_units[i].first = source;
        m_units[i].second = destination;
    }
    emit unitsChanged();
}

void UserData::savePreset() {
    json data = {{"units", json::array()}};

    // Add all the data to the json object
    for (int i = 0; i < 10; i++) {
        data["units"][i]["source"] = m_units[i].first.toStdString();
        data["units"][i]["destination"] = m_units[i].second.toStdString();
    }

    // Open the current preset and load data to the json file
    outputStream.open(currentPresetpath);
    if (!outputStream.is_open()) {
        mklog::getInstance().error("failed to open \"/presets/" + currentPresetpath.string() + ".json\"");
        return;
    }
    outputStream << data.dump(4);
    outputStream.close();
    return;
}

void UserData::setUnitData(int unitID, QString path, bool isforSource) {
    m_isUnsaved = true;
    if (isforSource) {
        m_units[unitID].first = path;
    } else {
        m_units[unitID].second = path;
    }
    emit unitsChanged();
};
