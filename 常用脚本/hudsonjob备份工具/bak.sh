#!/bin/sh
for i in `find jobs -name config.xml`
do
  j=${i//jobs/hudsonjobsbak}
  mkdir -p ${j//config.xml/}
  cp $i ${j//config.xml/} 
done
