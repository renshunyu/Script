#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/node_exporter
cp /home/aiuap/thirdpartytools/monitor/node_exporter/node_exporter-0.18.1.linux-amd64.tar.gz /home/aiuap/package/sssia/��װ��/node_exporter/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
