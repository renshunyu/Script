#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/AuditInernalService
cp $buildhome/AuditInernalService/target/*tar.gz ~/package/sssia/��װ��/AuditInernalService/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
