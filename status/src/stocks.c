#include <stdio.h>
#include <stdlib.h>
#include <string.h>



int main() {
  int i = 0;
  char *aux, *aux2;
  FILE *fp = NULL;
  float x;

  while(1) {
    aux = (char*)malloc(10*sizeof(char));
    aux2 = (char*)malloc(10*sizeof(char));
    fp = popen("~/.sh/status/shell_scripts/stocks.sh bees3","r");

    if (fp != NULL ){
      fscanf(fp,"%s",aux);
      fscanf(fp,"%s",aux2);
    }
    pclose(fp);

    x = strtof(aux, NULL);
    /* pthread_mutex_lock(&mutex); */
    /* vol = volume; */
    /* pthread_mutex_unlock(&mutex); */
    printf("%f\t%s\n",x, aux2);
    printf("%d\n",i++);

  }
  return 0;
}
