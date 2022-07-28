/*
** EPITECH PROJECT, 2021
** p.h
** File description:
** prototypes fct
*/

#ifndef _P_H
    #define _P_H

    #define EXIT_SUCESS 0
    #define EXIT_ERROR 84

struct param {
    double A;
    double P;
    double N;
    double WC;
    double F;
    double I;
    double insurance_costs;
    double monthly_payments;
    double amount_of_interest;
    double taeg;
};

// error_handling_borwein
int error_handling(int ac, char **av);
void my_puterr(char *str);

// borwein
int taeg(char **av);

#endif
