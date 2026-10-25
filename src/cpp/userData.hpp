#pragma once

#include <QObject>

#include <filesystem>
#include <fstream>
#include <string>

#include "nlohmann/json.hpp"

using json = nlohmann::json;
namespace fs = std::filesystem;

class UserData : public QObject {
    Q_OBJECT
    Q_PROPERTY(
        QString currentPresetName READ currentPresetName WRITE setCurrentPresetName NOTIFY currentPresetNameChanged)
  private:
    json userDataJson;

    QString m_currentPresetName = "";

    fs::path defaultPresetPath;
    fs::path defaultPresetsDir = "userdata/presets/";
    std::ofstream outputStream;
    std::ifstream inputStream;

    QVector<QPair<QString, QString>> m_units;
    QVector<QPair<QString, QString>> m_currentUnits;

  public:
    explicit UserData(QObject* parent = nullptr)
        : QObject(parent) {
    }

    QString currentPresetName() const {
        return m_currentPresetName;
    }

    void setCurrentPresetName(const QString& name) {
        if (m_currentPresetName == name) {
            return;
        }
        m_currentPresetName = name;
        emit currentPresetNameChanged();
    }

    void createUserSettings();
    void loadUserSettings();

    Q_INVOKABLE void makePreset(QString presetName);
    void loadPreset(std::string presetName, fs::path pathToPreset);

  signals:
    void currentPresetNameChanged();
};

/*
  First get all the presets to load as a list to the screen!

*/
