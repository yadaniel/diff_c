#!/usr/bin/bash

rm -f _md5
touch _md5

CC=gcc

tmp=TMP

for i in $(find . -maxdepth 1 -iname "*.c"); do 
    echo $i

    cp ${i} ${tmp}.c
    ${CC} -c ${tmp}.c -o ${i}.o
    md5sum.exe ${i}.o >> _md5
    rm -f ${i}.o

    cp ${i}_ ${tmp}.c || (echo "no formatted cfiles found" && exit 1)
    ${CC} -c ${tmp}.c -o ${i}_.o
    md5sum.exe ${i}_.o >> _md5
    rm -f ${i}_.o

    echo "" >> _md5
    echo

done

rm -f ${tmp}.*

