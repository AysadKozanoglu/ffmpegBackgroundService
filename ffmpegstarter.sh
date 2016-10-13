#! /bin/bash
#
# coder: Aysad Kozanoglu
# email: aysadx@gmail.com
# web: http://onweb.pe.hu#
#

webtspath="/usr/local/nginx/html/live/"
webm3u8path="/usr/local/nginx/html/live/"
thisserverlink="http://localhost/live/" # oder öffentlich ip deines servers
thisPlaylist="plist.m3u8"
tmppath="/tmp/"

binpath="/usr/bin/"
ffmpeg="ffmpeg314"
ffmpids="ffmpids"

slink[0]="http://daserste_live-lh.akamaihd.net/i/daserste_de@91204/index_2692_av-p.m3u8"
nlink[0]="daserste"
slink[1]='http://media.netd.com.tr/S2/HLS_LIVE/cnn_turk/750/prog_index.m3u8'
nlink[1]='cnnturk'
slink[2]='http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_900_av-b.m3u8'
nlink[2]='trtworld'
slink[3]='http://trtcanlitv-lh.akamaihd.net/i/TRTSPOR1_1@182042/index_800_av-b.m3u8'
nlink[3]='trtspor'
slink[4]='http://trtcanlitv-lh.akamaihd.net/i/TRTTURK_1@182144/index_700_av-p.m3u8'
nlink[4]='trtturk'
slink[5]='http://trtcanlitv-lh.akamaihd.net/i/TRT1HD_1@181842/index_900_av-b.m3u8'
nlink[5]='trt1'
slink[6]='http://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/index_900_av-p.m3u8'
nlink[6]='trthaber'
slink[7]='http://trtcanlitv-lh.akamaihd.net/i/TRTBELGESEL_1@182145/index_900_av-b.m3u8'
nlink[7]='trtbelgesel'

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
	
        $binpath$ffmpeg -d -y -i ${slink[a]}  -nostats -hide_banner -loglevel panic -vcodec copy -vprofile baseline -acodec aac \
        -strict -2 -f segment -segment_format mpeg_ts -segment_list $webm3u8path${nlink[a]}".m3u8" -segment_time 10 $webtspath${nlink[a]}%05d.ts \
        </dev/null >/dev/null 2> $tmppath${nlink[a]}".log" & echo $! ${nlink[a]} >> $tmppath$ffmpids
	
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
