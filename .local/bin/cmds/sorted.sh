#!/bin/sh

for f in *.png ; do convert $f ${f%.png}.jpg ; done

sleep 1

rm *png

ls -v | cat -n | while read n f ; do mv -n $f $(printf "%04d" "$n.jpg") ; done
