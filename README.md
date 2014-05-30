[CMake][2] module for building [Ragel][1] machine files.

2014-05-10, Georg Sauthoff <mail@georg.so>

## Background

[Ragel][1] is a parser generator for regular languages with some advanced
features. In some aspects it is similar to Lex/Flex but without the need to use
a certain buffering scheme, more flexible, not restricted to a scanner approach
and has rich support for regular language operators and user defined actions.
The ragel binary takes a regular state machine description as input and generates
efficient C/C++/... code.

## Examples

The example `CMakeLists.cmake` project shows how to use the `FindRAGEL.cmake`
module (additional comments are in the module itself). It builds 2 Ragel
example programs (located in the `example` sub-directory).

You can build them like this:

    $ mkdir build
    $ cd build
    $ cmake ../CMakeLists.txt ..
    -- The CXX compiler identification is GNU 4.8.2
    -- The C compiler identification is GNU 4.8.2
    -- Check for working CXX compiler: /usr/lib64/ccache/c++
    -- Check for working CXX compiler: /usr/lib64/ccache/c++ -- works
    -- Detecting CXX compiler ABI info
    -- Detecting CXX compiler ABI info - done
    -- Check for working C compiler: /usr/lib64/ccache/cc
    -- Check for working C compiler: /usr/lib64/ccache/cc -- works
    -- Detecting C compiler ABI info
    -- Detecting C compiler ABI info - done
    -- Found RAGEL: /usr/bin/ragel (found suitable version "6.6", minimum required is "6.6") 
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /home/gms/program/cmake_ragel/build
    $ make                            
    Scanning dependencies of target nested
    [ 25%] Building CXX object CMakeFiles/nested.dir/nested.cc.o
    Linking CXX executable nested
    [ 50%] Built target nested
    [ 75%] [RAGEL][number] Compiling state machine with Ragel 6.6
    Scanning dependencies of target number
    [100%] Building C object CMakeFiles/number.dir/number.c.o
    Linking C executable number
    [100%] Built target number

You can also use an alternative build file generator:

    $ mkdir build
    $ cd build
    $ cmake ../CMakeLists.txt -G Ninja ..
    -- The CXX compiler identification is GNU 4.8.2
    -- The C compiler identification is GNU 4.8.2
    -- Check for working CXX compiler using: Ninja
    -- Check for working CXX compiler using: Ninja -- works
    -- Detecting CXX compiler ABI info
    -- Detecting CXX compiler ABI info - done
    -- Check for working C compiler using: Ninja
    -- Check for working C compiler using: Ninja -- works
    -- Detecting C compiler ABI info
    -- Detecting C compiler ABI info - done
    -- Found RAGEL: /usr/bin/ragel (found suitable version "6.6", minimum required is "6.6") 
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /home/gms/program/cmake_ragel/build
    $ ninja-build 
    [6/6] Linking CXX executable nested

Usage notes for the examples are included in the source files.


[1]: http://www.complang.org/ragel/
[2]: http://www.cmake.org/
