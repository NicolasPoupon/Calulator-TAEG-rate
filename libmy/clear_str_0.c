/*
** EPITECH PROJECT, 2021
** clear_str_0.c
** File description:
** fill str of 0 or clear the first 0 of str
*/

#include "../include/my.h"

char *fill_str_of0(char *dest, char *src, int size)
{
    int i = 0;
    int len_src = my_strlen(src);
    int j = len_src;

    for (; i < size - len_src; i++)
        dest[i] = '0';
    dest[i] = '\0';
    my_strcat(dest, src);
    return (dest);
}

void clear_first0(char *str)
{
    int i = 0;
    int len = my_strlen(str);

    while (str[i] == '0')
        i++;
    my_revstr(str);
    str[len - i] = '\0';
    my_revstr(str);
}
