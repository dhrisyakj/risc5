#include <stdint.h>
#include "../include/utils.h"
int main() {
int A[8] = {1,2,3,4,5,6,7,8};
int B[8] = {2,3,4,5,6,7,8,9};
int i,acc=0;
int cycle_start, cycle_end ,cycles,cycle_def;
cycle_start = get_cycle_value();
cycle_end = get_cycle_value();
cycle_def = cycle_end - cycle_start;
for (i = 0; i < 8; i++) {       
    acc = acc + A[i]*B[i];
}
cycle_end = get_cycle_value();
cycles = cycle_end - cycle_start - cycle_def;
if(i==8) {
        set_test_pass();
        set_test_value(cycles);
    }
    else
        set_test_fail();
return 0;
}
