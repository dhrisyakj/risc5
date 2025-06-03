#include <stdint.h>
#include "../include/utils.h"
#define CUSTOM_NOP ".word 0x00000001"
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
        ".insn r 0x2B, 0x5, 0x01, x0, %0, %1"
        : 
        : "r"(a), "r"(b)
    );
    asm volatile (
        ".insn r 0x2B, 0x6, 0x01, %0, x0, x0"
        : "=r"(acc)
        : 
    );
    //asm volatile(CUSTOM_NOP);
   end = get_cycle_value();
   cycles_end = end - start;
   cycles = cycles_end - cycles_def;
    if(i==0) {
        set_test_pass();
        set_test_value(acc);
    }
    else
        set_test_fail(); 
    return 0; 
}