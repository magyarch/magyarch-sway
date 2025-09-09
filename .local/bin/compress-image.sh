#!/usr/bin/env bash
for f in "$@"; do
  /run/current-system/sw/bin/convert "$f" -strip -quality 85 "${f%.*}_compressed.${f##*.}"
done

