# CMake Install Tutorial - P

This is one of three repositories which "teach"es how to setup cmake to install the targets and its dependencies. The three parts are:

1. [cmake-install-tutorial-Q](https://github.com/lucasguesserts/cmake-install-tutorial-Q);
2. [cmake-install-tutorial-P](https://github.com/lucasguesserts/cmake-install-tutorial-P) (this one);
3. [cmake-install-tutorial-R](https://github.com/lucasguesserts/cmake-install-tutorial-R);

The dependency tree is: `Q -> P -> R`, where `X -> Y` means that `Y` depends on `X`.

## Dependencies of this project

This project depends on [cmake-install-tutorial-Q](https://github.com/lucasguesserts/cmake-install-tutorial-Q). Before using it, make sure that `Q` is installed in your system. If it is not, go to its page and follow the instructions to install it.

## Using this project as a dependency

This project was designed work both installing locally and via [CPM](https://github.com/cpm-cmake/CPM.cmake) (version 0.38).

### Installing locally

To install it locally, run:

```sh
make install
```

By default, it is installed in `$HOME/foo`. Yes, it is a stupid dir, but that is the point, the only way to find it is by manually pointing to it. If you want to install it in another dir, change the variable `INSTALL_LOCATION` in the [Makefile](./Makefile).

Then add it as a dependency in the `CMakeLists.txt`:

```cmake
set(FIND_LIBRARY_USE_LIB64_PATHS TRUE)
find_package(P
    0.0.0
    REQUIRED
    CONFIG
    PATHS "$ENV{HOME}/foo/"
)
```

### Installing with CPM

First, download the file `get_cpm.cmake` (available [here](https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.38.6/get_cpm.cmake)) and add it to your project in the dir `cmake` (create such dir). Then, add the following to your `CMakeLists.txt`:

```cmake
include(cmake/get_cpm.cmake)
CPMAddPackage(
    NAME P
    VERSION 0.2.0
    GITHUB_REPOSITORY lucasguesserts/cmake-install-tutorial-P
)
```

## References

This project would not be possible without the [modern-cpp-template](https://github.com/filipdutescu/modern-cpp-template).
