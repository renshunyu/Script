#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/redis_exporter
cp /home/aiuap/thirdpartytools/monitor/redis_exporter/redis_exporter-v1.6.1.linux-amd64.tar.gz /home/aiuap/package/sssia/��װ��/redis_exporter/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
