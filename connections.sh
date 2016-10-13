#! /bin/bash
#
# start with watch -n 4 connections.sh  for every 4 second updates
# 
netstat -nat | awk '{print $6}' | sort | uniq -c | sort -n > /tmp/conn
echo "" >> /tmp/conn
netstat -atun | awk '{print $5}' | cut -d: -f1 | sed -e '/^$/d' |sort | uniq -c | sort -n >> /tmp/conn
cat /tmp/conn
