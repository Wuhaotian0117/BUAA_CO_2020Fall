#include<stdio.h>
int main()
{
	int n = 0;
	int a[1000] = {0};
	scanf("%d",&n);
	
	if(n==0){
		printf("1\n");
	}
	else {
		a[0] = 1;
		int product = 0,carry = 0;
		int i = 0,j = 0;
		
		for(i = 1;i <= n; i++){
			carry = 0;
			for(j = 0;(j < 999);j++){
				product = a[j]*i + carry;
				a[j] = product % 10;
				carry = product / 10;
			}
		}
		for(j = 999;j >= 0;j--){
			if(a[j])
			break;
		}
		for(i = j;i >= 0;i--)
		printf("%d",a[i]);
		//printf("**//%d//**",j);
	}	
	return 0;
}
