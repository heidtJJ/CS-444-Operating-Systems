#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char* argv[]){
  int result = setpriority_jared( atoi(argv[1]), atoi(argv[2]) );
  if( result == atoi(argv[2]) ) {
	 printf(1, "Priority changed successfully.\n");
  }
  else {
	 printf(1, "Could not change priority.\n");
  }
  exit();
}
