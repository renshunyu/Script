#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/flume_exporter
cp /home/aiuap/thirdpartytools/monitor/flume_exporter/flume_exporter-0.0.2.tar.gz /home/aiuap/package/sssia/��װ��/flume_exporter/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
