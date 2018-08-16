#!/bin/sh
u=`svn info http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/doc/02-需求文档/04-产品需求-敏捷/AISIA-V04R02|grep 'Last Changed Date:'|awk '{print $4}'`
d=`date +%Y-%m-%d`
if [ "$u" == "$d" ]
then
  exit 0
else
  exit 1
fi
