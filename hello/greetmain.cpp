#include <iostream>
#include "greet.h"

int main(int argc, char **argv) {
    std::cout << greet(argv[1]) << "\n";
    return 99;
}
