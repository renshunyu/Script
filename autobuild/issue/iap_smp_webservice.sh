#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/iap_smp_webservice
cp $buildhome/iap_smp_webservice/target/dist/*.war ~/package/sssia/��װ��/iap_smp_webservice/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
