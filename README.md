# soal-shift-sisop-modul-1-D01-2021 #
- [Daftar Isi]
   - [Anggota Kelompok]
   - [soal-1] (#soal-1 "Go to soal 1")
      - [1a]
      - [1b]
      - [1c]
      - [1d]
      - [1e]
   - [Soal 2]
      - [2a]
      - [2b]
      - [2c]
      - [2d]
      - [2e]
   - [Soal 3]
      - [3a]
      - [3b]
      - [3c]
      - [3d]
      - [3e]

## Anggota Kelompok ##

Khaela Fortunela 05111940000057

M Haikal Aria Sakti 05111940000088

David Ralphwaldo M 05111940000190

## Soal 1 ##
Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, *ticky*. Terdapat 2 laporan yang harus dia buat, yaitu laporan **daftar peringkat pesan error** terbanyak yang dibuat oleh *ticky* dan laporan **penggunaan user** pada aplikasi *ticky*. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

**(a)** Mengumpulkan informasi dari log aplikasi yang terdapat pada file `syslog.log`. Informasi yang diperlukan antara lain: jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.

![Soal1a](https://i.postimg.cc/VLqPP5dB/1-a.png)

### Cara Pengerjaan ###

1. Menggunakan cut dengan delimiter ':' untuk mendapatkan jenis pesan, isi pesan, dan username. Hasilnya kemudian dicut lagi dengan delimiter ' ' (spasi) untuk menghilangkan spasi di awal pesan. Hasilnya kemudian disimpan di variabel loglist.
2. Menggunakan grep untuk mencari semua pesan error yang disimpan di loglist kemudian hasilnya disimpan di variabel errorlist.
3. Menggunakan grep untuk mencari semua pesan info yang disimpan di loglist kemudian hasilnya disimpan di variabel infolist.

### Kendala ###

Tidak ada kendala.

**(b)** Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

![Soal1b](https://i.postimg.cc/255sWwT2/1-b.png)

### Cara pengerjaan ###

1. Isi variabel errorlist dicut dengan menggunakan delimiter ' ' (spasi) dari field kedua sampai terakhir untuk mendapatkan jenis errornya. Kemudian hasilnya dicut lagi dengan delimiter '(' (buka kurung) dan diambil field pertamanya untuk menghilangkan nama usernamenya. Lalu hasilnya disort kemudian dihilangkan duplikatnya dengan menggunakan perintah uniq. Hasilnya disimpan di variabel errortypes.
2. Membaca isi dari variabel errortypes kemudian menghitung jumlah tiap jenis error. Kemudian hasilnya diappend ke variabel errors untuk nanti diurutkan.
3. Isi dari variabel errors diurutkan berdasarkan jumlah errornya untuk nanti dioutput ke file error_message.csv

### Kendala ###

Awalnya kami menggunakan:
```
	printf "$errortypes" | while read line
	do
		...
	done
```
Tetapi ternyata isi variabel errors hilang setelah loop selesai. Jadi kami mengubahnya menjadi:
```
	while read line
	do
		...
	done <<< `printf "$errortypes"`
```

**(c)** Ryujin juga harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap *user*-nya.

![Soal1c](https://i.postimg.cc/PqFBQwRh/1-c.png)

### Cara pengerjaan ###

1. Melakukan cut pada variabel loglist dengan delimiter '(' dan field kedua untuk mendapatkan usernamenya. Hasilnya kemudian dicut dengan delimiter ')' dan field pertama untuk menghilangkan ')' (tutup kurung) setelah username. Kemudian hasilnya diurutkan dan dihilangkan duplikatnya.
2. Mencari jumlah error untuk setiap user dengan mencari nama username pada list error kemudian menghitung jumlah kemunculannya. Hasilnya disimpan di variabel usererrorcount.
3. Mencari jumlah info untuk setiap user dengan mencari nama username pada list info kemudian menghitung jumlah kemunculannya. Hasilnya disimpan di variabel userinfocount.
4. Menyimpan username, jumlah info, dan jumlah error ke dalam variabel currentuserstat.
5. Variabel currentuserstat diappend ke variabel userstat.

### Kendala ###

Sama seperti no 1.B, kami harus mengubah while loopnya.

Setelah semua informasi yang diperlukan telah disiapkan, kini saatnya Ryujin menuliskan semua informasi tersebut ke dalam laporan dengan format file csv.

**(d)** Semua informasi yang didapatkan pada poin **b** dituliskan ke dalam file `error_message.csv` dengan header **Error,Count** yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya **diurutkan** berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

Contoh:
```
Error,Count
Permission denied,5
File not found,3
Failed to connect to DB,2
```

![Soal1d](https://i.postimg.cc/6pBJWwZs/1-d.png)

### Cara pengerjaan ###

1. Membuat file error_message.csv dan menuliskan header "Error,Count" ke dalamnya.
2. Mengappend isi dari variabel errors yang sudah dibuat pada no 1.B ke dalam file error_message.csv

### Kendala ###

Tidak ada kendala.

**(e)** Semua informasi yang didapatkan pada poin **c** dituliskan ke dalam file `user_statistic.csv` dengan header **Username,INFO,ERROR** **diurutkan** berdasarkan username secara ***ascending***.

Contoh:

```
Username,INFO,ERROR
kaori02,6,0
kousei01,2,2
ryujin.1203,1,3
```

![Soal1e](https://i.postimg.cc/13Mx4T08/1-e.png)

### Cara pengerjaan ###
1. Membuat file user_statistic.csv dan mengisi baris pertama dengan header Username,INFO,ERROR.
2. Mengappend isi dari variabel userstat yang diperoleh pada no 1.C ke dalam file user_statistic.csv.

### Kendala ###

Tidak ada kendala.

## Soal 2 ##

Steven dan Manis mendirikan sebuah *startup* bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan “*Laporan-TokoShiSop.tsv*”.

**a.** Steven ingin mengapresiasi kinerja karyawannya selama ini dengan mengetahui **Row ID** dan **profit percentage terbesar** (jika hasil *profit percentage* terbesar lebih dari 1, maka ambil Row ID yang paling besar). Karena kamu bingung, Clemong memberikan definisi dari *profit percentage*, yaitu:

𝑃𝑟𝑜𝑓𝑖𝑡 𝑃𝑒𝑟𝑐𝑒𝑛𝑡𝑎𝑔𝑒 = (𝑃𝑟𝑜𝑓𝑖𝑡 ÷ 𝐶𝑜𝑠𝑡 𝑃𝑟𝑖𝑐𝑒) × 100

*Cost Price* didapatkan dari pengurangan *Sales* dengan *Profit*. (**Quantity diabaikan**).

![Soal2a](https://i.postimg.cc/J0RcyT5h/2-a.png)

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

![Soal2b](https://i.postimg.cc/5yp58wsS/2-b.png)

Untuk mencari nama - nama customer yang berasal dari kota Albuquerque dan melakukan transaksi pada tahun 2017, kita dapat mengeksekusi perintah:
```
namacustomer=`awk -F '	' '/2017/ && NR > 1 && $10 == "Albuquerque" { print $7 }' Laporan-TokoShiSop.tsv | sort | uniq`
```
Nama - nama customer yang berasal dari Albuquerque diurutkan, dihapus jika ada duplikatnya, dan disimpan dalam variabel namacustomer.

**c.** TokoShiSop berfokus tiga _segment customer_, antara lain: _Home Office_, _Customer_, dan _Corporate_. Clemong ingin meningkatkan penjualan pada segmen _customer_ yang paling sedikit. Oleh karena itu, Clemong membutuhkan **segment _customer_** dan **jumlah transaksinya yang paling sedikit**.

![Soal2c](https://i.postimg.cc/5N7q0SYx/2-c.png)

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

![Soal2d](https://i.postimg.cc/FssVNBKW/2-d.png)

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

![Soal2e](https://i.postimg.cc/tRzz0j9n/2-e.png)

Untuk menyimpan semua informasi yang sudah diperoleh, kita dapat menjalankan perintah - perintah berikut:
```
printf "Transaksi terakhir dengan profit percentage terbesar yaitu $rowid dengan persentase $profitpercent%%\n\n" > hasil.txt
printf "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n" >> hasil.txt
printf "$namacustomer\n" >> hasil.txt
printf "\nTipe segmen customer yang penjualannya paling sedikit adalah $tipesegmen dengan $totaltransaksi transaksi.\n\n" >> hasil.txt
printf "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah $namaregion dengan total keuntungan $totalkeuntungan\n" >> hasil.txt
```

## Soal 3
Kuuhaku adalah orang yang sangat suka mengoleksi foto-foto digital, namun Kuuhaku juga merupakan seorang yang pemalas sehingga ia tidak ingin repot-repot mencari foto, selain itu ia juga seorang pemalu, sehingga ia tidak ingin ada orang yang melihat koleksinya tersebut, sayangnya ia memiliki teman bernama Steven yang memiliki rasa kepo yang luar biasa. Kuuhaku pun memiliki ide agar Steven tidak bisa melihat koleksinya, serta untuk mempermudah hidupnya, yaitu dengan meminta bantuan kalian. Idenya adalah :

**a.** Membuat script untuk mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten" serta menyimpan log-nya ke file "Foto.log". Karena gambar yang diunduh acak, ada kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus menghapus gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian menyimpan gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan tanpa ada nomor yang hilang (contoh : Koleksi_01, Koleksi_02, ...)

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
**b.** Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut sehari sekali pada jam 8 malam untuk tanggal-tanggal tertentu setiap bulan, yaitu dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta log-nya, dipindahkan ke folder dengan nama tanggal unduhnya dengan format "DD-MM-YYYY" (contoh : "13-03-2023").

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
**c.** Agar kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk mengunduh gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara bergantian (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, nama folder diberi awalan "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023").

Pertama, kita bisa tentukan sebuah direktori untuk menyimpan folder-folder tersebut. Misal, kita bisa buat sebuah direktori di /home/[username] bernama Koleksi.
```
$ mkdir Koleksi
$ cd Koleksi
```
```mkdir``` adalah perintah untuk membuat sebuah direktori atau folder. Format ```mkdir namafolder```.

```cd``` adalah perintah untuk pergi ke suatu direktori tertentu. Format ```cd namafolder```.

Kemudian, kita buat direktori untuk foto yang akan diunduh dengan format "Kucing_tanggal-bulan-tahun"
```
$ mkdir $(date "+ Kucing_%d-%m-%Y")
```
Selanjutnya, kita masuk ke direktori tersebut dan mendownload foto kucing dari "https://loremflickr.com/320/240/kitten".
```
$ wget https://loremflickr.com/320/240/kitten
```
```wget``` digunakan untuk mengunduh file dari alamat HTTP, HTTPS, FTP dan FTPS. Format ```wget alamat```.

Kemudian untuk meng-otomatis-kan semua perintah itu, kita taruh semua perintah di file soal3c.sh.
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
Untuk mengunduh file kucing, kita bisa memanggil fungsinya menggunakan command ```source``` seperti berikut. Format ```source shellscript; function```.
```
$ source soal3c.sh; kitten
```
Kemudian, karena kita harus meng-otomatis-kan pengunduhan file kucing dan kelinci dengan hari yang berselang-seling, maka kita tambahkan perintah berikut ini ke crontab.
```
0 0 1-31/2 * * source soal3c.sh; bunny
0 0 2-31/2 * * source soal3c.sh; kitten
```
Maka fungsi akan tereksekusi tiap pukul 00:00, untuk ```bunny``` pada tanggal ganjil, dan untuk ```kitten``` pada tanggal genap.

**REVISI**

Pada implementasi kode diatas file foto tersimpan dengan nama "kitten" untuk foto kucing dan "bunny" untuk foto kelinci. Dan juga, saat dilakukan pengunduhan foto lebih dari satu kali pada tanggal yang sama, file foto akan dinamai kitten.1, kitten.2, dan seterusnya, dan juga tidak bisa dilihat sebagai foto. Untuk memperbaiki hal ini, kita tambahkan perintah penamaan pada file yang diunduh oleh ```wget```. File akan dinamai berdasarkan jenis foto, tanggal dan jam pengunduhan dengan format ```Kucing_tanggal-bulan-tahun_jam:menit:detik```. Berikut adalah skripnya.
```
wget -O $(date "+ Kelinci_%d-%m-%Y_%H:%M:%S") https://loremflickr.com/320/240/bunny
```
```-O``` atau ```--output-document=FILE```digunakan untuk menyimpan file hasil pengunduhan dengan nama berbeda. Sehingga shell script soal3c.sh menjadi seperti berikut. 

```
#! /bin/sh/

function kitten() {
   cd Koleksi
   mkdir $(date "+ Kucing_%d-%m-%Y")
   cd $(date "+ Kucing_%d-%m-%Y")
   wget -O $(date "+ Kucing_%d-%m-%Y_%H:%M:%S") https://loremflickr.com/320/240/kitten
   cd
}

function bunny() {
   cd Koleksi
   mkdir $(date "+ Kelinci_%d-%m-%Y")
   cd $(date "+ Kelinci_%d-%m-%Y")
   wget -O $(date "+ Kelinci_%d-%m-%Y_%H:%M:%S") https://loremflickr.com/320/240/bunny
   cd
}
```

![Screenshot of soal3c.sh](https://i.postimg.cc/bwm0ZHZy/Screenshot-363.png)


**d.** Untuk mengamankan koleksi Foto dari Steven, Kuuhaku memintamu untuk membuat script yang akan memindahkan seluruh folder ke zip yang diberi nama “Koleksi.zip” dan mengunci zip tersebut dengan password berupa tanggal saat ini dengan format "MMDDYYYY" (contoh : “03032003”).

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

![Screenshot of soal3c.sh](https://i.postimg.cc/W1dmJqg0/Screenshot-364.png)


**e.** Karena kuuhaku hanya bertemu Steven pada saat kuliah saja, yaitu setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya ter-zip saat kuliah saja, selain dari waktu yang disebutkan, ia ingin koleksinya ter-unzip dan tidak ada file zip sama sekali.

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
![Screenshot of soal3c.sh](https://i.postimg.cc/KcCSkwKz/Screenshot-365.png)

>>>>>>> main
