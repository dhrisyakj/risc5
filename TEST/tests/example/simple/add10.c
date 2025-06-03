#include <stdint.h>
#include "../include/utils.h"

int main()
{
   int a=5;
   int b=3;
   int c=1;
   uint64_t start, end, cycles;
   start = get_cycle_value();
   c = a + b + 10;
   end = get_cycle_value();
   cycles = end - start;

    if(c==28) {
        set_test_pass();
        set_test_value(cycles);
    }
    else
        set_test_fail();
    return 0;
}

  