# soal-shift-sisop-modul-1-D01-2021
Khaela Fortunela 05111940000057

M Haikal Aria Sakti 05111940000088

David Ralphwaldo M 05111940000190

## Soal 1
Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, *ticky*. Terdapat 2 laporan yang harus dia buat, yaitu laporan **daftar peringkat pesan error** terbanyak yang dibuat oleh *ticky* dan laporan **penggunaan user** pada aplikasi *ticky*. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

**(a)** Mengumpulkan informasi dari log aplikasi yang terdapat pada file `syslog.log`. Informasi yang diperlukan antara lain: jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.

Untuk mendapatkan jenis log, pesan log, dan username pada setiap baris log, kita dapat menjalankan perintah:
```
loglist=`cat syslog.log | cut -d ':' -f 4 | cut -d ' ' -f 2-`
errorlist=`echo "$loglist" | grep "ERROR"`
infolist=`echo "$loglist" | grep "INFO"`
```

loglist akan berisi semua log pesan error dan info beserta dengan isi pesan dan usernamenya, errorlist hanya akan berisi semua log pesan error, isi pesan, dan usernamenya, dan infolist hanya akan berisi semua log pesan info, isi pesannya, dan usernamenya.

**(b)** Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

Untuk menghitung jumlah pesan error yang ada, kita dapat mengeksekusi perintah:
```
errortypes=`echo "$errorlist" | cut -d ' ' -f 2- | cut -d '(' -f 1 | sort | uniq`
errors=''

while read line
do
	errorcount=`echo "$errorlist" | grep -c "$line"`
	errors=`printf "$errors\n$line,$errorcount"`
done <<< `printf "$errortypes"`

errors=`echo "$errors" | sort -t ',' -k 2 -n -r` # Urutkan error berdasarkan jumlahnya
```
Errortypes akan menyimpan semua jenis error yang terdapat pada file syslog.log. Kemudian jenis - jenis error tersebut akan diurutkan dan kemudian perintah uniq akan menghapus semua duplikat jenis error yang ada.

Setelah itu, kita menghitung jumlah error untuk setiap jenis error yang ada dan jumlahnya disimpan dalam variabel errorcount. Kemudian kita akan menyimpan pesan error beserta dengan jumlahnya ke dalam variabel errors. Variabel errors kemudian diurutkan sesuai dengan jumlah error masing - masing jenis error mulai dari jumlah error yang paling banyak.

**(c)** Ryujin juga harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap *user*-nya.

Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file csv.

Pertama kita dapat mencari semua username dan mengurutkannya dengan menjalankan perintah:
```
userlist=`echo "$loglist" | cut -d '(' -f 2 | cut -d ')' -f 1 | sort | uniq`
```
Semua username yang ada akan disimpan dalam userlist, diurutkan, dan tidak ada duplikat.
Setelah itu, kita dapat menghitung jumlah pesan info dan error untuk masing - masing user dengan mengeksekusi perintah berikut:
```
userstat=''

while read line
do
	usererrorcount=`echo "$errorlist" | grep "$line" | grep -c "ERROR"`
	userinfocount=`echo "$infolist" | grep "$line" | grep -c "INFO"`

	currentuserstat=`printf "$line,$userinfocount,$usererrorcount\n"`
	userstat=`printf "$userstat\n$currentuserstat"`
done <<< `printf "$userlist"`
```

Variabel userstat digunakan untuk menyimpan semua username dengan jumlah pesan info dan errornya masing - masing, dan sudah diurutkan berdasarkan usernamenya.

**(d)** Semua informasi yang didapatkan pada poin **b** dituliskan ke dalam file `error_message.csv` dengan header **Error,Count** yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya **diurutkan** berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

Contoh:
```
Error,Count
Permission denied,5
File not found,3
Failed to connect to DB,2
```

Untuk menyimpan jenis - jenis error yang ada beserta dengan jumlah errornya kita dapat mengeksekusi perintah:
```
echo "Error,Count" > error_message.csv # Header dari file error_message.csv
printf "$errors\n" >> error_message.csv # Semua jenis error dengan jumlahnya masing - masing
```

**(e)** Semua informasi yang didapatkan pada poin **c** dituliskan ke dalam file `user_statistic.csv` dengan header **Username,INFO,ERROR** **diurutkan** berdasarkan username secara ***ascending***.

Contoh:

```
Username,INFO,ERROR
kaori02,6,0
kousei01,2,2
ryujin.1203,1,3
```

Pertama kita membuat file user_statistic.csv dan mengisi baris pertama dengan header Username,INFO,ERROR.
```
printf "Username,INFO,ERROR" > user_statistic.csv
```
Kemudian kita tambahkan semua username, beserta dengan jumlah info dan errornya masing - masing yang sudah diurutkan berdasarkan usernamenya dengan menjalankan perintah:
```
printf "$userstat\n" >> user_statistic.csv
```

## Soal 2

Steven dan Manis mendirikan sebuah *startup* bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “*Laporan-TokoShiSop.tsv*”.

