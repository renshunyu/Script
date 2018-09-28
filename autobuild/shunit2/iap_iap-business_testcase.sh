#!/bin/bash
confpath=/home/aiuap/svnproject/program30/program/iap/src/main/resource/iap-business.properties
#confpath=/home/aiuap30/tomcat_iap30/iapconfinit/iap-business.properties
#source /etc/profile
# ÒÔtest¿ªÍ·
function testKeynum()
{
v=`java readpro $confpath -s`
assertEquals "326" "$v"

}
function testIsSendMessage()
{
v=`java readpro $confpath -g isSendMessage`
assertEquals "on" "$v"

}
function testIsEasyMessage()
{
v=`java readpro $confpath -g isEasyMessage`
assertEquals "false" "$v"

}
function testGTask()
{
v=`java readpro $confpath -g gTask`
assertEquals "2" "$v"

}
function testAuditRemindMessage()
{
v=`java readpro $confpath -g auditRemindMessage`
assertEquals "0" "$v"

}
function testIsNeedCsv()
{
v=`java readpro $confpath -g isNeedCsv`
assertEquals "off" "$v"

}
function testHandAssignTaskSendMesaage()
{
v=`java readpro $confpath -g handAssignTaskSendMesaage`
assertEquals "false" "$v"

}

function testLevel4Three()
{
v=`java readpro $confpath -g level4Three`
assertEquals "off" "$v"

}
function testShowThreeOrg()
{
v=`java readpro $confpath -g showThreeOrg`
assertEquals "off" "$v"

}
function testAnhui_audit()
{
v=`java readpro $confpath -g anhui.audit`
assertEquals "close" "$v"

}
function testRoot_areaId()
{
v=`java readpro $confpath -g root.areaId`
assertEquals "0" "$v"

}
function testJoinUp4A()
{
v=`java readpro $confpath -g joinUp4A`
assertEquals "1" "$v"

}
function testTask_allPass()
{
v=`java readpro $confpath -g task.allPass`
assertEquals "false" "$v"

}
function testTask_opinion()
{
v=`java readpro $confpath -g task.opinion`
assertEquals "false" "$v"

}
function testTask_archiveInstructions()
{
v=`java readpro $confpath -g task.archiveInstructions`
assertEquals "false" "$v"

}
function testTask_assessmentResults()
{
v=`java readpro $confpath -g task.assessmentResults`
assertEquals "false" "$v"

}
function testSpecifyAudit()
{
v=`java readpro $confpath -g specifyAudit`
assertEquals "0" "$v"

}
function testTaskSubmitGobackRemind()
{
v=`java readpro $confpath -g taskSubmitGobackRemind`
assertEquals "0" "$v"

}
function testIsNYSchema()
{
v=`java readpro $confpath -g isNYSchema`
assertEquals "off" "$v"

}
function testIsAuthKerberos()
{
v=`java readpro $confpath -g isAuthKerberos`
assertEquals "false" "$v"

}
function testAusAuditType()
{
v=`java readpro $confpath -g ausAuditType`
assertEquals "by3ASSO" "$v"

}
function testIsNeedToken()
{
v=`java readpro $confpath -g isNeedToken`
assertEquals "true" "$v"

}
function testReportAuthType()
{
v=`java readpro $confpath -g reportAuthType`
assertEquals "by3ASSO" "$v"

}
function testByAppCode()
{
v=`java readpro $confpath -g byAppCode`
assertEquals "IAP30" "$v"

}
function testIsBaoWangDa()
{
v=`java readpro $confpath -g isBaoWangDa`
assertEquals "false" "$v"

}
function testRdp_replay_byORny()
{
v=`java readpro $confpath -g rdp.replay.byORny`
assertEquals "by" "$v"

}
function testRoot_orgid()
{
v=`java readpro $confpath -g root.orgid`
assertEquals "0" "$v"

}
function testWebServiceSwitch()
{
v=`java readpro $confpath -g webServiceSwitch`
assertEquals "on" "$v"

}
function testWf_isSendNotice()
{
v=`java readpro $confpath -g wf.isSendNotice`
assertEquals "true" "$v"

}
function testWf_noticeType()
{
v=`java readpro $confpath -g wf.noticeType`
assertEquals "sms" "$v"

}
function testWf_isLoadTemplate()
{
v=`java readpro $confpath -g wf.isLoadTemplate`
assertEquals "false" "$v"

}
function testPermission_session()
{
v=`java readpro $confpath -g permission.session`
assertEquals "open" "$v"

}
function testSolr_export_app_num()
{
v=`java readpro $confpath -g solr.export.app.num`
assertEquals "1000" "$v"

}
function testSolr_export()
{
v=`java readpro $confpath -g solr.export`
assertEquals "special" "$v"

}
function testEs_index()
{
v=`java readpro $confpath -g es.index`
assertEquals "app-log-v1" "$v"

}
function testEs_TypeTable()
{
v=`java readpro $confpath -g es.TypeTable`
assertEquals "app-log-" "$v"

}
function testEs_tableCmd()
{
v=`java readpro $confpath -g es.tableCmd`
assertEquals "session-cmd-log-v1/session-cmd-log-" "$v"

}
function testEs_tableSession()
{
v=`java readpro $confpath -g es.tableSession`
assertEquals "session-log-v1/session-log-" "$v"

}
function testClassification_audit_sichuan()
{
v=`java readpro $confpath -g classification.audit.sichuan`
assertEquals "close" "$v"

}
function testImpala_databaseName()
{
v=`java readpro $confpath -g impala.databaseName`
assertEquals "default" "$v"

}
function testIsDislodgeReject()
{
v=`java readpro $confpath -g isDislodgeReject`
assertEquals "off" "$v"

}




. "${SHUNIT2_HOME}/shunit2"
