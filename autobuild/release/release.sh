#!/bin/bash
#切换的当前脚本所在的目录
spath=/home/aiuap/autobuild/release
cd $spath

#release源码本地路径
rpath=/home/aiuap/svnproject/release/iap
#发布版本的svn地址
svnurl=$(svn info $rpath|awk 'NR==2{print $2}')

#svn的release最新版本号
vn=$(svn log -q -l 1 $svnurl|awk 'NR==2{print $1}'|awk -F r '{print $2}')
#当前发布的最新版本号
voo=$(awk 'NR == 1' /home/aiuap/autobuild/release/iap.version)
sed -i "1 i $vn" /home/aiuap/autobuild/release/iap.version
von=$(awk 'NR == 1' /home/aiuap/autobuild/release/iap.version)
echo 已完成发布，发布版本由$voo升级到$von！
echo 最新版本号已记录到文件/home/aiuap/autobuild/release/iap.version中！
