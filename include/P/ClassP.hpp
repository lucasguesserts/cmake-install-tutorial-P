#ifndef CLASS_P_HPP_
#define CLASS_P_HPP_

#include <Q/ClassQ.hpp>

namespace P {

class ClassP :public Q::ClassQ {
public:
    ClassP();
    ~ClassP();
    virtual void print();
};

} // namespace

#endif
