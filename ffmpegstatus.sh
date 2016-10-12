
#! /bin/bash
#
# coder: Aysad Kozanoglu
# email: aysadx@gmail.com
# web: http://onweb.pe.hu
#

instance=`ps auxf | grep ffmpeg314 | wc -l`
getinstance=`cat /tmp/ffmpids | wc -l`
weblog="/usr/local/nginx/html/status.log"
date=`date "+%F %T"`

echo $instance $getinstance
echo $instance $getinstance >> $weblog

if [ $instance -ne $getinstance ];
then
        echo $date" ffmpegstarter instance "$instance" restart" >> /tmp/ffstatus.log
        echo $date" ffmpeg  instance "$instance" restart" >> $weblog

        /source/ffmpegstarter.sh
else
        echo $date" instance ok">> /tmp/ffstatus.log
        echo $date" "$instance" instance ok">> $weblog
fi


