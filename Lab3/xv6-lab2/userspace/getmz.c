#include "types.h"	
#include "stat.h"	      
#include "user.h"	        
int main(void) {	
	printf(1,"Current running process memory size: %d\n", getmz());
	exit();
}
