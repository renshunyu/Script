#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/grafana_template
cp /home/aiuap/svnproject/program30/builddir/grafana_template/grafana_template/grafana_template.tar.gz /home/aiuap/package/sssia/��װ��/grafana_template/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
