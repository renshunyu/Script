#!/bin/sh
n=`cat testdata|wc -l`
for ((i=1;i<=$n;i++)); 
do
  echo $i
  col=`head -n $i testdata|tail -n 1|awk -F'\|' '{print NF}'`
  echo $col
  tag=`head -n $i testdata|tail -n 1|awk -F'\|' '{print $1}'`
  echo $tag
  sed "s/<$tag>.*<\/$tag>//g" BOSS30_1.XML> ${i}_a.xml
  sed "s/<$tag>.*<\/$tag>/<$tag><\/$tag>/g" BOSS30_1.XML> ${i}_b.xml
  for ((j=2;j<=$col;j++))
  do
    va=`head -n $i testdata|tail -n 1|awk -v j=$j -F'\|' '{print $j}'`
    sed "s/<$tag>.*<\/$tag>/<$tag>$va<\/$tag>/g" BOSS30_1.XML> ${i}_${j}.xml
  done
done
