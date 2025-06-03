#include <stdint.h>
#include "../include/utils.h"

#define N 256

volatile uint32_t A[N];
volatile uint32_t i;
volatile uint32_t B[N];
uint64_t cycle_start, cycle_end, cycle_count,cycle_def,cycle_end;
int main() {
    /* Test data */
    for (i = 0; i < N; i++) {
        A[i] = i + 1;
        B[i] = (i + 1) * 2;
    }
    uint64_t acc = 0;
 
cycle_start = get_cycle_value();
cycle_end = get_cycle_value();
cycle_def = cycle_end - cycle_start;
// Gets the inital csr register value before starting the MAC operation
i=0;
cycle_start = get_cycle_value();
for (i = 0; i < N; i++) {       
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

// Gets the csr register value after executing the MAC operation for 256 numbers
cycle_end = get_cycle_value();   
// Subtracts the overhead cycles to perform the get_cycle_value operation.
cycle_count = cycle_end - cycle_start - cycle_def;
if(i==256) {
        set_test_pass();
        set_test_value(cycle_count);
    }
    else
        set_test_fail();


    return 0;
}
