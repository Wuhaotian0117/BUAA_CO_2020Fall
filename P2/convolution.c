#include<stdio.h>
int scan[12][12],core[12][12];
int result[12][12];
int main()
{
	int m1 = 0,n1 = 0,m2 = 0, n2 = 0;
	int i,j,k,l;
	int temp = 0;
	
	scanf("%d%d%d%d",&m1, &n1, &m2, &n2);
	
	for(i = 0; i<m1; i++){
		for(j = 0; j<n1; j++)
		scanf("%d",&scan[i][j]);
	}
	for(i = 0; i<m2; i++){
		for(j = 0; j<n2; j++)
		scanf("%d",&core[i][j]);
	}
	
	for(i = 0; i<m1-m2+1; i++){
		for(j = 0; j<n1-n2+1 ;j++){
			temp = 0;
			for(k = 0; k<m2; k++){
				for(l = 0; l<n2; l++){
					temp+= scan[i+k][j+l] * core[k][l];
				}
			}
			result[i][j] = temp;
		} 
	}
	
	for(i = 0; i<m1-m2+1; i++){
		for(j = 0; j<n1-n2+1 ;j++){
			printf("%d ",result[i][j]);
		}
		putchar('\n'); 
	}			
	return 0;
}
