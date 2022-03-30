#include <string>

#include <android-base/strings.h>

namespace android {
namespace base {
    bool StartsWith(const std::string& str, const char* prefix) {
        return StartsWith((std::string_view)str, *prefix);
    }
} // namespace base
} // namespace android
