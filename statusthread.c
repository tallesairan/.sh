#include <stdio.h>
#include <pthread.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <stdlib.h>

#define NUMTHREADS 4

// headers
void *printInfo(void *arg);
void *getDate(void *arg);
void *getStocks(void *arg);
void *updateTime(void *arg);
void *getVolume(void *arg);

char *weekrussian(int num);
char *monthrussian(int num);
char *dayrussian(int num);

// structures
typedef struct{
  char *day;
  char *weekday;
  char *month;
  int h,m,s,y;
} DateTime;

// global variables

volatile DateTime datetime;
pthread_t th[NUMTHREADS];
pthread_mutex_t mutex;
volatile struct tm *current;
volatile char *volume;

// main

int main() {
  int err[3];
  pthread_mutex_init(&mutex,NULL);

  err[0] = pthread_create(&(th[0]),NULL,&printInfo,NULL);
  err[1] = pthread_create(&(th[1]),NULL,&updateTime,NULL);
  err[2] = pthread_create(&(th[2]),NULL,&getDate,NULL);

  for (int i=0; i<NUMTHREADS; i++) {
    if (err[i] != 0)
      printf("\ncan't create thread :[%s]", strerror(err[i]));
    else
      printf("\n Thread %d created successfully\n",i);
  }

  for(int i=0; i<NUMTHREADS; i++)
    (void) pthread_join(th[i],NULL);

  return 0;
}


///////////////////////////////////// Functions

// print all info
void *printInfo(void *arg) {
  char output[100];
  sleep(1);
  while(1){
    pthread_mutex_lock(&mutex);
    sprintf(output,"echo '%s - %s, %s, %d - %02d:%02d:%02d '",datetime.weekday,datetime.day,datetime.month,datetime.y,datetime.h,datetime.m,datetime.s);
    system(output);
    pthread_mutex_unlock(&mutex);
    usleep(500000);
  }
  return NULL;
}

void *getVolume(void *arg) {
  
}

// every 250000ns = 0.25s updates date and time variable (datetime.current) and .time
void *updateTime(void *arg){
  time_t aux;
  int h,m,s;
  struct tm *tempo;
  while(1){
    pthread_mutex_lock(&mutex);
    time(&aux);
    current = localtime(&aux);

    datetime.h = current->tm_hour;
    datetime.m = current->tm_min;
    datetime.s = current->tm_sec;
    

    pthread_mutex_unlock(&mutex);
    usleep(250000);
  }
  return NULL;
}

// Gets the .current info and put'em in .weekday .month .day
void *getDate(void *arg) {
  int day,week,month,year;
  char *aux_day, *aux_week, *aux_month;
  while(1){
    pthread_mutex_lock(&mutex);
    day = current->tm_mday;
    week = current->tm_wday;
    month = current->tm_mon;
    year = current->tm_year;
    pthread_mutex_unlock(&mutex);
  
    aux_day = dayrussian(day);
    aux_week = weekrussian(week);
    aux_month = monthrussian(month);

    pthread_mutex_lock(&mutex);
    datetime.day = aux_day;
    datetime.weekday = aux_week;
    datetime.month = aux_month;
    datetime.y = year+1900;
    pthread_mutex_unlock(&mutex);

    sleep(60);
  }
  return NULL;
}


// The next 3 functions "translate" date infos to russian

char *weekrussian(int num){
  switch(num){
  case 0:
    return "Воскресенье";
  case 1:
    return "Понедельник";
  case 2:
    return "Вторник";
  case 3:
    return "Среда";
  case 4:
    return "Четверг";
  case 5:
    return "Пятница";
  case 6:
    return "Суббота";
  }
    return "ERROR DAYWEEK"; 
}

char *monthrussian (int num) {
  switch(num){
  case 0:
      return "января";
  case 1:
      return "февраля";
  case 2:
      return "марта";
  case 3:
      return "апреля";
  case 4:
      return "мая";
  case 5:
      return "июня";
  case 6:
      return "июля";
  case 7:
      return "августа";
  case 8:
      return "сентября";
  case 9:
      return "октября";
  case 10:
    return "ноября";
  case 11:
    return "декабря";
  }
  return "ERROR MONTH";
}

char *dayrussian(int num) {
  switch(num) {
  case 1:
    return "Первое";
  case 2:
    return "Второе";
  case 3:
    return "Третье";
  case 4:
    return "Четвертое";
  case 5:
    return "Пятое";
  case 6:
    return "Шестое";
  case 7:
    return "Седьмое";
  case 8:
    return "Восьмое";
  case 9:
    return "Девятое";
  case 10:
    return "Десятое";
  case 11:
    return "Одиннадцатое";
  case 12:
    return "Двенадцатое";
  case 13:
    return "Тринадцатое";
  case 14:
    return "Четырнадцатое";
  case 15:
    return "Пятнадцатое";
  case 16:
    return "Шестнадцатое";
  case 17:
    return "Семнадцатое";
  case 18:
    return "Восемнадцатое";
  case 19:
    return "Девятнадцатое";
  case 20:
    return "Двадцатое";
  case 21:
    return "Двадцать Первое";
  case 22:
    return "Двадцать Второе";
  case 23:
    return "Двадцать Третье";
  case 24:
    return "Двадцать Четвертое";
  case 25:
    return "Двадцать Пятое";
  case 26:
    return "Двадцать Шестое";
  case 27:
    return "Двадцать Седьмое";
  case 28:
    return "Двадцать Восьмое";
  case 29:
    return "Двадцать Девятое";
  case 30:
    return "Тридцатое";
  case 31:
    return "Тридцать Первое";
  }
  return "ERROR DAY IN RUSSIAN";
}
