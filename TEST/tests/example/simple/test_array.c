#include <stdint.h>
#include "../include/utils.h"

//volatile int my_array[5] __attribute__((section(".data")));

int main()
{
    uint64_t start, end, cycles,a;
    start = get_cycle_value();
    // int i=0;
    // int a=5;
    //end = get_cycle_value();
    //a = get_cycle_value();
     //cycles = end - start;
     set_test_value(start);
    /*
    int i = 0;
    for (i =0;i<5;i++)
       {
	  my_array[i] = i+1;
       }
    
    
    //if (my_array[i-1]==5)
    if(a==5)
        set_test_pass();
    else
        set_test_fail();

      //end = get_cycle_value();
    */
    // Calculate the difference to find cycles taken by the loop
    
    //printf("Cycles taken: %llu\n", cycles);
    
    return 0;
}
