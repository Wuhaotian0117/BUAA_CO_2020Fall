#include<stdio.h>
#include<string.h>
char str[25];
int main(){
	printf("Please enter your string:\n");
	int n = 0,i = 0,j = 0;
	int result = 1;
	char c_scan;
	scanf("%d",&n);
	scanf("%c",&c_scan);
	
	for(i=0;i<n;i++)
	scanf("%c",&str[i]);
	
	for(i = 0,j = strlen(str)-1; i<=j;  i++,j--){
		if(str[i]!=str[j]){
			result = 0;
			break;
		}
	}
	
	printf("%s\n",str);
	printf("%d",result);
	return 0;
} 
