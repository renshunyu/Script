#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/SSA_analyze_dbscan
cp $buildhome/SSA_analyze_dbscan/package/SSA_analyze_dbscan-*.jar ~/package/sssia/��װ��/SSA_analyze_dbscan/
cp $buildhome/SSA_analyze_dbscan/package/dbscan.zip ~/package/sssia/��װ��/SSA_analyze_dbscan/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
echo "�ɹ�"
exit 0
