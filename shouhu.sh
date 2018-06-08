#!/bin/sh
while true
do
num=$(pwdx `ps -ef |grep startup.py |grep -v grep|awk '{print $2}'`|grep /home/clouderauser/pythonimport001rm|wc -l)
timeout=$[ `date +%s` - `ls -l --time-style=+%s datasynlog.log|awk '{print $6}'` ]
echo `date`" "$num
if [ $num -eq 0 ]; then
echo true
echo "update iap_rdbms2hive_param t set t.param_value=0 where t.param_name like '%runningflag';
commit;"|sqlplus audit30testc/audit30testc#@10.15.42.37:1521/iap

nohup sh startup.sh $1>/dev/null &
fi

if [ $timeout -gt 3600 ]; then
echo true
kill -9 $(pwdx `ps -ef |grep startup.py |grep -v grep|awk '{print $2}'`|grep /home/clouderauser/pythonimport001rm|awk -F: '{print $1}')
echo "update iap_rdbms2hive_param t set t.param_value=0 where t.param_name like '%runningflag';
commit;"|sqlplus audit30testc/audit30testc#@10.15.42.37:1521/iap

nohup sh startup.sh $1>/dev/null &
fi

sleep 60
done
