#! /bin/sh/

function zipping() {
   current=$(date "+%d%m%Y")
   zip -P $current -r Koleksi.zip Koleksi/
   rm -rf Koleksi/
}

function unzipping() {
   current=$(date "+%d%m%Y")
   unzip -P $current Koleksi.zip
   rm -f Koleksi.zip
}
