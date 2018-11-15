#!/bin/sh
packagepath=/home/aiuap/package
zippath=/home/aiuap/packagezip

mkdir -p $zippath/sssia/��װ��/
mkdir -p $zippath/sssia/db�ű�/
mkdir -p $zippath/sssia/doc/


for i in `ls $packagepath/sssia/��װ��/`
do
  echo $i
  cd $packagepath/sssia/��װ��/
  zip -r $zippath/sssia/��װ��/$i.zip $i
done

for i in `ls $packagepath/sssia/db�ű�/`
do
  cd $packagepath/sssia/db�ű�/
  zip -r $zippath/sssia/db�ű�/$i.zip $i
  echo $i
done

for i in `ls $packagepath/sssia/doc/`
do
  cp -r $packagepath/sssia/doc/$i $zippath/sssia/doc/
  echo $i
done
