#include <stdio.h>
#include <stdlib.h>
int main(){ long n=20000000; long *p=calloc(n+1,8); long pocet=0;
 for(long i=2;i<=n;i++) if(!p[i]){ pocet++; for(long j=i*i;j<=n;j+=i) p[j]=1; }
 printf("%ld\n",pocet); return 0; }
