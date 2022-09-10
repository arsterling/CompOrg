#include "stdio.h"
#include "string.h"

/*
 *  c abstraction assignment
 */

int main() {
    unsigned int letter = 'a';
    int result = 0;
    int i;
    for(i = 0; i < letter; i++){
        result = result + i + letter;
    }
    printf("Result = %d\n", result);
    return result;
}

