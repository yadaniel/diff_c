#!/usr/bin/bash

#find . -regextype awk -iregex ".*\.[ch]_" -exec rm {} \;

rm -f ./current/*.c_ ./current/*.h_ ./current/_md5
rm -f ./prev/*.c_ ./prev/*.h_ ./prev/_md5

