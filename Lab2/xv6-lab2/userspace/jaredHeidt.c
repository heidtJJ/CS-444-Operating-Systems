// Test that fork fails gracefully.
// Tiny executable so that the limit can be filling the proc table.

#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

#define N  1000

int
main(void)
{
  int rc = fork();
  int fd;
  if (rc < 0)
    printf (1, "Failed");
  else if (rc == 0){

    int grandChild = fork();
    if(grandChild < 0)
        printf(1,"Grandchild failed\n");
    else if(grandChild == 0){
	printf(1, "Grand Child's branch, start writing to file.\n");
	fd = open("test.txt", O_CREATE | O_WRONLY);
	write(fd, "Hello World\n", 13);
	close(fd);
        exit();
    }
    else{
        
	wait();
	printf(1, "Child's branch, list all files\n");
	char* args[2];
	args[0] = "ls";
	args[1] = 0;
        exec("ls", args);
        exit();
    }

  }
  else{
    wait();
    printf(1, "Parent's branch, print content written by grand child\n");
    close(0);
    open("test.txt", O_RDONLY);
    char* arg[2];
    arg[0] = "cat";
    arg[1] = 0;
    exec("cat", arg);
    exit();
  }
}
