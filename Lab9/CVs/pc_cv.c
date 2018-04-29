#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <pthread.h>
#include <semaphore.h>
#include <signal.h>       
#include <syscall.h>

//At most you can have CMAX threads for producers or consumers
#define CMAX (40) 

pthread_cond_t empty  = PTHREAD_COND_INITIALIZER;
pthread_cond_t fill   = PTHREAD_COND_INITIALIZER;
pthread_mutex_t m     = PTHREAD_MUTEX_INITIALIZER;

// Define global variables here
int bufferSize;// max in other file
int* buffer;
int numConsumers;
int numProducers;

int useptr = 0;
int fillptr = 0;
int numfull = 0;

/* ==================================================== */
/* SIGNAL INTERRUPT HANDLER (Catches the SIGINT signal) */
/* ==================================================== */
int stopFlag = 0; // Flag for signaling other threads to stop running.
void handler(int signo)
{
	if(signo == SIGINT) {
		printf(" Stopping...\n");
		stopFlag = 1;
	}
}

void
Pthread_mutex_lock(pthread_mutex_t *m)
{
    int rc = pthread_mutex_lock(m);
    assert(rc == 0);
}
                                                                                
void
Pthread_mutex_unlock(pthread_mutex_t *m)
{
    int rc = pthread_mutex_unlock(m);
    assert(rc == 0);
}
                                                                                
void
Pthread_create(pthread_t *thread, const pthread_attr_t *attr, 	
	       void *(*start_routine)(void*), void *arg)
{
    int rc = pthread_create(thread, attr, start_routine, arg);
    assert(rc == 0);
}

void
Pthread_join(pthread_t thread, void **value_ptr)
{
    int rc = pthread_join(thread, value_ptr);
    assert(rc == 0);
}

void do_fill(int value) 
{
//Implement fill operations here
//Fill one item each time
     buffer[fillptr] = value;
     fillptr = (fillptr + 1) % bufferSize;
     numfull++;
}

int do_get()
{
//Implement get item here, remove one item each time
// Return the value consumed by the consumer
      int tmp = buffer[useptr];
      useptr = (useptr + 1) % bufferSize;
      --numfull;
      return tmp;
}

void *
producer(int *arg)
{
    while (!stopFlag) { 
    //Implement producer mutex and CVs here
    //Should print a message:  Producer x  fills y  
	
	Pthread_mutex_lock(&m); // p1
	while (numfull == bufferSize) //p2
	    pthread_cond_wait(&empty, &m); // p3
	sleep(1);
	int randomNum = rand() % 100;
	printf("Producer %d fills %d\n", syscall(SYS_gettid)%numProducers ,randomNum);
	do_fill(randomNum); // p4
	pthread_cond_signal(&fill); //p5
	Pthread_mutex_unlock(&m); // p6   
    }

    if(stopFlag == 1){ //end case
    // Gracefully quit the program when CTRL + c
    // At this time, only fill -1 to the buffer
    //Should print a message:  Producer x  fills -1  
    
    	Pthread_mutex_lock(&m); // p1
	int toFill = -1;
	int i;
	for(i = 0; i < bufferSize; ++i){
		if(buffer[i] != -1){
			printf("Producer %d fills %d\n", syscall(SYS_gettid)%numProducers, toFill);
			do_fill(toFill); // p4
		}
	}

	for(i = 0; i < numConsumers; ++i){
		pthread_cond_signal(&fill); //p5
	}
	
	Pthread_mutex_unlock(&m); // p6     
    }

    return NULL;
}
                                                                               
void *
consumer(int *arg)
{
    while (!stopFlag) { 
    //Implement producer mutex and CVs here
    //Should print a message: Consumer x removes y 
    	Pthread_mutex_lock(&m);
   	 while(numfull == 0)
		    pthread_cond_wait(&fill, &m);
	 int tmp = do_get();
	 printf("Consumer %d removes %d\n", syscall(SYS_gettid)%numConsumers, tmp);
	sleep(1);
	 pthread_cond_signal(&empty);
	 Pthread_mutex_unlock(&m);
    }
    return NULL;
}

int
main(int argc, char *argv[])
{
    if (argc != 4) {
	fprintf(stderr, "usage: %s <buffersize> <producers> <consumers>\n", argv[0]);
	exit(1);
    }
    //Implement initilization here
    bufferSize = atoi(argv[1]);
    numProducers = atoi(argv[2]);
    numConsumers = atoi(argv[3]);

   // initialize buffer
    buffer = (int *) malloc(bufferSize * sizeof(int));
    int i;
    for(i = 0; i < bufferSize; ++i){
	buffer[i] = 0;
    }

    /* ----------------------- */
    /* REGISTER SIGNAL HANDLER */
    /* ----------------------- */
    signal(SIGINT, handler);
    
    
    //Create producer threads and consumer threads here
    pthread_t producers[CMAX], consumers[CMAX];

    // initialize producers
    for(i = 0; i < numProducers; ++i){
    	Pthread_create(&producers[i], NULL, producer, NULL);
    }
    //initialize consumers 
    for(i = 0; i < numConsumers; ++i){
    	Pthread_create(&consumers[i], NULL, consumer, NULL);
    }   


    //Join producer and consumer threads here
    // join producers
    for(i = 0; i < numProducers; ++i){
    	Pthread_join(producers[i], NULL);
    }
    //initialize consumers 
    for(i = 0; i < numConsumers; ++i){
    	Pthread_join(consumers[i], NULL);
    } 
    
    // Destroy the (by now unlocked) mutex lock.
    pthread_mutex_destroy(&m); 
   
    // Destroy CV fill.
    pthread_cond_destroy(&fill);
    
    // Destroy CV empty.
    pthread_cond_destroy(&empty);

    exit(0);
}

