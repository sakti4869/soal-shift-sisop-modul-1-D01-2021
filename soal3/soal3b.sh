#!/bin/bash

cd ~/soal-shift-sisop-modul-1-D01-2021/soal3:
bash ./soal3a.sh

download_date=$(date +"%d-%m-%Y")
mkdir "$download_date"

mv ./Koleksi_* "./$download_date/"
mv ./foto.log "./$download_date/"
