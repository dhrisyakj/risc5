#include <stdint.h>
#include "../include/utils.h"

int main()
{ 
   int a=5;
   int b=3;
   int c=1;
   int i=0;
   int acc;
   uint64_t start, end, cycles,cycles_def,cycles_end;
   start = get_cycle_value();
   end = get_cycle_value();
   cycles_def = end - start;
   start = get_cycle_value();
    asm volatile (
        ".insn r 0x2B, 0x5, 0x01, %0, %1, %2"
        : "=r"(acc)
        : "r"(a), "r"(b)
    );
   end = get_cycle_value();
   cycles_end = end - start;
   cycles = cycles_end - cycles_def;
    if(i==0) {
        set_test_pass();
        set_test_value(cycles);
    }
    else
        set_test_fail(); 
    return 0; 
}