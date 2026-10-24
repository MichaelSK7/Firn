#include <stdexcept>

#include "mklog.hpp"

mklog::mklog()
    : file(LOG_DIR "/log.txt", std::ios::app) {
    if (!file.is_open()) {
        throw std::runtime_error("Failed to open log.txt");
    }
}

mklog& mklog::getInstance() {
    static mklog instance;
    return instance;
}

void mklog::info(const std::string& message) {
    std::lock_guard<std::mutex> lock(mutex);
    file << "[INFO] " << message << '\n';
    file.flush();
}

void mklog::error(const std::string& message) {
    std::lock_guard<std::mutex> lock(mutex);
    file << "[ERROR] " << message << '\n';
    file.flush();
}