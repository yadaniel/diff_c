#!/usr/bin/bash

find . -regextype awk -iregex ".*\.[ch]_" -exec rm {} \;

