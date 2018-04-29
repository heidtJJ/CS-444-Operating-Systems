#include "types.h"
#include "stat.h"
#include "user.h"

int main(){

	int* p;
	p = (int*)mem_jared();
	printf(1,"address: %p\tcontent: %d \n", p, *p);
	exit();
}
