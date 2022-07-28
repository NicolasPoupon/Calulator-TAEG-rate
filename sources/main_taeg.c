/*
** EPITECH PROJECT, 2021
** main_taeg.c
** File description:
** main taeg
*/

#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include "../include/my.h"
#include "../include/p.h"

static int print_usage_h(void)
{
    printf("USAGE\n    ./calc_taeg A P N WC F I\n\nDESCRIPTION\n"
    "Calculates TAEG rate, each parameter must be a single or floating point number\n"
    "\tA\tamount borrowed\n"
    "\tP\tborrowing period (months)\n"
    "\tN\tnominal rate\n"
    "\tWC\twarranty costs\n"
    "\tF\tfiling and brokerage fees\n"
    "\tI\tinsurance rate\n\n");

    return EXIT_SUCCESS;
}

int main(int ac, char **av)
{
    if (ac == 2 && compare_str("-h", av[1]) == 0)
        return print_usage_h();
    if (error_handling(ac, av) == EXIT_ERROR)
        return (84);
    return (taeg(av));
}