**a.** Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui **Row ID** dan **profit percentage terbesar** (jika hasil *profit percentage* terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari *profit percentage*, yaitu:

𝑃𝑟𝑜𝑓𝑖𝑡 𝑃𝑒𝑟𝑐𝑒𝑛𝑡𝑎𝑔𝑒 = (𝑃𝑟𝑜𝑓𝑖𝑡 ÷ 𝐶𝑜𝑠𝑡 𝑃𝑟𝑖𝑐𝑒) × 100

*Cost Price* didapatkan dari pengurangan *Sales* dengan *Profit*. (**Quantity diabaikan**).

Pertama kita simpan semua ID transaksi beserta dengan profit percentagenya masing - masing kemudian kita urutkan dari transaksi yang memiliki profit percentage yang paling besar.
```
profitlist=`awk -F '	' 'NR > 1 { print $1, ($21 / ($18 - $21)) * 100 }' Laporan-TokoShiSop.tsv | sort -k 2 -n -r`
```
Kemudian kita ambil baris pertama dari variabel profitlist yang berisi ID transaksi dan profit percentage yang paling besar.
```
profitline1=`echo "$profitlist" | grep "" -m 1`
```
Setelah itu, kita simpan row ID dan profit percentagenya ke dalam variabel rowid dan profitpercent.
```
rowid=`echo "$profitline1" | cut -d ' ' -f 1`
profitpercent=`echo "$profitline1" | cut -d ' ' -f 2`
```

**b.** Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar **nama *customer* pada transaksi tahun 2017 di Albuquerque**.

Untuk mencari nama - nama customer yang berasal dari kota Albuquerque dan melakukan transaksi pada tahun 2017, kita dapat mengeksekusi perintah:
```
namacustomer=`awk -F '	' '/2017/ && NR > 1 && $10 == "Albuquerque" { print $7 }' Laporan-TokoShiSop.tsv | sort | uniq`
```
Nama - nama customer yang berasal dari Albuquerque diurutkan, dihapus jika ada duplikatnya, dan disimpan dalam variabel namacustomer.

**c.** TokoShiSop berfokus tiga _segment customer_, antara lain: _Home Office_, _Customer_, dan _Corporate_. Clemong ingin meningkatkan penjualan pada segmen _customer_ yang paling sedikit. Oleh karena itu, Clemong membutuhkan **segment _customer_** dan **jumlah transaksinya yang paling sedikit**.

Untuk mencari semua segmen yang ada, kita dapat menjalankan perintah:
```
segmenlist=`awk -F '	' 'NR > 1 { print $8 }' Laporan-TokoShiSop.tsv | sort | uniq`
```

Setelah itu, untuk mencari segmen yang memiliki jumlah transaksi paling sedikit, kita menjalankan perintah - perintah berikut:
```
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
```
Total digunakan untuk menyimpan jumlah transaksi dari tiap segmen. Setelah itu variabel total dibandingkan dengan variabel totaltransaksi untuk mencari jumlah transaksi yang paling sedikit.
Variabel tipesegmen digunakan untuk menyimpan nama dari segmen dengan jumlah transaksi paling sedikit, dan variabel totaltransaksi digunakan untuk menyimpan jumlah transaksi pada segmen tersebut.

**d.** TokoShiSop membagi wilayah bagian (_region_) penjualan menjadi empat bagian, antara lain: _Central_, _East_, _South_, dan _West_. Manis ingin mencari **wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit** dan **total keuntungan wilayah tersebut**.

Pertama kita menyimpan nama setiap region dengan menjalankan perintah:
```
listregion=`awk -F '	' 'NR > 1 { print $13 }' Laporan-TokoShiSop.tsv | sort | uniq`
```

Lalu kita jumlahkan semua profit untuk transaksi pada region tersebut dengan mengeksekusi perintah - perintah berikut:
```
regionkeuntungan='' # Untuk menyimpan nama region dengan total profit paling sedikit
totalkeuntungan=1000000 # Untuk menyimpan total profit yang paling sedikit

while read line
do
	# Mencari total profit dari semua transaksi pada suatu region
	profitregion=`grep "$line" Laporan-TokoShiSop.tsv | awk -F '	' '{totalprofit+=$21} END {print totalprofit}'`

	# Jika profitregion kurang dari totalkeuntungan, perbarui totalkeuntungan dan nama region
	if [ $profitregion -lt $totalkeuntungan ]
	then
		regionkeuntungan="$line"
		totalkeuntungan="$profitregion"
	fi
done <<< `printf "$listregion"`
```

Agar mudah dibaca oleh Manis, Clemong, dan Steven,

**e.** kamu diharapkan bisa membuat sebuah script yang akan menghasilkan file “hasil.txt” yang memiliki format sebagai berikut:

```
Transaksi terakhir dengan profit percentage terbesar yaitu *ID Transaksi* dengan persentase *Profit Percentage*%.

Daftar nama customer di Albuquerque pada tahun 2017 antara lain:
*Nama Customer1*
*Nama Customer2* dst

Tipe segmen customer yang penjualannya paling sedikit adalah *Tipe Segment* dengan *Total Transaksi* transaksi.

Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah *Nama Region* dengan total keuntungan *Total Keuntungan (Profit)*
```

Untuk menyimpan semua informasi yang sudah diperoleh, kita dapat menjalankan perintah - perintah berikut:
```
printf "Transaksi terakhir dengan profit percentage terbesar yaitu $rowid dengan persentase $profitpercent%%\n\n" > hasil.txt
printf "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n" >> hasil.txt
printf "$namacustomer\n" >> hasil.txt
printf "\nTipe segmen customer yang penjualannya paling sedikit adalah $tipesegmen dengan $totaltransaksi transaksi.\n\n" >> hasil.txt
printf "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah $namaregion dengan total keuntungan $totalkeuntungan\n" >> hasil.txt
```
