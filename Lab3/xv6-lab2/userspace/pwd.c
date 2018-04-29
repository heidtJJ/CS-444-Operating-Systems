#include "types.h"
#include "user.h"

char buf[512];

int
main(int argc, char *argv[])
{
	char *res;

	res = getcwd(buf, 512);

	if(res) {
		printf(1, "%s\n", res);
	} else {
		printf(2, "getcwd() failed");
	}

	exit();
}
