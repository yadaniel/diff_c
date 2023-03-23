#!/usr/bin/bash

for CFILE in $(find . -iname "*.c"); do
    ./_clang_fmt.sh ${CFILE} 
done

for CFILE in $(find . -iname "*.h"); do
    ./_clang_fmt.sh ${CFILE} 
done

