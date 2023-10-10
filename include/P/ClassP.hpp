#ifndef CLASS_P_HPP_
#define CLASS_P_HPP_

#include <Q/ClassQ.hpp>
#include <fmt/core.h>
#include <nlohmann/json.hpp>

namespace P {

class ClassP : public Q::ClassQ {
public:
  ClassP();
  ~ClassP();
  virtual void print(const nlohmann::json &json);
};

} // namespace P

#endif
