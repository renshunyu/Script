#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir

cp $buildhome/kettle/kettle_client/workflow/dist  $buildhome/kettle/kettle-web-assemble/kettle-server/target/ROOT -r
cd $buildhome/kettle/kettle-web-assemble/kettle-server/target/
tar -zcvf dac.tar.gz kettle-server.war ROOT

mkdir -p ~/package/sssia/��װ��/dac
cp $buildhome/kettle/kettle-web-assemble/kettle-server/target/dac.tar.gz ~/package/sssia/��װ��/dac/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
