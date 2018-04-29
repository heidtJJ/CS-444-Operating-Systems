#include "types.h"
#include "stat.h"
#include "user.h"

int
main(void)
{
  int p = (int)shm_jared(0, 1);
  int *test;
  test = (int *)p;
  *test = 10;
    printf(1, "test initial value %d\n", *test);
  int ret = fork();

  if (ret == 0){
    int * test_child;
    test_child = (int*)shm_jared(0, 1);
    printf(1, "test value (child) %d\n", *test_child);
    *test_child = 20;
    printf(1, "test value (child) %d\n", *test_child);
    exit();
  }
  wait();
  test = (int*)shm_jared(0, 1);
  printf(1, "test value (parent) %d\n", *test);
  

  
  exit();
}

