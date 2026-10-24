#pragma once

#include <QObject>

#include "nlohmann/json.hpp"

using json = nlohmann::json;

class Save : QObject {
    Q_OBJECT
  private:
  public:
    Save(json& sourceJson);
};

/*
First startup:
    NOTES:
        DefaultPreset.json
            Everytime when you start the program it will first go to the default json.
            You can edit what the program considers the default json, ex: "I want the
            default preset to be 'minecraftPreset.json'", from that point on the
            default json will be 'minecraftPreset.json'.

    FUNCTIONS:
        savePreset(); ->    Reads what source and destination are selected and puts
                            them inside a 'presetTemplate.json'. You can ofc name the
                            json whatever you want.
                                !!! All json's will be inside the same folder. !!!
                                            'presets_folder'


        selectPreset(); ->  Select a preset from the 'presets folder'.


*/