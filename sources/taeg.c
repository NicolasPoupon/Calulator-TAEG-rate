 /*
** EPITECH PROJECT, 2021
** trigo.c
** File description:
** 108trigo
*/

#include "../include/my.h"
#include "../include/p.h"
#include <stdio.h>
#include <math.h>
#include <unistd.h>
#include <stdlib.h>

static struct param *init_param(char **av)
{
    struct param *p = malloc(sizeof(struct param));

    if (p == NULL) {
        dprintf(2, "Malloc error init_param");
        return NULL;
    }
    p->A = atof(av[1]);
    p->P = atof(av[2]);
    p->N = atof(av[3]);
    p->WC = atof(av[4]);
    p->F = atof(av[5]);
    p->I = atof(av[6]);
    p->insurance_costs = (double) 0;
    p->monthly_payments = (double) 0;
    p->amount_of_interest = (double) 0;
    p->taeg = (double) 0;

    return p;
}

static void calc_amount_of_interest(struct param *p)
{
    p->amount_of_interest = p->P * p->monthly_payments - p->A + p->WC + p->F;
}

static void calc_monthly_payments(struct param *p)
{
    double rate = p->N / 100 / 12;

    p->monthly_payments = p->A * rate / (1 - pow(1 + rate, -p->P));
}

static void calc_insurance_costs(struct param *p)
{
    p->insurance_costs = p->I / 100 * p->A * p->P / 12;
}

static int calc_taeg(struct param *p)
{
    double total_cost = p->insurance_costs + p->amount_of_interest + p->WC + p->F;
    double buff_cost = 0;
    double min = 0;
    double max = 10;

    for (int i = 0; i != 50; i++) {
        p->N = (max + min) / 2;
        calc_monthly_payments(p);
        calc_amount_of_interest(p);
        buff_cost = p->amount_of_interest;
        if (total_cost < buff_cost)
            max = (min + max) / 2;
        else
            min = (min + max) / 2;
    }
    p->taeg = p->N;
    if (p->taeg >= (double) 9.9 || p->taeg <= (double) 0.01) {
        printf("TAEG should be > 0 and < 10, the parameters should be wrong!\n\n");
        return EXIT_ERROR;
    }
    printf("\tTAEG :\t%.2f%%\n\n", p->taeg);
    return 0;

}

int taeg(char **av)
{
    struct param *p = init_param(av);

    if (p == NULL)
        return EXIT_ERROR;

    calc_insurance_costs(p);
    printf("\n\tinsurance cost  \t:\t%.2f\n", p->insurance_costs);
    calc_monthly_payments(p);
    printf("\tmonthly payments\t:\t%.2f\n", p->monthly_payments);
    calc_amount_of_interest(p);
    printf("\tamont of interest\t:\t%.2f\n\n", p->amount_of_interest);
    if (calc_taeg(p) == EXIT_ERROR)
        return EXIT_ERROR;
    free(p);
    return EXIT_SUCCESS;
}

