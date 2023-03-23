#!/usr/bin/bash

echo "cleanup"
./_rm_clang.sh

echo "formating source files"
./_clang_fmt_all.sh

echo "stepping into prev"
echo "verify md5 checksums on source and formated files"
cd prev
../_mk_clang_checksum.sh
cd ..

echo "stepping into current"
echo "verify md5 checksums on source and formated files"
cd current
../_mk_clang_checksum.sh
cd ..

echo "compare md5 checksums and changes between prev and current"
echo "vim -d prev/file.c_ current/file.c_"
echo ""
echo " ***** PREV *****                                   ***** CURRENT *****"
paste ./prev/_md5 ./current/_md5


