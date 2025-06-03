#include <stdint.h>
#include "../include/utils.h"

int main()
{
   int a=5;
   int b=3;
   int c=1;
   int d=1;
   uint64_t start, end, cycles,cycles_def;
   start = get_cycle_value();
   end = get_cycle_value();
   cycles_def = start - end;
   start = get_cycle_value();
   asm volatile (
        ".insn r 0x2B, 0x7, 0x01, %0, %1, %2"
        : "=r"(c)
        : "r"(a), "r"(b)
    );
   end = get_cycle_value();
   cycles = end - start -cycles_def;
    if(d==1) {
        set_test_pass();
        set_test_value(cycles);
    }
    else
        set_test_fail();
    return 0;
}


