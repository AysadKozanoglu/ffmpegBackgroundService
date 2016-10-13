#! /bin/bash
#
# coder: Aysad Kozanoglu
# email: aysadx@gmail.com
# web: http://onweb.pe.hu#
#
#
# Clean .ts files older than 10 minutes

echo "ts cleaner started"
find /usr/local/nginx/html/live -maxdepth 1 -mmin +10 -type f -name "*.ts" \
  -exec rm -rf {} \;