#!/bin/bash

# Nomor A

loglist=`cat syslog.log | cut -d ':' -f 4 | cut -d ' ' -f 2-` # Simpan semua pesan error dan info dengan isinya dan username

errorlist=`echo "$loglist" | grep "ERROR"`
infolist=`echo "$loglist" | grep "INFO"`

# Nomor B

errortypes=`echo "$errorlist" | cut -d ' ' -f 2- | cut -d '(' -f 1 | sort | uniq` # Simpan semua jenis error
errors=''

while read line
do
	errorcount=`echo "$errorlist" | grep -c "$line"` # Hitung jumlah error untuk jenis tertentu
	errors=`printf "$errors\n$line,$errorcount"` # Simpan jenis error dan jumlahnya
done <<< `printf "$errortypes"`

errors=`echo "$errors" | sort -t ',' -k 2 -n -r` # Urutkan error berdasarkan jumlahnya

# Nomor C

userlist=`echo "$loglist" | cut -d '(' -f 2 | cut -d ')' -f 1 | sort | uniq` # Simpan semua username yang ada dan diurutkan berdasarkan abjad
userstat=''

while read line
do
	usererrorcount=`echo "$errorlist" | grep "$line" | grep -c "ERROR"` # Hitung jumlah pesan error untuk user tersebut
	userinfocount=`echo "$infolist" | grep "$line" | grep -c "INFO"` # Hitung jumlah pesan info untuk user tersebut

	currentuserstat=`printf "$line,$userinfocount,$usererrorcount\n"` # Simpan username, jumlah pesan info, dan jumlah pesan error
	userstat=`printf "$userstat\n$currentuserstat"`
done <<< `printf "$userlist"`

# Nomor D

echo "Error,Count" > error_message.csv
printf "$errors\n" >> error_message.csv

# Nomor E

printf "Username,INFO,ERROR" > user_statistic.csv
printf "$userstat\n" >> user_statistic.csv
