#!/bin/bash
if [[ -z "$1" || -z "$2" ]]; then
  echo "��������"
  exit 1
fi


#�л��ĵ�ǰ�ű����ڵ�Ŀ¼
spath=/home/aiuap/autobuild/patch
cd $spath

#��ǰ���������°汾��
voo=$(awk 'NR == 1' $spath/pv/$1.version)
if [ $2 -le $voo ]; then
  echo "���º�İ汾С�ڻ���ڸ���ǰ�İ汾"
  exit 1
fi

sed -i "1 i $2" $spath/pv/$1.version

von=$(awk 'NR == 1' $spath/pv/$1.version)
echo ����ɷ����������汾��$voo������$von��
echo ���°汾���Ѽ�¼���ļ�$spath/pv/$1.version�У�
