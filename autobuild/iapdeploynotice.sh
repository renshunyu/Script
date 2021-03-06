#!bin/sh
home_path=/home/aiuap/ci/hejt
svn_home=/home/aiuap/svnproject/program/program/iap
sendperson=cat /home/aiuap/ci/hejt/config/iapsendperson
echo $sendperson
>$home_path/file/iapdfilelist
>$home_path/file/iapdresult
cd $svn_home
now_version=svn info|grep 最后修改的修订版|awk -F ： '{ print $2}'
echo $now_version
before_version=cat $home_path/config/iapdversion

echo $before_version 
if [ $before_version -eq $now_version ]
then
   sendEmail -t huby@asiainfo-linkage.com -t h@asiainfo-linkage.com -t l@asiainfo-linkage.com   -f hejt@asiainfo-linkage.com -s smtp.asiainfo-linkage.com:25 -xu hejt -xp 124%abc  -m "各位好！，审计前台web自动部署成功，较上一版本无变化" -o message-charset=zh_CN.gb18030 -u "审计前台web自动部署提醒"
  exit 0
fi
cd $svn_home
echo "Hi:" >>$home_path/file/iapdresult
echo "  各位好！，审计前台web自动部署成功，较上一版本变更信息如下：请各位及时复测bug和检测相关任务单">>$home_path/file/iapdresult
while [ 1 ]
do
echo $before_version
before_version=`expr $before_version + 1 
if [ $before_version -gt  $now_version ]
then
  sendEmail  $sendperson   -f liangll3@asiainfo-linkage.com -s smtp.asiainfo-linkage.com:25 -xu liangll3 -xp 35ng1986?  -o message-file=/home/aiuap/ci/hejt/file/iapdresult -o message-charset=zh_CN.gb18030 -u "审计平台自动部署提醒" 
  echo $now_version > $home_path/config/iapdversion
  exit 0
fi
svn log -r  $before_version > $home_path/file/iapdfilelist
i=0
 while read loginfo
 do
 if [ $i = '1' ]
 then 
 name=`echo $loginfo|awk -F "|" '{ print $2}'`
 timedate=`echo $loginfo|awk -F "|" '{ print $3}'`
 fi
 if [ $i = '3' ]
 then 
 content=$loginfo
 echo  "  版本号：" $before_version "提交人：" $name  "提交时间："$timedate "提交内容："$content>>$home_path/file/iapdresult
 fi
 i=`expr $i + 1 `
 done <$home_path/file/iapdfilelist
done
