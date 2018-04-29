// Test that fork fails gracefully.
// Tiny executable so that the limit can be filling the proc table.

#include "types.h"
#include "stat.h"
#include "user.h"


int
main(void)
{
  char * arg[1];
  arg[0] = "ls";
  int rc = fork();
  if (rc < 0)
    printf (1, "Failed");
  else if (rc == 0){
    printf (1, "Child's branch\n");
    return exec ("ls", arg);
    printf (1, "This will not be printed out\n");
  }
  else{
    wait();
    printf (1, "Parent's branch\n");
  }
  exit();
}
