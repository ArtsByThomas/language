#include <stdio.h>
int main(){ long s=0; for(long i=0;i<30000;i++) for(long j=0;j<10000;j++) s+=((i*j)^(i+j))%7; printf("%ld\n",s); return 0; }
