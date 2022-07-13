#!/bin/sh

sizes=( 40 60 58 87 80 120 180 20 29 58 76 152 167 1024 )

for size in "${sizes[@]}"
do
    sips -z $size $size $1 --out "icon${size}x${size}.jpg"
done
