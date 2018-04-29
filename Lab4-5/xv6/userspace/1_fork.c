// Test that fork fails gracefully.
// Tiny executable so that the limit can be filling the proc table.

#include "types.h"
#include "stat.h"
#include "user.h"

#define N  1000

int
main(void)
{
  int rc = fork();
  int t = 1;
  if (rc < 0)
    printf (1, "Failed");
  else if (rc == 0){
    t = 2;
    printf (1, "Child's branch, t = %d\n", t);
    exit();
  }
  else{
    wait();
    printf (1, "Parent's branch, t = %d\n", t);
    exit();
  }
}
