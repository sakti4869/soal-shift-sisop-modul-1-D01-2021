#!/bin/bash
 
nokoleksi=1 
printf "" > Foto.log 
 
for i in {1..23}
do
    wget "https://loremflickr.com/320/240/kitten" -O download -a Foto.log 
 
    if [ $i -eq 1 ] 
    then
        mv download `printf "Koleksi_%02d" "$nokoleksi"` 
        nokoleksi=$(($nokoleksi+1)) 
    fi
 
    fileissame=0 
 
    for((j=1;j<nokoleksi;j=j+1)) 
    do
        if [ $i -eq 1 ]
        then
            break 
        fi
 
        filename=`printf "Koleksi_%02d" "$j"` 
 
        same=`cmp $filename download -b` 
        if [ -z "$same" ] 
        then
            fileissame=1 
            break
        else
            fileissame=0 
        fi
    done
 
    if [ $i -gt 1 ] 
    then
        if [ $fileissame -eq 1 ] 
        then
            rm download 
        else
            mv download `printf "Koleksi_%02d" "$nokoleksi"` 
            nokoleksi=$(($nokoleksi+1)) 
        fi
    fi
done
