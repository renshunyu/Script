#!/bin/bash
#�л��ĵ�ǰ�ű����ڵ�Ŀ¼
spath=/home/aiuap/autobuild/release
cd $spath

#releaseԴ�뱾��·��
rpath=/home/aiuap/svnproject/release/iap
#�����汾��svn��ַ
svnurl=$(svn info $rpath|awk 'NR==2{print $2}')

#svn��release���°汾��
vn=$(svn log -q -l 1 $svnurl|awk 'NR==2{print $1}'|awk -F r '{print $2}')
#��ǰ���������°汾��
voo=$(awk 'NR == 1' /home/aiuap/autobuild/release/iap.version)
sed -i "1 i $vn" /home/aiuap/autobuild/release/iap.version
von=$(awk 'NR == 1' /home/aiuap/autobuild/release/iap.version)
echo ����ɷ����������汾��$voo������$von��
echo ���°汾���Ѽ�¼���ļ�/home/aiuap/autobuild/release/iap.version�У�
