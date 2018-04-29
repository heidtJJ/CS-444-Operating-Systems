#include "types.h"
#include "stat.h"
#include "user.h"

int
main(void)
{
	int j = 0;
	int rc = fork();
	if(rc < 0)
		printf(1,"Failed\n");
	else if(rc == 0){
		while(1){
			j = j + 3.14*6/18;
			if(j >= 300000000)
				break;
		}
	}
	else{
		while(1){
			j = j + 3.14*6/18;
			if(j >= 300000000)
				break;
		}
	}
	exit();
}
