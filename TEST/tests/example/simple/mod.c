#include <stdint.h>
#include "../include/utils.h"
int main(){
    int a,b,c;
    a = 5;
    b = 2;
    asm volatile
    (
    "mod   %[z], %[x], %[y]\n\t"
    : [z] "=r" (c)
    : [x] "r" (a), [y] "r" (b)
    );
    if ( c != 1 ){
         set_test_fail();
         set_test_value(c);
         return -1;

    }
    set_test_pass();
    return 0;
}
