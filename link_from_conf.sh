#!/usr/bin/env bash

if which gln >/dev/null; then
    LN=gln
elif ln --version | grep 'GNU' > /dev/null; then
    LN=ln
else
    echo 'GNU ln not installed'
    exit 1
fi

i=0
while read LINE; do
    #i=$(($i + 1))
    #echo
    #echo "i=$i"
    #echo "LINE=$LINE"
    if [[ "${LINE%%\#*}" == "" ]]; then
        echo "skip"
        continue
    fi
    CMD=$(echo $LINE | awk -F',' '{gsub("\\ ", " "); STR=$1; gsub(" ", "\\ "); printf("DST=`readlink %s`; [ \"$DST\" != \"%s\" ] && '"$LN"' -vsn --backup=t %s %s; ls -L %s >/dev/null || echo '"$i"'\n", $2, STR, $1, $2, $2)}')
    #echo $CMD
    eval $CMD
done < install.conf.csv
