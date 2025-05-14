#include <stdint.h>
#include "../include/utils.h"

int main()
{   
    
    int a=5;
    int b=6;
    int c;
   asm volatile (
        ".insn r 0x2B, 0x5, 0x01, %0, %1, %2"
        : "=r"(c)
        : "r"(a), "r"(b)
    );
    return 0;
}