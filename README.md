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
errorcount=`echo "$loglist" | grep -c "ERROR"`
```

**(c)** Ryujin juga harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap *user*-nya.

Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file csv.

**(d)** Semua informasi yang didapatkan pada poin **b** dituliskan ke dalam file `error_message.csv` dengan header **Error,Count** yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya **diurutkan** berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

Contoh:
```
Error,Count
Permission denied,5
File not found,3
Failed to connect to DB,2
```

Pertama kita membuat file error_message.csv dan mengisi baris pertamanya dengan header Error,Count.
```
echo "Error,Count" > error_message.csv
```

Lalu kita dapat menyimpan semua jenis error yang ada pada errorlist:

```
errortypes=`echo "$errorlist" | cut -d ' ' -f 2- | cut -d '(' -f 1 | sort | uniq`
```

Errortypes akan berisi semua jenis error yang ada pada file syslog.log
Selanjutnya, kita akan menghitung jumlah untuk masing - masing jenis error yang ada dan menambahkannya ke dalam file error_message.csv

```
errors='' # Untuk menyimpan pesan error dan jumlahnya

while read line
do
	# Hitung jumlah error untuk satu jenis error
	errorcount=`echo "$errorlist" | grep -c "$line"`

	# Tambahkan jenis error beserta jumlahnya ke dalam variabel errors
	errors=`printf "$errors\n$line,$errorcount"`
done <<< `printf "$errortypes"`

# Urutkan error berdasarkan jumlahnya dari yang paling banyak dan simpan dalam variabel output
output=`echo "$errors" | sort -t ',' -k 2 -n -r`

# Tambahkan isi dari variabel output ke dalam file error_message.csv
printf "$output\n" >> error_message.csv
```

**(e)** Semua informasi yang didapatkan pada poin **c** dituliskan ke dalam file `user_statistic.csv` dengan header **Username,INFO,ERROR** **diurutkan** berdasarkan username secara ***ascending***.

Contoh:

```
Username,INFO,ERROR
kaori02,6,0
kousei01,2,2
ryujin.1203,1,3
```

## Soal 2

Steven dan Manis mendirikan sebuah *startup* bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “*Laporan-TokoShiSop.tsv*”.

**a.** Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui **Row ID** dan **profit percentage terbesar** (jika hasil *profit percentage* terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari *profit percentage*, yaitu:

𝑃𝑟𝑜𝑓𝑖𝑡 𝑃𝑒𝑟𝑐𝑒𝑛𝑡𝑎𝑔𝑒 = (𝑃𝑟𝑜𝑓𝑖𝑡 ÷ 𝐶𝑜𝑠𝑡 𝑃𝑟𝑖𝑐𝑒) × 100

*Cost Price* didapatkan dari pengurangan *Sales* dengan *Profit*. (**Quantity diabaikan**).

**b.** Clemong memiliki rencana promosi di Albuquerque menggunakan metode MLM. Oleh karena itu, Clemong membutuhkan daftar **nama *customer* pada transaksi tahun 2017 di Albuquerque**.

**c.** TokoShiSop berfokus tiga _segment customer_, antara lain: _Home Office_, _Customer_, dan _Corporate_. Clemong ingin meningkatkan penjualan pada segmen _customer_ yang paling sedikit. Oleh karena itu, Clemong membutuhkan **segment _customer_** dan **jumlah transaksinya yang paling sedikit**.

**d.** TokoShiSop membagi wilayah bagian (_region_) penjualan menjadi empat bagian, antara lain: _Central_, _East_, _South_, dan _West_. Manis ingin mencari **wilayah bagian (region) yang memiliki total keuntungan (profit) paling sedikit** dan **total keuntungan wilayah tersebut**.

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
