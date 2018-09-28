#!/bin/sh

result=$?
cd /home/aiuap/autobuild/db_deploy/
sqlplus audit30testd/audit30testd#@10.15.42.37:1521/iap << EOF
set pages 0
set feed off 
set heading off 
set feedback off 
set verify off 
set linesize 1000 
spool temp.sql
select 'drop view ' || view_name||';'||chr(13)||chr(10) from user_views;
select 'drop sequence ' || sequence_name||';'||chr(13)||chr(10) from user_sequences;  
select 'drop function ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='FUNCTION';
select 'drop procedure ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='PROCEDURE';
select 'drop table ' || table_name ||';'||chr(13)||chr(10) from user_tables;
spool off
exit
EOF
sed -i 1d temp.sql
sed -i '/SQL>/'d temp.sql
sqlplus audit30testd/audit30testd#@10.15.42.37:1521/iap >dropTable.log<< EOF
@/home/aiuap/autobuild/db_deploy/temp.sql
exit
EOF
grep "IAP_POLICY_LOG_BASE" /home/aiuap/autobuild/db_deploy/dropTable.log>1.log
if [ $result == 0 ]
then
sqlplus audit30testd/audit30testd#@10.15.42.37:1521/iap<< EOF
drop table IAP_POLICY_LOG_BASE;
exit
EOF
fi

rm -rf temp.sql
