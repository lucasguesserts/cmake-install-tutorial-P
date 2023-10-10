#include "P/ClassP.hpp"

#include <Q/ClassQ.hpp>
#include <fmt/core.h>

namespace P {

ClassP::ClassP() : Q::ClassQ() {
  fmt::print("{:s} constructor!\n", "ClassP");
  return;
}

ClassP::~ClassP() {}

void ClassP::print() {
  Q::ClassQ::print();
  fmt::print("a number: {:d}\n", 10);
  return;
}

} // namespace P
