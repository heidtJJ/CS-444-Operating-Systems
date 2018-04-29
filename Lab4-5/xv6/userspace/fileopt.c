#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

int main(){
  //create the file
	int fd = open("test.txt", O_CREATE | O_WRONLY);
	write (fd, "Hello World", 12);
	close(fd);

	//read the file
	close(0);
	open("test.txt", O_RDONLY);
	char * arg[2];
	arg[0] = "cat";
	arg[1] = 0;
	exec("cat", arg);
}
