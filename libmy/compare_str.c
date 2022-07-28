/*
** EPITECH PROJECT, 2021
** compare_str.c
** File description:
** return 0 if str are the same and 1 if not
*/

#include "../include/my.h"

int compare_str(char *str1, char *str2)
{
    int i = 0;
    int j = 0;

    if (my_strlen(str1) != my_strlen(str2))
        return (1);
    while (str1[i] != '\0') {
        if (str1[i] == str2[i])
            j++;
        i++;
    }
    if (j == i)
        return (0);
    return (1);
}
