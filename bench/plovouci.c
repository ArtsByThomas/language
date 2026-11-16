#include <stdio.h>
int main(void) {
    long n = 50000000;
    double h = 1.0 / n, s = 0.0, x;
    for (long i = 0; i < n; i++) { x = (i + 0.5) * h; s = s + 4.0 / (1.0 + x * x); }
    printf("%f\n", s * h);
    return 0;
}
