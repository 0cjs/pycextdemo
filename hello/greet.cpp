#include <stdio.h>

const char * greet(const char *name) {
    // Yeah, yeah, this implementation is bad....
    static char greeting[1024];
    snprintf(greeting, sizeof(greeting), "Hello, %s.", name);
    return greeting;
}
