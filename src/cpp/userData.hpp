#pragma once

#include <QObject>

#include <filesystem>
#include <fstream>

#include "nlohmann/json.hpp"

using json = nlohmann::json;
namespace fs = std::filesystem;

class userData : public QObject {
    Q_OBJECT
  private:
    json userSettingsJson;

    fs::path defaultPresetPath;
    std::ofstream outputStream;
    std::ifstream inputStream;

  public:
    userData();

    void loadUserSettings();
    void loadDefaultPreset();

    void makePreset();

    void createUserSettings();
    void createDefaultSettings();
};
