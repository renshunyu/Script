#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/prometheus
cp /home/aiuap/thirdpartytools/monitor/prometheus/prometheus.zip /home/aiuap/package/sssia/��װ��/prometheus/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
