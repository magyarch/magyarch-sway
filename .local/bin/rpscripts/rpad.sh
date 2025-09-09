#!/usr/bin/env bash

PAD=`ratpoison -c "set padding"`

if [ "$PAD" = "0 30 0 30" ]; then
    PAD="300 200 300 300"
else
    PAD="0 30 0 30"
fi

ratpoison -c "set padding ${PAD}"
