#include "types.h"
#include "user.h"

int main(){
	int  p = shm_jared(0,2);

	int* test;
	test = (int*)p;
	*test = 10;
	int t = 100;
	int* x = &t;
	if(fork() == 0){
		if(fork() == 0){
			test = (int*)p;
			*test = 30;
			*x = 130;
			printf(1,"Grand Child: %x, %d, %x, %d\n", test, *test, x, *x);
			exit();
		}
		else{
			wait();
			p = shm_jared(1,2);
			printf(1, "Child sharing key 1\n");
			test = (int*)p;
			*test = 40;
			*x = 140;
			printf(1, "Child: %x, %d, %x, %d\n", test, *test, x, *x);
			exit();
		}
	}
	else{
		wait();
		printf(1, "Before sharing key 1\n");
		printf(1, "Parent: %x, %d, %x, %d\n", test, *test, x, *x);
		p = shm_jared(1,4);
		printf(1, "After sharing key1\n");
		test = (int *)p;
		printf(1, "Parent: %x, %d, %x, %d\n", test, *test, x, *x);	
	}


	
	exit();
}
