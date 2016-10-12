#! /bin/bash
#
# coder: Aysad Kozanoglu
# email: aysadx@gmail.com
# web: http://onweb.pe.hu#
#

instance=`ps auxf | grep ffmpeg314 | wc -l`
getinstance=`cat /tmp/ffmpids | wc -l`
date=`date "+%F %T"`
echo $instance $getinstance
if [ ! $instance == $getinstance ];
then
        echo $date" ffmpegstarter instance "$instance" restart" >> /tmp/ffstatus.log
        echo $date" ffmpeg  instance "$instance" restart" >> /usr/local/nginx/html/live/status.log

        . /source/ffmpegstarter.sh
else
        echo $date" instance ok">> /tmp/ffstatus.log
        echo $date" instance ok">>  /usr/local/nginx/html/live/status.log
fi
