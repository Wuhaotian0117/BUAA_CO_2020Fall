#include<stdio.h>
int main()
{
	int n = 0,m = 0;
	scanf("%d%d",&n,&m);
	int a[100] = {0};
	int b[100] = {0};
	int i = 0,count = 0,j = 0;
	
	for(i = 1;i<=n;i = i%n + 1){
		if(a[i]==0)
		j++;
		if(j==m){
			a[i] = 1;
			b[count] = i;
			count++;
			j = 0;
		}
		if(count==n)
		break;
	}
	for(i = 0;i < count;i++){
		printf("%d ",b[i]);
	}
	return 0;
} 
