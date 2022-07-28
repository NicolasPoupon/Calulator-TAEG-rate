##
## EPITECH PROJECT, 2022
## Makefile
## File description:
## compile project with libmy
##

SRC	=	sources/main_taeg.c	\
		sources/taeg.c	\
		sources/error_handling_taeg.c	\

OBJ	=	$(SRC:.c=.o)

NAME	=	calc_taeg

CPPFLAGS	=	-I./include/

LDFLAGS	=	-L ./libmy -lmy

CFLAGS	=	-Wall -Wextra

all:    $(NAME)

$(NAME):	$(OBJ)
	make -C libmy
	$(CC) $(OBJ) $(LDFLAGS) -o $(NAME) -lm

clean:
	$(RM) $(OBJ)
	make clean -C libmy

fclean:	clean
	$(RM) $(NAME)
	make fclean -C libmy

re:	fclean all

tests_run:
	make
	./tests/mytest.sh

debug:	CFLAGS += -g3
debug:	all

.PHONY : all clean fclean re tests_run
