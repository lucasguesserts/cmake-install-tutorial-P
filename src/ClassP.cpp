#include "P/ClassP.hpp"

#include <Q/ClassQ.hpp>
#include <fmt/core.h>
#include <nlohmann/json.hpp>

namespace P {

ClassP::ClassP() : Q::ClassQ() {
  fmt::print("{:s} constructor!\n", "ClassP");
  return;
}

ClassP::~ClassP() {}

void ClassP::print(const nlohmann::json &json) {
  Q::ClassQ::print();
  fmt::print("{:s}\n", json.dump(4));
  fmt::print("a number: {:d}\n", 10);
  return;
}

} // namespace P
