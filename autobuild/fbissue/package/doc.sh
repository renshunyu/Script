#!bin/sh
if [ ! -n "$1" ]; then
	echo "����1λ��"
	exit 1
fi


buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/doc/
cp $buildhome/������ص��ĵ�/$1/* ~/package/sssia/doc/ -r
result=$?
if [ $result != '0' ]
then
  echo "�����ļ����ļ���ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
