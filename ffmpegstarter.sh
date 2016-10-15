#! /bin/bash
#
# coder: Aysad Kozanoglu
# email: aysadx@gmail.com
# web: http://onweb.pe.hu#
#

source /source/links.sh

webtspath="/usr/local/nginx/html/live/"
webm3u8path="/usr/local/nginx/html/live/"
thisserverlink="http://localhost/live/" # oder öffentlich ip deines servers
thisPlaylist="plist.m3u8"
tmppath="/tmp/"

binpath="/usr/bin/"
ffmpeg="ffmpeg314"
ffmpids="ffmpids"

a=0;
killall -q $binpath$ffmpeg 
killall -q $ffmpeg 

rm $tmppath$ffmpids
rm -rf $webtspath*.ts
rm -rf $webm3u8path*.m3u8


echo "#EXTM3U" > $webm3u8path$thisPlaylist
for i in "${slink[@]}"
do
	sleep 2
	//-segment_format mpeg_ts
        $binpath$ffmpeg -d -y -i ${slink[a]}  -nostats -hide_banner -loglevel panic -vcodec copy -vprofile baseline -acodec aac \
        -strict -2 -f segment -segment_list_size 5 -segment_time 10 -segment_list_flags +live  -segment_list $webm3u8path${nlink[a]}".m3u8" \
        $webtspath${nlink[a]}%05d.ts </dev/null >/dev/null 2> $tmppath${nlink[a]}".log" & echo $! ${nlink[a]} >> $tmppath$ffmpids

	
	#$binpath$ffmpeg -d -y -i ${slink[a]}  -nostats -hide_banner -loglevel panic -vcodec copy -vprofile baseline -acodec aac \
	#-strict -2 -hls_flags delete_segments -hls_time 10 -hls_list_size 6 -hls_segment_filename $webtspath${nlink[a]}"%05d.ts" \
	#$webm3u8path${nlink[a]}".m3u8" </dev/null >/dev/null 2> $tmppath${nlink[a]}".log" & echo $! ${nlink[a]} >> $tmppath$ffmpids

	#create playlist
	echo "#EXTINF:0,"${nlink[a]} >> $webm3u8path$thisPlaylist
	echo $thisserverlink${nlink[a]}".m3u8" >> $webm3u8path$thisPlaylist

#### debug
#
#       echo ${slink[a]}
#       echo $webtspath${nlink[a]}"%05d.ts"
#       echo
#       echo $tmppath${nlink[a]}".log"
#       echo
#       echo $webm3u8path${nlink[a]}".m3u8"
#       echo
#       echo ${nlink[a]}"pid"
#
####
	((a++))
done
echo 
echo "ffmpeg Pid leri:"
cat $tmppath$ffmpids
echo
echo "toplam ffmpeg instanzi:"
wc -l $tmppath$ffmpids
echo
echo "playlist link:"
echo $thisserverlink$thisPlaylist
echo 
#echo ${Unix[1]}
#((a++))
