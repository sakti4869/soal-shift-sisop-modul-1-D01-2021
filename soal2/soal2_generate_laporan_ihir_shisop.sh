#!/bin/bash

##### Nomor A #####

# Simpan jumlah profit percentage untuk setiap transaksi dan urutkan dari profit yang terbesar
profitlist=`awk -F '	' 'NR > 1 { print $1, ($21 / ($18 - $21)) * 100 }' Laporan-TokoShiSop.tsv | sort -k 2 -n -r`

# Hanya ambil baris pertama dari profitlist yang berisi transaksi dengan profit terbesar
profitline1=`echo "$profitlist" | grep "" -m 1`

# Simpan row ID dan profit percentage
rowid=`echo "$profitline1" | cut -d ' ' -f 1`
profitpercent=`echo "$profitline1" | cut -d ' ' -f 2`

##### Nomor B #####

# Simpan semua nama customer yang tinggal di Albuquerque dan melakukan transaksi pada tahun 2017, dan urutkan
namacustomer=`awk -F '	' '/2017/ && NR > 1 && $10 == "Albuquerque" { print $7 }' Laporan-TokoShiSop.tsv | sort | uniq`

##### Nomor C #####

# Simpan semua jenis segmen dan urutkan
segmenlist=`awk -F '	' 'NR > 1 { print $8 }' Laporan-TokoShiSop.tsv | sort | uniq`

# Untuk menyimpan nama segmen dan total transaksi yang paling sedikit
tipesegmen=""
totaltransaksi=10000

while read line
do
	# Cek total transaksi untuk segmen
	total=`cat Laporan-TokoShiSop.tsv | grep -c "$line"`

	# Jika total transaksi segmen ini lebih sedikit dari yang sebelumnya, update jumlah transaksi paling sedikit
	if [ $total -lt $totaltransaksi ]
	then
		totaltransaksi=$total
		tipesegmen=$line # Simpan nama segmennya
	fi
done <<< `echo "$segmenlist"`

##### Nomor D #####

# Simpan semua nama region
listregion=`awk -F '	' 'NR > 1 { print $13 }' Laporan-TokoShiSop.tsv | sort | uniq`

regionkeuntungan=''
totalkeuntungan=1000000

while read line
do
	profitregion=`grep "$line" Laporan-TokoShiSop.tsv | awk -F '	' '{totalprofit+=$21} END {print totalprofit}'`

	if [ $profitregion -lt $totalkeuntungan ]
	then
		regionkeuntungan="$line"
		totalkeuntungan="$profitregion"
	fi
done <<< `printf "$listregion"`

##### Nomor E #####

# Output semua data yang sudah didapatkan ke dalam file hasil.txt
printf "Transaksi terakhir dengan profit percentage terbesar yaitu $rowid dengan persentase $profitpercent%%\n\n" > hasil.txt
printf "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n" >> hasil.txt
printf "$namacustomer\n" >> hasil.txt
printf "\nTipe segmen customer yang penjualannya paling sedikit adalah $tipesegmen dengan $totaltransaksi transaksi.\n\n" >> hasil.txt
printf "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah $namaregion dengan total keuntungan $totalkeuntungan\n" >> hasil.txt
