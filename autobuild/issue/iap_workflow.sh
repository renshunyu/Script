#!bin/sh
buildhome=/home/aiuap/svnproject/program30/builddir
mkdir -p ~/package/sssia/��װ��/iap_workflow/iap_workflow_common
cp $buildhome/iap_workflow/iap_workflow_common/target/*.tar.gz ~/package/sssia/��װ��/iap_workflow/iap_workflow_common/
result=$?
if [ $result != '0' ]
then
  echo "���ư�װ��ʧ�ܣ�"
  exit 1
fi
#mkdir -p ~/package/sssia/��װ��/iap_workflow/iap_workflow_anhui
#cp $buildhome/iap_workflow/iap_workflow_anhui/target/*.tar.gz ~/package/sssia/��װ��/iap_workflow/iap_workflow_anhui/
#result=$?
#if [ $result != '0' ]
#then
#  echo "���ư�װ��ʧ�ܣ�"
#  exit 1
#fi
#mkdir -p ~/package/sssia/��װ��/iap_workflow/iap_workflow_shanghai
#cp $buildhome/iap_workflow/iap_workflow_shanghai/target/*.tar.gz ~/package/sssia/��װ��/iap_workflow/iap_workflow_shanghai/
#result=$?
#if [ $result != '0' ]
#then
#  echo "���ư�װ��ʧ�ܣ�"
#  exit 1
#fi
#mkdir -p ~/package/sssia/��װ��/iap_workflow/iap_workflow_shanxi
#cp $buildhome/iap_workflow/iap_workflow_shanxi/target/*.tar.gz ~/package/sssia/��װ��/iap_workflow/iap_workflow_shanxi/
#result=$?
#if [ $result != '0' ]
#then
#  echo "���ư�װ��ʧ�ܣ�"
#  exit 1
#fi
#mkdir -p ~/package/sssia/��װ��/iap_workflow/iap_workflow_henan
#cp $buildhome/iap_workflow/iap_workflow_henan/target/*.tar.gz ~/package/sssia/��װ��/iap_workflow/iap_workflow_henan/
#result=$?
#if [ $result != '0' ]
#then
#  echo "���ư�װ��ʧ�ܣ�"
#  exit 1
#fi


echo "�ɹ�"
exit 0
