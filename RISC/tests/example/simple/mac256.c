#include <stdint.h>
#include "../include/utils.h"

#define N 256

volatile uint32_t A[N];
volatile uint32_t i;
volatile uint32_t B[N];
volatile uint32_t acc1, acc2;
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
for (i = 0; i < N; i++) {       
        acc += A[i] * B[i];
    }
// Gets the csr register value after executing the MAC operation for 256 numbers
cycle_end = get_cycle_value();
    acc2 = acc;   
// Subtracts the overhead cycles to perform the get_cycle_value operation.
cycle_count = cycle_end - cycle_start - cycle_def;
if(i==0) {
        set_test_pass();
        set_test_value(cycle_count);
    }
    else
        set_test_fail();


    return 0;
}

 /*
        if (i == 127) {
            //cycle_end = get_cycle_value();
            acc1 = acc;  
            acc = 0;
        }
        */