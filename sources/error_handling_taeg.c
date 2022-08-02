/*
** EPITECH PROJECT, 2021
** error_handling.c
** File description:
** error handling
*/

#include "../include/my.h"
#include "../include/p.h"
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

static int err_insurance_rate(void)
{
    dprintf(2, "Error with insurance rate (parameter 6), try calc_taeg -h\n");
    return EXIT_ERROR;
}

static int err_filing_and_brokerage_fees(void)
{
    dprintf(2, "Error with filing and brokerage fees (parameter 5), try calc_taeg -h\n");
    return EXIT_ERROR;
}

static int err_warranty_costs(void)
{
    dprintf(2, "Error with warranty costs (parameter 4), try calc_taeg -h\n");
    return EXIT_ERROR;
}

static int err_nominal_rate(void)
{
    dprintf(2, "Error with nominal rate (parameter 3), try calc_taeg -h\n");
    return EXIT_ERROR;
}

static int err_borrowing_period(void)
{
    dprintf(2, "Error with borrowing period (parameter 2), try calc_taeg -h\n");
    return EXIT_ERROR;
}

static int err_amount_borrowed(void)
{
    dprintf(2, "Error with amount borrowed (parameter 1), try calc_taeg -h\n");
    return EXIT_ERROR;
}

int error_handling(int ac, char **av)
{
    int (*ptrf_err[])() = {err_amount_borrowed, err_borrowing_period,
    err_nominal_rate, err_warranty_costs, err_filing_and_brokerage_fees,
    err_insurance_rate};

    if (ac != 7) {
        dprintf(2, "Error : should have 6 numbers, try calc_taeg -h\n");
        return EXIT_ERROR;
    }
    for (int i = 1; av[i] != NULL; i++) {
        if (my_str_isfloat(av[i]) == 0)
            return ptrf_err[i - 1]();
    }
    for (int i = 1; av[i] != NULL; i++) {
        if (av[i][0] == '-')
            printf("Care one or more parameters are negative !\n");
    }
    return 0;
}
