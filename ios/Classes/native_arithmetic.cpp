#include <stdint.h>

extern "C" {
// __attribute__((visibility("default"))) __attribute__((used))
int32_t int_add(int32_t x, int32_t y) { return x + y; }

double double_add(double x, double y) { return x + y; }

}
