#!/bin/bash
source ./huanjing.sh
#source /etc/profile
#basepath=$(cd `dirname $0`;pwd)
#source ${basepath}"/functions.sh"
# ÒÔtest¿ªÍ·
function testItCanOutPutSomeDate()
{
  for i in `seq 1 100`
  do
    s=`curl -s -X GET  http://$mip:$mport/cycleInfo|jq .taskEndTime`
    assertEquals "21" "${#s}"
    sleep 0.1
  done
}
. "${SHUNIT2_HOME}/shunit2"
