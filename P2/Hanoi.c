#include<stdio.h>
void hanoi(int n,char from,char temp,char to);
void move(int n,char a,char b);
int count = 0;
int main()
{
	int n = 0;
	scanf("%d",&n);
	hanoi(n,'A','B','C');
	return 0;
}
void hanoi(int n,char from,char temp,char to){
	if(n==1){
		move(n,from,to);
	}
	else{
		hanoi(n-1,from,to,temp);
		move(n,from,to);
		hanoi(n-1,temp,from,to);
	}		
}
void move(int n,char a,char b){
	count++;
	printf("µÚ%d´ÎÒÆ¶¯: Move %d from %c to %c\n",count,n,a,b);
} 
