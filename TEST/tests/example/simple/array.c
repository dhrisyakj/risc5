#include <stdint.h>
#include "../include/utils.h"

int main()
{
    int A[3] = {1,2,3};
    //int b;
    int sum[3];
    int i = 0;
    for (i =0;i<3;i++)
       {
	  sum[i] = A[i] +1;
       }
    
    
    if (i == 3)
        set_test_pass();
    else
        set_test_fail();

    return 0;
}
