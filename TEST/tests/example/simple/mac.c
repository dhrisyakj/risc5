#include <stdint.h>
#include "../include/utils.h"

int main()
{
   int a=5;
   int b=3;
   int c=1;
   uint64_t start, end, cycles,cycles_def,cycles_end;
   start = get_cycle_value();
   end = get_cycle_value();
   cycles_def = end - start;
   start = get_cycle_value();
   c = c + (a*b); // One multiplication and one addition
   end = get_cycle_value();
   cycles_end = end - start;
   cycles = cycles_end - cycles_def;
    if(c==16) {
        set_test_pass();
        set_test_value(cycles);
    }
    else
        set_test_fail();
    return 0;
}