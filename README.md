# soal-shift-sisop-modul-1-D01-2021
- [Daftar Isi]
   - [Anggota Kelompok]
   - [Soal 1] (#soal_1)
   - [Soal 2]
   - [Soal 3]
      - [3a]
      - [3b]
      - [3c]
      - [3d]
      - [3e]

Khaela Fortunela 05111940000057

M Haikal Aria Sakti 05111940000088

David Ralphwaldo M 05111940000190

## Soal 1 ##
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
<<<<<<< main

Pertama kita membuat file user_statistic.csv dan mengisi baris pertama dengan header Username,INFO,ERROR.
```
printf "Username,INFO,ERROR" > user_statistic.csv
```
Kemudian kita tambahkan semua username, beserta dengan jumlah info dan errornya masing - masing yang sudah diurutkan berdasarkan usernamenya dengan menjalankan perintah:
```
printf "$userstat\n" >> user_statistic.csv
```

=======
>>>>>>> main
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

<<<<<<< main
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
=======
## Soal 3
Kuuhaku adalah orang yang sangat suka mengoleksi foto-foto digital, namun Kuuhaku juga merupakan seorang yang pemalas sehingga ia tidak ingin repot-repot mencari foto, selain itu ia juga seorang pemalu, sehingga ia tidak ingin ada orang yang melihat koleksinya tersebut, sayangnya ia memiliki teman bernama Steven yang memiliki rasa kepo yang luar biasa. Kuuhaku pun memiliki ide agar Steven tidak bisa melihat koleksinya, serta untuk mempermudah hidupnya, yaitu dengan meminta bantuan kalian. Idenya adalah :

a. Membuat script untuk mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten" serta menyimpan log-nya ke file "Foto.log". Karena gambar yang diunduh acak, ada kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus menghapus gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian menyimpan gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan tanpa ada nomor yang hilang (contoh : Koleksi_01, Koleksi_02, ...)

Pertama kita buat nama file gambar yang akan didownload dan buat file Foto.log yang kosong
 ```
nokoleksi=1 
printf "" > Foto.log 
``` 
Buat loop for berisi 23 iterasi ,yang didalamnya kita akan mendownload file foto lalu menyimpan infonya di Foto.log
``` 
for i in {1..23}
do
    wget "https://loremflickr.com/320/240/kitten" -O download -a Foto.log 
``` 
Kalau file yang pertama kali didownload tidak perlu di cek dan segera di download dan direname
``` 
    if [ $i -eq 1 ] 
    then
        mv download `printf "Koleksi_%02d" "$nokoleksi"` 
        nokoleksi=$(($nokoleksi+1)) 
    fi
``` 
Berikut adalah cara untuk menghilangkan kemungkinan file yang sama akan didownload. Dengan menggunakan loop for yang didalamnya loop if yang mengecek apakah sama atau tidak dengan memakai value fileissame.
``` 
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
   ``` 
Dan terakhir jika sudah dicek sama atau tidak memakai loop if berikut kita akan mengecek apakah file nya yang pertama atau file dengan nama yang sama kalau tidak maka akan diberi nama sesuai dengan perintah yaitu Koleksi_XX
``` 
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
```
b. Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut sehari sekali pada jam 8 malam untuk tanggal-tanggal tertentu setiap bulan, yaitu dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta log-nya, dipindahkan ke folder dengan nama tanggal unduhnya dengan format "DD-MM-YYYY" (contoh : "13-03-2023").

Memakai kode dari soal3a lalu membuat direktori yang menunjukkan ke nama folder yang dinginkan yaitu tanggal unduh kemudian memindahkan file yang telah didownload ke folder itu
```
#!/bin/bash

cd ~/soal-shift-sisop-modul-1-D01-2021/soal3:
bash ./soal3a.sh
download_date=$(date +"%d-%m-%Y")
mkdir "$download_date"

mv ./Koleksi_* "./$download_date/"
mv ./foto.log "./$download_date/"
```
c. Agar kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk mengunduh gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara bergantian (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, nama folder diberi awalan "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023").

Pertama, kita bisa tentukan sebuah direktori untuk menyimpan folder-folder tersebut. Misal, kita bisa buat sebuah direktori di /home/[username] bernama Koleksi.
```
$ mkdir Koleksi
$ cd Koleksi
```
Kemudian, kita buat direktori untuk foto yang akan diunduh dengan format "Kucing_tanggal-bulan-tahun"
```
$ mkdir $(date "+ Kucing_%d-%m-%Y")
```
Selanjutnya, kita masuk ke direktori tersebut dan mendownload foto kucing dari "https://loremflickr.com/320/240/kitten".
```
$ wget https://loremflickr.com/320/240/kitten
```
Kemudian untuk meng-otomatis-kan semua perintah itu, kita taruh di file soal3c.sh.
```
#! /bin/sh/

cd Koleksi
mkdir $(date "+ Kucing_%d-%m-%Y")
cd $(date "+ Kucing_%d-%m-%Y")
wget https://loremflickr.com/320/240/kitten
cd
```
Karena kita juga harus melakukan hal yang sama untuk kelinci, maka kita buat 2 fungsi didalam soal3c.sh.
```
#! /bin/sh/

function kitten() {
   cd Koleksi
   mkdir $(date "+ Kucing_%d-%m-%Y")
   cd $(date "+ Kucing_%d-%m-%Y")
   wget https://loremflickr.com/320/240/kitten
   cd
}

function bunny() {
   cd Koleksi
   mkdir $(date "+ Kelinci_%d-%m-%Y")
   cd $(date "+ Kelinci_%d-%m-%Y")
   wget https://loremflickr.com/320/240/bunny
   cd
}
```
Untuk mengunduh file kucing, kita bisa memanggil fungsinya menggunakan command ```source``` seperti berikut.
```
$ source soal3c.sh; kitten
```
Kemudian, karena kita harus meng-otomatis-kan pengunduhan file kucing dan kelinci dengan hari yang berselang-seling, maka kita tambahkan perintah berikut ini ke crontab.
```
0 0 1-31/2 * * source soal3c.sh; bunny
0 0 2-31/2 * * source soal3c.sh; kitten
```
Maka fungsi akan tereksekusi tiap pukul 00:00, untuk ```bunny``` pada tanggal ganjil, dan untuk ```kitten``` pada tanggal genap.

d. Untuk mengamankan koleksi Foto dari Steven, Kuuhaku memintamu untuk membuat script yang akan memindahkan seluruh folder ke zip yang diberi nama “Koleksi.zip” dan mengunci zip tersebut dengan password berupa tanggal saat ini dengan format "MMDDYYYY" (contoh : “03032003”).

Untuk meng-zip folder ````Koleksi/```` menggunakan password berupa ```tanggalbulantahun``` maka kita bisa gunakan command berikut.
```
$ current=$(date "+%d%m%Y")
$ zip -P $current -r Koleksi.zip Koleksi/
```
```-P``` digunakan untuk menambahkan password pada zip, berupa ```current``` yang isinya adalah tanggal hari itu.
```-r``` atau ```--recursive``` digunakan agar proses zip dilakukan secara rekursif, sehingga semua subfolder dalam ```Koleksi/``` bisa masuk ke zip.

Hasil dari proses adalah "Koleksi.zip" yang berada di direktori ```/home/[username]/```. Kode diatas kemudian disimpan ke file ```soal3d.sh```.
```
#! /bin/sh/

current=$(date "+%d%m%Y")
zip -P $current -r Koleksi.zip Koleksi/
```

e. Karena kuuhaku hanya bertemu Steven pada saat kuliah saja, yaitu setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya ter-zip saat kuliah saja, selain dari waktu yang disebutkan, ia ingin koleksinya ter-unzip dan tidak ada file zip sama sekali.

Berdasarkan deskripsi diatas, maka pada jam 7 pagi untuk senin sampai jum'at, folder ```Koleksi/``` di-zip, kemudian folder aslinya dihapus. Maka di file ```soal3d.sh```, kita tambahkan fungsi untuk menghapus direktori ```Koleksi/``` setelah proses zip selesai.
```
#! /bin/sh/

current=$(date "+%d%m%Y")
zip -P $current -r Koleksi.zip Koleksi/
rm -rf Koleksi/
```
```rm``` berasal dari kata "remove", adalah perintah yang digunakan untuk menghapus file atau direktori.
```-r``` digunakan untuk melakukan rekursi, sehingga semua subfolder didalam ```Koleksi/``` juga terhapus.
```-f``` atau ```--force``` digunakan agar file atau folder dapat terhapus tanpa menimbulkan prompt.

Selanjutnya, berdasarkan deskripsi soal pada pukul 18, hari senin sampai kamis, kita harus meng-unzip "Koleksi.zip" dan kemudian menghapusnya. Berikut adalah perintah untuk meng-unzip dan menghapus zip tersebut.
```
$ current=$(date "+%d%m%Y")
$ unzip -P $current Koleksi.zip
$ rm -f Koleksi.zip
```
```-P``` untuk meng-unzip file dengan password yang tertulis di command line.

Untuk memudahkan otomatisasi proses zip dan unzip, kita buat 2 fungsi seperti berikut.
```
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
```

Kemudian kita tambahkan perintah berikut pada crontab supaya proses terjadi otomatis pada pukul 7 dan 18, pada setiap hari senin hingga jum'at.
```
0 7 * * 1-5 source soal3d.sh; zipping
0 18 * * 1-5 source soal3d.sh; unzipping
```

>>>>>>> main
