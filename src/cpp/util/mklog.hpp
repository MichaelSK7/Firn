#pragma once
#include <ctime>
#include <fstream>
#include <mutex>
#include <string>

class mklog {
  private:
    std::ofstream file;
    std::mutex mutex;
    char buffer[100];

    mklog();
    ~mklog() = default;

  public:
    static mklog& getInstance();

    void info(const std::string& message);

    void error(const std::string& message);

    mklog(const mklog&) = delete;
    mklog& operator=(const mklog&) = delete;
};