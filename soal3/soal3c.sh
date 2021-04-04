#! /bin/sh/

function kitten() {
   cd Koleksi
   mkdir $(date "+ Kucing_%d-%m-%Y")
   cd $(date "+ Kucing_%d-%m-%Y")
   wget -O $(date "+ Kucing_%d-%m-%Y_%H:%M:%S") https://loremflickr.com/320/240/kucing
   cd
}

function bunny() {
   cd Koleksi
   mkdir $(date "+ Kelinci_%d-%m-%Y")
   cd $(date "+ Kelinci_%d-%m-%Y")
   wget -O $(date "+ Kelinci_%d-%m-%Y_%H:%M:%S") https://loremflickr.com/320/240/bunny
   cd
}
