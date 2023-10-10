#include "P/ClassP.hpp"

#include <fmt/core.h>

namespace P {

ClassP::ClassP() {
    fmt::print("{:s} constructor!\n", "ClassP");
}

ClassP::~ClassP() {}

void ClassP::print() {
    fmt::print("a number: {:d}\n", 10);
}

} // namespace
