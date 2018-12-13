#include <stdio.h>
#include <time.h>
#include <stdlib.h>


#include "clock.h"


typedef int data_t;

data_t *create_vector_array(unsigned long size)
{
    srand((unsigned int)time(NULL));
    data_t *array = malloc(size * sizeof(data_t));
    
    if (!array)
        return 0;

    for (unsigned long i = 0; i < size; i++)
        array[i] = (data_t) rand() / (data_t)(RAND_MAX/ 100);

    return array;
}

float inner4(data_t *u, data_t *v, long length, data_t *dest)
{
    long i = 0;
    data_t sum = 0; 
    //double *udata = u;
    //double *vdata = v;
    double cyc =0;
    start_comp_counter();
    for (i = 0; i < length; i++) {
      *dest = *dest + u[i] * v[i];
    }
    cyc = get_comp_counter();
    
    float CPE = cyc/length;
   
    printf("For %ld-Dimensional Vector Dot Product. Cycle = %f CPE = %f\n", length, cyc, CPE);
    
    return cyc;    
}


void inner5(double *u, double *v, long length)
{
    long i;
    double sum = 0; 
    for (i = 0; i < length; i++) {
      sum = sum + u[i] * v[i];
    }    
}


int main(){


    FILE *f = fopen("file_int_d_o3.txt", "w");
    if (f == NULL)  
    {
        printf("Error opening file!\n");
        exit(1);
    }    
    unsigned long eachTimes = 10; // test each vector dot product 10 times
    unsigned long dimRange  = 10000; // test dimension to 1000 
    
    for(unsigned long i = 1; i <= dimRange; i++ ){
        unsigned long long  total_cycle  = 0;
        for(unsigned long j = 1; j <= eachTimes; j++){
            
            data_t *u = create_vector_array(i);
            data_t *v = create_vector_array(i);
            data_t *dest = malloc(sizeof(data_t));
            *dest = 0;            
            total_cycle = total_cycle + (long)inner4( u, v, i, dest);
            free(u);
            free(v);
        }
        total_cycle = total_cycle/eachTimes;
        fprintf(f,"%lu %llu\n", i, total_cycle);
    }
    fclose(f);
    /*
    f = fopen("file_2.txt", "w");

    for(unsigned long i = 1; i <= dimRange; i++ ){
        unsigned long long  total_cycle  = 0;
        for(unsigned long j = 1; j <= eachTimes; j++){
            
            double *u = create_double_array(i);
            double *v = create_double_array(i);
            long cyc = 0;
            start_comp_counter();
            inner5( u, v, i);
            cyc = get_comp_counter();
            total_cycle = total_cycle + cyc;
            free(u);
            free(v);
        }
        total_cycle = total_cycle/eachTimes;
        printf("For %lu-Dimensional Vector Dot Product. Cycle = %llu\n", dimRange, total_cycle);
        printf("CPE = %f\n", (double)total_cycle/dimRange);
        fprintf(f,"%lu %llu\n", i, total_cycle);
    }    

    fclose(f);
    */

    return 0;
}
