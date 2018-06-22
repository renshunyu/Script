#!/bin/bash
if [[ -z "$1" || -z "$2" ]]; then
  echo "参数不足"
  exit 1
fi


#切换的当前脚本所在的目录
spath=/home/aiuap/autobuild/patch
cd $spath

#当前发布的最新版本号
voo=$(awk 'NR == 1' $spath/pv/$1.version)
if [ $2 -le $voo ]; then
  echo "更新后的版本小于或等于更新前的版本"
  exit 1
fi

sed -i "1 i $2" $spath/pv/$1.version

von=$(awk 'NR == 1' $spath/pv/$1.version)
echo 已完成发布，发布版本由$voo升级到$von！
echo 最新版本号已记录到文件$spath/pv/$1.version中！
