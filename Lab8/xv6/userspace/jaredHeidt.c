#include "types.h"
#include "stat.h"
#include "user.h"
#include "x86.h"
#define PGSIZE 4096

int total = 1;

int lock_init(lock_t *lk)
{
	lk->flag = 0;
	return 0;
}

void lock_acquire(lock_t *lk){
	while(xchg(&lk->flag, 1) != 0);
}

void lock_release(lock_t *lk){
	xchg(&lk->flag, 0);
}
int thread_create(void (*start_routine)(void*), void *arg){

	lock_t lk;
	lock_init(&lk);
	lock_acquire(&lk);
	void *stack = malloc(PGSIZE*2);

	lock_release(&lk);
	if((uint)stack % PGSIZE)
		stack = stack + (PGSIZE - (uint)stack % PGSIZE);
	int result = clone_jared(start_routine,arg,stack);
	free(stack);
	return result;
}

// Bonus 
int thread_join(){
	void *stack = malloc(sizeof(void*));
	int result = 0;
	//int result= join(&stack);
	lock_t lk;
	lock_init(&lk);
	lock_acquire(&lk);
	free(stack);
	lock_release(&lk);
	return result;
}

// total = 1
void worker(void *arg){
	int *test = (int *)arg;
	lock_t lk;
	lock_init(&lk);
	lock_acquire(&lk);
	total += *test;
	lock_release(&lk);
}
int
main(void)
{
	int arg = 10; 
	int result = thread_create(worker, &arg);

	result = thread_create(worker, &arg);
	result = thread_create(worker, &arg);
	result = thread_create(worker, &arg);
	while(total == 1){
		printf(1, "Result: %d, %d\n", result, total);
	}
	printf(1, "Result: %d, %d\n", result, total);
	exit();
}
