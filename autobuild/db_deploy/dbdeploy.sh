#!/bin/sh
export NLS_LANG="Simplified Chinese_china".ZHS16GBK

version=$1
result=$?
buildhome=/home/aiuap/svnproject/program30/builddir/db�ű�/${version}
cd $buildhome/audit/oracle/ȫ��
sed -i 's/YYYY-MM-DD/2018-10-31/' 03_audita_month_table_partition.sql
sed -i '/\/\*/'d 01_audita_��ͨ��3.0-3.5��.sql
sed -i '/\/\*/'d 02_audita_month_table.sql
sed -i '/\/\*/'d 03_audita_month_table_partition.sql
sed -i '/\/\*/'d 04_audita_month_org_table.sql
sed -i '/\/\*/'d 05_audita_��������.sql
sed -i '/\/\*/'d 06_audita_view.sql
sed -i '/\/\*/'d 08_audita_sequence.sql
sed -i '/\/\*/'d iap_app_operate_type.sql
sqlplus audit30testd/audit30testd#@10.21.171.220:1521/iap >/home/aiuap/autobuild/db_deploy/dbdeploy.log << EOF
@01_audita_��ͨ��3.0-3.5��.sql
@02_audita_month_table.sql
@03_audita_month_table_partition.sql
@04_audita_month_org_table.sql
@05_audita_��������.sql
@06_audita_view.sql
@08_audita_sequence.sql
@iap_app_operate_type.sql
exit
EOF

cd $buildhome/rsd/oracle/ȫ��
sed -i '/\/\*/'d 01-������.sql
sed -i '/\/\*/'d 08_audita_sequence.sql
sqlplus audit30testd/audit30testd#@10.21.171.220:1521/iap >>/home/aiuap/autobuild/db_deploy/dbdeploy.log << EOF
@01-������.sql
@08_audita_sequence.sql
exit
EOF
cd /home/aiuap/autobuild/db_deploy/
result=`grep "ERROR" dbdeploy.log|wc -l`
if [[ $result != '0' ]]
then
    echo "db�ű����±���!"
	exit 1
fi
result=`grep "ORA" dbdeploy.log|wc -l`
if [[ $result != '0' ]]
then
    echo "db�ű����±���!"
    exit 1
fi
