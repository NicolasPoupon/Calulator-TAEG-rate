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

NAME_BIN='./110borwein'

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
err '0 0' 'too much argv'
err '-2' 'n is negative'
err ':o' 'n is not a nb'
err '2.3' 'n is a float'
test '0' 'test subject'
test '1' 'n = 1'
test '2' 'n = 2'
test '6' 'n = 1000'
test '7' 'n = 7'
test '42' 'n = 42'
test '102' 'n = 102'
test '399' 'n = 399'
test '1001' 'n = 1001'

echo -e \
'__________________________________________________________________________\n\n'\
${BLUE}'  END OF THE TEST\t\t\t\t\t  '\
'RESULT:'${NC}' '$((finalres))'/'$((nb_test))'\n'\
'__________________________________________________________________________\n'
