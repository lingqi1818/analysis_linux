#include <pthread.h>
#include <assert.h>

int cpu_thread1 = 0;
int cpu_thread2 = 1;

volatile int x, y, r1, r2;

void start() {
	x = y = r1 = r2 = 0;
}

void end() {
	assert(!(r1 == 0 && r2 == 0));
}

void run1() {
	x = 1;
	r1 = y;
}

void run2() {
	y = 1;
	r2 = x;
}

// -------------------
static pthread_barrier_t barrier_start;
static pthread_barrier_t barrier_end;

static void* thread1(void*) {
	while (1) {
		pthread_barrier_wait(&barrier_start);
		run1();
		pthread_barrier_wait(&barrier_end);
	}

	return NULL;
}

static void* thread2(void*) {
	while (1) {
		pthread_barrier_wait(&barrier_start);
		run2();
		pthread_barrier_wait(&barrier_end);
	}

	return NULL;
}

int main() {
	assert(pthread_barrier_init(&barrier_start, NULL, 3) == 0);
	assert(pthread_barrier_init(&barrier_end, NULL, 3) == 0);

	pthread_t t1;
	pthread_t t2;
	assert(pthread_create(&t1, NULL, thread1, NULL) == 0);
	assert(pthread_create(&t2, NULL, thread2, NULL) == 0);

	cpu_set_t cs;
	CPU_ZERO(&cs);
	CPU_SET(cpu_thread1, &cs);
	assert(pthread_setaffinity_np(t1, sizeof(cs), &cs) == 0);
	CPU_ZERO(&cs);
	CPU_SET(cpu_thread2, &cs);
	assert(pthread_setaffinity_np(t2, sizeof(cs), &cs) == 0);

	while (1) {
		start();
		pthread_barrier_wait(&barrier_start);
		pthread_barrier_wait(&barrier_end);
		end();
	}

	return 0;
}

