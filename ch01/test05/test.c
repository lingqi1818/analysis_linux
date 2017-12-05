#include <stdio.h>  
#include <stdlib.h>  
#include <unistd.h>  
#include <pthread.h>  
void print(char *p){
        printf("%s.\n",p);
}

void* test_fn(void* arg)  
{  
    while(1){
    print("hello pthread");  
  
    sleep(5);  }
  
    return((void *)0);  
}  
 
int main(int argc,char **argv)  
{  
    pthread_t id;   
    int ret;  
  
    ret = pthread_create(&id,NULL,test_fn,NULL);  
    if(ret != 0)  
    {     
        printf("create pthread error!\n");  
        exit(1);  
    }     
    printf("in main process.\n");  
  
    pthread_join(id,NULL);  
  
    return 0;  
}
