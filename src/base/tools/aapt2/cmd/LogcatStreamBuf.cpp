#include <iostream>
#include <streambuf>
#include <android/log.h>

class LogcatStreamBuf : public std::streambuf {
public:
    LogcatStreamBuf(const std::string& tag, android_LogPriority priority)
            : tag_(tag), priority_(priority) {}

protected:
    virtual int overflow(int c) override {
        if (c == '\n') {
            flush();
        } else {
            buffer_ += static_cast<char>(c);
        }
        return c;
    }

    virtual int sync() override {
        if (!buffer_.empty()) {
            __android_log_print(priority_, tag_.c_str(), "%s", buffer_.c_str());
            buffer_.clear();
        }
        return 0;
    }

private:
    void flush() {
        if (!buffer_.empty()) {
            __android_log_print(priority_, tag_.c_str(), "%s", buffer_.c_str());
            buffer_.clear();
        }
    }

    std::string buffer_;
    std::string tag_;
    android_LogPriority priority_;
}