#pragma once

#include <QObject>
#include <QVariantList>

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
    Q_PROPERTY(QVariantList units READ units WRITE setUnits NOTIFY unitsChanged)
    Q_PROPERTY(bool isUnsaved READ isUnsaved WRITE setIsUnsaved NOTIFY isUnsavedChanged)

  private:
    QString m_currentPresetName = "";
    QVector<QPair<QString, QString>> m_units;
    QVector<QPair<QString, QString>> m_currentUnits;

    fs::path defaultPresetPath = "";
    fs::path defaultPresetsDirPath;
    fs::path currentPresetpath;
    std::ofstream outputStream;
    std::ifstream inputStream;

    bool m_isUnsaved = false;

    json userDataJson;

  public:
    explicit UserData(QObject* parent = nullptr);

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

    QVariantList units() const {
        QVariantList result;

        for (const auto& unit : m_units) {
            result.append(QVariantMap{{"source", unit.first}, {"destination", unit.second}});
        }

        return result;
    }
    void setUnits(const QVariantList& list) {
        for (qsizetype i = 0; i < list.size() && i < m_units.size(); ++i) {
            QVariantMap map = list[i].toMap();

            m_units[i].first = map["source"].toString();
            m_units[i].second = map["destination"].toString();
        }

        emit unitsChanged();
    }

    bool isUnsaved() {
        return m_isUnsaved;
    }

    void setIsUnsaved(bool param) {
        m_isUnsaved = param;
        emit isUnsavedChanged();
    }

    void createUserData();
    void loadUserSettings();

    void start();

    Q_INVOKABLE void newPreset();
    Q_INVOKABLE void makePreset(QString presetName);
    void makePlainPreset(std::string presetName);
    Q_INVOKABLE void loadPreset(std::string presetName, fs::path pathToPreset);
    Q_INVOKABLE void savePreset();
    Q_INVOKABLE void setUnitData(int unitID, QString path, bool isForSource);

  signals:
    void currentPresetNameChanged();
    void unitsChanged();
    void isUnsavedChanged();
};

/*
    Phase 1:
        user's data will be found and loaded into memory

    Phase 2:
        App specific data (units) will be loaded


    When you exit a named preset, you will go back to 'defaultPreset'
*/
