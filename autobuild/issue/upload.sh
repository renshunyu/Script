#!/bin/sh
if [ ! -n "$1" ]; then
        echo "����1Ϊ���η����İ汾��"
	exit 1
fi
cp ~/package/sssia ~/$1 -r


ncftpput -u 'ai\rensy' -p '3edc@WSX' -P 21 -m -R 10.1.252.239 ./ai4a30/aisia1.0/��Ʒ����/ ~/$1

rm -r ~/$1
