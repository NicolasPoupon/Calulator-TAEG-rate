#!/bin/bash

declare -i finalres;
finalres=0;
RED='\033[0;31m'
GREEN='\033[0;32m'
ORAN='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GREY='\033[0;37m'
NC='\033[0m'

echo '_______________________________________________________________________'
echo '                                                                      |'
echo -e ${GREY}\
     '                           FUNCTIONNAL-TESTS'${NC}\
     '                        |'
echo '                                                                      |'
echo -e ${PURPLE}\
     '                                lemin    '${NC}\
     '                           |'
echo '______________________________________________________________________|'
echo ''

echo '_______________________________________________________________________'


test() {
echo '_______________________________________________________________________'

    $1 < $5 > $3
    diff -q $2 $3 > /dev/null
    res=$?

    if [ $res == 1 ]
    then
        echo ''
        echo -e ${CYAN}'  '$4 ${NC}'\t:'${RED}' fail'${NC}
        echo ''
    elif [ $res == 0 ]
    then
        echo ''
        echo -e ${CYAN}'  '$4 ${NC}'\t:'${GREEN}' sucess'${NC}
        echo ''
        ((finalres++))
    else
        echo ''
        echo ' error with diff command test' $4
        echo ''
    fi
}

err() {
echo '_______________________________________________________________________'

    $1 < $3 2> /dev/null 1> /dev/null
    res=$?

    if [ $res == 84 ]
    then
        echo ''
        echo -e ${ORAN}'  '$2${NC}'\t:' ${GREEN}'sucess' ${NC}
        echo ''
        ((finalres++))
    elif [ $res == 0 ]
    then
        echo ''
        echo $3
        echo -e ${ORAN}'  '$2${NC}'\t:'  ${RED}'fail' ${NC}
        echo ''
    fi
}

test './lem_in' 'tests/solution/s1' 'tests/res/r1' 'test sub 1' 'tests/input/i1'
test './lem_in' 'tests/solution/s2' 'tests/res/r2' 'test sub 2' 'tests/input/i2'
test './lem_in' 'tests/solution/s3' 'tests/res/r3' 'just nb ant' 'tests/input/i3'
test './lem_in' 'tests/solution/s4' 'tests/res/r4' 'clean map' 'tests/input/i4'
err './lem_in' 'jump line' 'tests/input/i5'
err './lem_in' 'no start' 'tests/input/i6'
err './lem_in' 'no end' 'tests/input/i7'
err './lem_in' 'wrong link' 'tests/input/i8'
err './lem_in' 'no link start' 'tests/input/i9'
err './lem_in' 'no link end' 'tests/input/i10'

echo '_______________________________________________________________________'
echo ''
echo -e ${BLUE}' END OF THE TEST                            ' ${BLUE}\
     '              RESULT:'${NC}'' $((finalres))'/10'
echo '_______________________________________________________________________'
echo ''
