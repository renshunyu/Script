#!bin/sh

deployhome=/home/aiuap30/data-integration/workspace
buildhome=/home/aiuap/svnproject/program30/builddir/ETL_Script

sudo su - aiuap30 -c "cp $buildhome/���Ź淶/ȡ������/ϵͳ��־ȡ��_����/* $deployhome/systemloggetdata_henan/"

sudo su - aiuap30 -c "cp $buildhome/���Ź淶/ȡ������/Ӧ����־ȡ��_����/* $deployhome/apploggetdata_henan/"

sudo su - aiuap30 -c "cp $buildhome/���Ź淶/ȡ������/�����˺�ȡ��_����/GetMainSubAcct/* $deployhome/acctgetdata_henan/"

sudo su - aiuap30 -c "cp $buildhome/���Ź淶/ȡ������/�Զ���SQLȡ��_����/CustomizeSQL/* $deployhome/custemgetdata_henan/"

sudo su - aiuap30 -c "sh /home/aiuap30/data-integration/workspace/initconfig/installhenan.sh"

result=$?
if [ $result != '0' ]
then
  echo "����data-reporting-0.0.1-SNAPSHOT��Ŀ����"
  exit 1
fi
echo "ETL_Script��Ŀ�Ѿ�����ɹ�"
exit 0
