#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/iap_solr_dataimport
cp $buildhome/iap_solr_dataimport/target/dist/*.war ~/package/sssia/��װ��/iap_solr_dataimport/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
