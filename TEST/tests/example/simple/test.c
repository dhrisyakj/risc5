#include <stdint.h>
#include "../include/utils.h"

int main()
{
    uint64_t start;
    start =get_cycle_value();
    set_test_value(start);
}
