#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/process-exporter
cp /home/aiuap/thirdpartytools/monitor/process-exporter/process-exporter-0.6.0.linux-amd64.tar.gz /home/aiuap/package/sssia/��װ��/process-exporter/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
