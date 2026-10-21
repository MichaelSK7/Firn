#include <fstream>
#include <vendor/nlohmann/json.hpp>

namespace bob {
void fo() {
    using json = nlohmann::json;
    json j = {{"name", "bob"}, {"occupation", "gooning"}};

    std::ofstream oFile(USERDATA_DIR "/user1.json");
    oFile << j.dump(4);
    oFile.close();
}
} // namespace bob