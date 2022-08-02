#!/bin/bash

L='________________________________________________________________________\n'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORAN='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GREY='\033[0;37m'
NC='\033[0m'

declare -i finalres;
declare -i nb_test;
declare -i nb_test_diff;
finalres=0;
PATH_SOL='tests/solutions/sol_'
PATH_RES='tests/results/res_'

NAME_BIN='./calc_taeg'

echo -e ' '$L\
' |\t\t\t\t\t\t\t\t\t|\n'\
' |\t\t\t     '${GREY}'FUNCTIONNAL-TESTS'${NC}'\t\t\t\t|\n'\
' |\t\t\t\t\t\t\t\t\t|\n'\
' |\t\t\t\t'${PURPLE} $NAME_BIN ${NC}'\t\t\t\t|\n'\
' |______________________________________________________________________|'\
'\n\n' $L

test() {
echo '__________________________________________________________________________'
    ((nb_test++))
    ((nb_test_diff++))

    $NAME_BIN $1 > $PATH_RES$((nb_test_diff))
    diff -q $PATH_SOL$((nb_test_diff)) $PATH_RES$((nb_test_diff)) > /dev/null
    res=$?

    if [ $res == 1 ]
    then
        echo -e ${CYAN}'\n  '$2 ${NC}'\t:'${RED}' fail\n'${NC}
    elif [ $res == 0 ]
    then
        echo -e ${CYAN}'\n  '$2 ${NC}'\t:'${GREEN}' sucess\n'${NC}
        ((finalres++))
    else
        echo -e '\nerror with diff command test\n' $4
    fi
}

err() {
echo '__________________________________________________________________________'
    ((nb_test++))
    $NAME_BIN $1 2> /dev/null 1> /dev/null
    res=$?

    if [ $res == 84 ]
    then
        echo -e ${ORAN}'\n  '$2${NC}'\t:' ${GREEN}'sucess\n' ${NC}
        ((finalres++))
    elif [ $res == 0 ]
    then
        echo -e ${ORAN}'\n  '$2${NC}'\t:'  ${RED}'fail\n' ${NC}
    fi
}

# 'argv' 'name of the test'
err '' 'no argv'
err '1 2 3 4 5 6 7' 'too much argv'
err '1 2 3 4 5 a' 'incorrect nb'
err '1000 120 10.2 1250 400 0.2' 'TAEG <= 0 or >= 10'
test '300000 240 1.7 1500 500 0.3' 'test subject'
test '500000 120 1.2 1250 400 0.2' 'test n°2'
test '100000 72 1.5 800 600 0.4' 'test n°3'
test '1000000 300 1.3 2000 800 0.25' 'test n°4'

echo -e \
'__________________________________________________________________________\n\n'\
${BLUE}'  END OF THE TEST\t\t\t\t\t  '\
'RESULT:'${NC}' '$((finalres))'/'$((nb_test))'\n'\
'__________________________________________________________________________\n'
