#!bin/sh
if [ ! -n "$1" ]; then
	echo "参数1位空"
	exit 1
fi


buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/doc/
cp $buildhome/发布相关的文档/$1/* ~/package/sssia/doc/ -r
result=$?
if [ $result != '0' ]
then
  echo "复制文件和文件夹失败！"
  exit 1
fi
echo "成功"
exit 0
