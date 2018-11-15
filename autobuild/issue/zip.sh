#!/bin/sh
packagepath=/home/aiuap/package
zippath=/home/aiuap/packagezip

mkdir -p $zippath/sssia/安装包/
mkdir -p $zippath/sssia/db脚本/
mkdir -p $zippath/sssia/doc/


for i in `ls $packagepath/sssia/安装包/`
do
  echo $i
  cd $packagepath/sssia/安装包/
  zip -r $zippath/sssia/安装包/$i.zip $i
done

for i in `ls $packagepath/sssia/db脚本/`
do
  cd $packagepath/sssia/db脚本/
  zip -r $zippath/sssia/db脚本/$i.zip $i
  echo $i
done

for i in `ls $packagepath/sssia/doc/`
do
  cp -r $packagepath/sssia/doc/$i $zippath/sssia/doc/
  echo $i
done
