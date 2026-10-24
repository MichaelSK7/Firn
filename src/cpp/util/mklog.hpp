#pragma once
#include <fstream>
#include <mutex>
#include <string>

inline mklog& mk = mklog::getInstance();

class mklog {
  private:
    std::ofstream file;
    std::mutex mutex;
    mklog();
    ~mklog() = default;

  public:
    static mklog& getInstance();

    void info(const std::string& message);
    void error(const std::string& message);

    mklog(const mklog&) = delete;
    mklog& operator=(const mklog&) = delete;
};