#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <pthread.h>
#include <semaphore.h>
#include <signal.h>       

//At most you can have CMAX threads for producers or consumers
#define CMAX (10) 
#define PMAX (10)
sem_t empty;
sem_t full;
sem_t mutex;

//Define global variables here
int numConsumers;
int numProducers;

int use = 0;
int fill = 0;

int bufferSize;
int* buffer;

/* ==================================================== */
/* SIGNAL INTERRUPT HANDLER (Catches the SIGINT signal) */
/* ==================================================== */
int stopFlag = 0;
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

void
Sem_init(sem_t *sem, unsigned int value) 
{
    int rc = sem_init(sem, 0, value);
    assert(rc == 0);
}

void Sem_wait(sem_t *sem) 
{
    int rc = sem_wait(sem);
    assert(rc == 0);
}

void Sem_post(sem_t *sem) 
{
    int rc = sem_post(sem);
    assert(rc == 0);
}


void do_fill(int value) 
{
//Implement fill operations here, fill one item per time 
    buffer[fill] = value;
    ++fill;
    if( fill == bufferSize)
	    fill = 0;
}

int do_get()
{
//Implement get operations here, remove one item per time 
    int tmp = buffer[use];
    ++use;
    if(use == bufferSize)
	    use = 0;
    return tmp;
}

void *
producer(int * arg)
{
    int i;
    while (!stopFlag) {
    //Use semphores to produce an item here
    //print a message: producer x fills y
        i = rand() % 100;
        Sem_wait( &empty );
	Sem_wait( &mutex );

	do_fill( i );
	printf("Producer %d fills %d\n", arg, i);

	Sem_post( &mutex );
	Sem_post( &full );    
    }

    // end case
    if(stopFlag == 1){
    // Gracefully quit the program when CTRL + c
    // At this time, only fill -1 to the buffer
    //Should print a message:  Producer x  fills -1  
        Sem_wait( &mutex );
        for( i = 0; i < bufferSize; ++i ){
		if( buffer[i] != -1){	 
	    		do_fill( -1 );	    
	   		 printf("Producer %d fills %d\n", arg, -1);  
		}
	}    

	for( i = 0; i < numConsumers; ++i){
		Sem_post( &full );
	}

	Sem_post( &mutex );

	
    }
    return NULL;
}
                                                                               
void *
consumer(int * arg)
{
    int tmp = 0;
    while ( !stopFlag ) {
    //Use semphores to consume an item here
    //print a message: consumer x removes y
    	Sem_wait( &full );
	Sem_wait( &mutex );
	
	tmp = do_get();
	printf( "Consumer %d removes %d\n", arg, tmp );
	
	Sem_post( &mutex );
	Sem_post( &empty );    
    }
    return NULL;
}

void 
main(int argc, char *argv[])
{
    if (argc != 4) {
	fprintf(stderr, "usage: %s <buffersize> <producers> <consumers>\n", argv[0]);
	exit(1);
    }
    //variables initlization here
    bufferSize = atoi( argv[1] );
    numProducers = atoi( argv[2] );
    numConsumers = atoi ( argv[3] );

   
    buffer = (int *) malloc( bufferSize * sizeof(int) );
    int i;
    for( i = 0; i < bufferSize; ++i){
    	buffer[i] = 0;
    }

    signal(SIGINT, handler);
    
    //Initializing semphores here
    Sem_init( &empty, bufferSize );// max are empty
    Sem_init( &full, 0 );// 0 are full
    Sem_init( &mutex, 1 );// mutex


    //Start running producer and consumer threads here
    pthread_t pid[PMAX], cid[CMAX];
    
    for( i = 0; i < numProducers; ++i ){
    	Pthread_create( &pid[i], NULL, producer, (void*)i );
    }
    
    for( i = 0; i < numConsumers; ++i ){
    	Pthread_create( &cid[i], NULL, consumer, (void*)i );
    }
    
    //Join producer and consumer thread here
    for( i = 0; i < numProducers; ++i ){
    	Pthread_join( pid[i], NULL );
    }
    
    for( i = 0; i < numConsumers; ++i ){
    	Pthread_join( cid[i], NULL );
    }
   
    // Destroy semphores here
    sem_destroy( &empty );
    sem_destroy( &full );
    sem_destroy( &mutex );

    exit(0);
}

