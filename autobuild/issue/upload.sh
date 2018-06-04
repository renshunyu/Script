#!/bin/sh
if [ ! -n "$1" ]; then
        echo "参数1为本次发布的版本号"
	exit 1
fi
cp ~/package/sssia ~/$1 -r


ncftpput -u 'ai\rensy' -p '3edc@WSX' -P 21 -m -R 10.1.252.239 ./ai4a30/aisia1.0/产品发布/ ~/$1

rm -r ~/$1
