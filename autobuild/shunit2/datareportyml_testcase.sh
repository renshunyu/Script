#!/bin/bash
#source ./huanjing.sh
confpath=/home/aiuap30/data-reporting/data-reporting-0.0.1-SNAPSHOT/config/application.yml.new
#source /etc/profile
#basepath=$(cd `dirname $0`;pwd)
#source ${basepath}"/functions.sh"
# ÒÔtest¿ªÍ·

function testNodeNum()
{
v=`js-yaml $confpath|sed 's/-/_/g'|jq '.|length'`
assertEquals "8" "$v"

v=`js-yaml $confpath|sed 's/-/_/g'|jq '.eureka|length'`
assertEquals "1" "$v"

v=`js-yaml $confpath|sed 's/-/_/g'|jq '.server|length'`
assertEquals "1" "$v"

v=`js-yaml $confpath|sed 's/-/_/g'|jq '.mybatis|length'`
assertEquals "2" "$v"

v=`js-yaml $confpath|sed 's/-/_/g'|jq '.jasypt|length'`
assertEquals "1" "$v"

v=`js-yaml $confpath|sed 's/-/_/g'|jq '.spring|length'`
assertEquals "3" "$v"

v=`js-yaml $confpath|sed 's/-/_/g'|jq '.spring.datasource|length'`
assertEquals "5" "$v"

v=`js-yaml $confpath|sed 's/-/_/g'|jq '.logging|length'`
assertEquals "2" "$v"

v=`js-yaml $confpath|sed 's/-/_/g'|jq '.generate|length'`
assertEquals "5" "$v"

v=`js-yaml $confpath|sed 's/-/_/g'|jq '.upload_task|length'`
assertEquals "7" "$v"

v=`js-yaml $confpath|sed 's/-/_/g'|jq '.upload_task.file_name|length'`
assertEquals "5" "$v"

v=`js-yaml $confpath|sed 's/-/_/g'|jq '.upload_task.upload_property|length'`
assertEquals "8" "$v"

}


function testEurekaClientEnabled()
{
v=`js-yaml $confpath|sed 's/-/_/g'|jq .eureka.client.enabled`
assertEquals "false" "$v"
}
function testEurekaClientService_urlDefaultZone()
{
v=`js-yaml $confpath|sed 's/-/_/g'|jq .eureka.client.service_url.defaultZone`
assertEquals '"http://Eureka1:19031/eureka/, http://Eureka2:19032/eureka/, http://Eureka3:19033/eureka/"' "$v"
}
function testServerPort()
{
v=`js-yaml $confpath|sed 's/-/_/g'|jq .server.port`
assertEquals '10011' "$v"
}
function testJasyptEncryptorBean()
{
v=`js-yaml $confpath|sed 's/-/_/g'|jq .jasypt.encryptor.bean`
assertEquals '"encryptorBean"' "$v"
}

function testSpringApplicationName()
{
v=`js-yaml $confpath|sed 's/-/_/g'|jq .spring.application.name`
assertEquals '"dr_${upload_task.task_name}"' "$v"
}
function testSpringJacksonSerializationWRITE_DATES_AS_TIMESTAMPS()
{
v=`js-yaml $confpath|sed 's/-/_/g'|jq .spring.jackson.serialization.WRITE_DATES_AS_TIMESTAMPS`
assertEquals 'false' "$v"
}

function testGenerateTime_format()
{
v=`js-yaml $confpath|sed 's/-/_/g'|jq .generate.time_format`
assertEquals '"yyyyMMddHHmmss"' "$v"
}

function testGenerateSpacer()
{
v=`js-yaml $confpath|sed 's/-/_/g'|jq .generate.spacer`
assertEquals '"|"' "$v"
}

function testUpload_taskDrill_ahead()
{
v=`js-yaml $confpath|sed 's/-/_/g'|jq .upload_task.drill_ahead`
assertEquals '0' "$v"
}

function testUpload_taskBegin_time()
{
v=`js-yaml $confpath|sed 's/-/_/g'|jq '.upload_task.begin_time'`
assertEquals '201801010000' "$v"
}

function testUpload_taskFile_nameFileNameDateLength()
{
v=`js-yaml $confpath|sed 's/-/_/g'|jq .upload_task.file_name.fileNameDateLength`
assertEquals '"month_minute"' "$v"
}
. "${SHUNIT2_HOME}/shunit2"
