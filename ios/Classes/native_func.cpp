#include <stdint.h>

extern "C" {
// __attribute__((visibility("default"))) __attribute__((used))
int32_t int_add(int32_t x, int32_t y) { return x + y; }

double double_add(double x, double y) { return x + y; }


char * reverse(char *str, int length) {
    //動態申請length+1個長度的字符空間
    int j=0;
    char *reversed_str = new char[length + 1];
    for (int i = length - 1; i >= 0; i--)
    {
        //reversed_str[length - i - 1] = str[i];
        reversed_str[j] = str[i];
        j++;
    }
    //這行很關鍵，切記，讓它最後一個為\0
    reversed_str[length] = '\0';
    return reversed_str;
}


}
