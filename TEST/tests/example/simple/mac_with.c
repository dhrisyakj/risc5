#include <stdint.h>
#include "../include/utils.h"
int main() {
int A[8] = {1,2,3,4,5,6,7,8};
int B[8] = {2,3,4,5,6,7,8,9};
int i=0;
int acc;
uint64_t start, end ,cycles,cycles_def;
start = get_cycle_value();
end = get_cycle_value();
cycles_def = end - start;
start = get_cycle_value();
for(i=0;i<8;i++){
 asm volatile (
        ".insn r 0x2B, 0x5, 0x01, %0, %1, %2"
        : "=r"(acc)
        : "r"(A[i]), "r"(B[i])
    );  
}
asm volatile (
        ".insn r 0x2B, 0x5, 0x01, %0, %1, %2"
        : "=r"(acc)
        : "r"(0), "r"(0)
    );  
end = get_cycle_value();
cycles = end - start - cycles_def;
if(i==8) {
        set_test_pass();
        set_test_value(cycles);
    }
    else
        set_test_fail();
return 0;
}