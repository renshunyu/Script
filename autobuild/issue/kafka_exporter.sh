#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/kafka_exporter
cp /home/aiuap/thirdpartytools/monitor/kafka_exporter/kafka_exporter-0.3.0.linux-amd64.tar.gz /home/aiuap/package/sssia/��װ��/kafka_exporter/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
