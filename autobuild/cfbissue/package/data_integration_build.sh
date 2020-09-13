#!bin/sh
svnhome=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/$1/data_integration
#svnhome=http://10.1.198.30/svn/UAPPROGRAM/products/ailkiap30/programrm/v04r06c02/data_integration

buildhome=/home/aiuap/svnproject/program30/builddir

svn up $svnhome
result=$?
if [ $result != '0' ]
then
  echo "更新svn目录错误"
  exit 1
fi
rm -rf $buildhome/data_integration
if [ $result != '0' ]
then
  echo "删除编译目录错误"
  exit 1
fi

svn checkout $svnhome
#cp -rf $svnhome $buildhome/data_integration
#result=$?
#if [ $result != '0' ]
#then
#  echo "拷贝目录错误"
#  exit 1
#fi
#cd data_integration
find data_integration -name .svn|awk '{print "'\''"$0"'\''"}'|xargs rm -rf

tar -zcvf data_integration.tar.gz data_integration

mkdir -p ~/package/sssia/安装包/kettle
cp data_integration.tar.gz ~/package/sssia/安装包/kettle/
result=$?
if [ $result != '0' ]
then
  echo "复制安装包失败！"
  exit 1
fi
echo "成功"
exit 0
