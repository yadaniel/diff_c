#!/usr/bin/bash

CFILE=${1:-nofile}


if [ ${CFILE} != "nofile" ]; then
    DIRNAME=$(dirname ${CFILE})
    BASENAME=$(basename ${CFILE})
    CH=${BASENAME##*.}
    TMP="${DIRNAME}/${BASENAME%%.*}"

    case ${CH} in
        c)
            cpp -fpreprocessed -dD -E ${CFILE} | grep -v "^# [[:digit:]]" > ${TMP}.c__ && ./_clang_fmt.py ${TMP}.c__ > ${TMP}.c_ && \
            # scc ${CFILE} > ${TMP}.c__ && ./_clang_fmt.py ${TMP}.c__ > ${TMP}.c_ && \
            astyle --suffix=none --style=java --pad-oper --add-brackets --indent=spaces=4 --convert-tabs ${TMP}.c_ && rm -f ${TMP}.c__
            ;;
        h)
            tabs 8
            cpp -fpreprocessed -dD -E ${CFILE} | grep -v "^# [[:digit:]]" > ${TMP}.h__ && ./_clang_fmt.py ${TMP}.h__ > ${TMP}.h_ && \
            # scc ${CFILE} > ${TMP}.h__ && ./_clang_fmt.py ${TMP}.h__ > ${TMP}.h_ && \
            astyle --suffix=none --style=java --pad-oper --add-brackets --indent=spaces=8 --convert-tabs ${TMP}.h_ && rm -f ${TMP}.h__
            ;;
        *)
            echo "file must be of type file.[c|h]"
            exit 2
            ;;

    esac
else
    echo "no file given"
    exit 1
fi

