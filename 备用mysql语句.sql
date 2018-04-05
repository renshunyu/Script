use iap;
--truncate table IAP_ORI_APP_LOG_201703;
select * from IAP_ORI_APP_LOG_201701;
select * from IAP_ORI_APP_LOG_201702 limit 1;
select * from IAP_ORI_APP_LOG_201702 t order by t.OPERATE_TIME;
select count(1) from IAP_ORI_APP_LOG_201703;
delete from IAP_ORI_APP_LOG_201703 limit 428290;
select count(1) from IAP_ORI_APP_LOG_201704;
delete from IAP_ORI_APP_LOG_201704 limit 100000;
select count(1) from IAP_ORI_APP_LOG_201705;
delete from IAP_ORI_APP_LOG_201705 limit 100000;
select count(1) from IAP_ORI_APP_LOG_201706;
delete from IAP_ORI_APP_LOG_201706 limit 100000;
select * from IAP_ORI_APP_LOG_201703;
SELECT floor(RAND() * 30) +1; 
select concat('2017-02-',floor(RAND() * 30)+1,' ',floor(RAND() * 22)+1,':',floor(RAND() * 58)+1,':',floor(RAND() * 58)+1)

insert into IAP_ORI_APP_LOG_201702
select UUID() as LOG_ID,
       IDENTITY_NAME,
       RESOURCE_KIND,
       RESOURCE_CODE,
       replace(IDR_CREATION_TIME,'2017-01','2017-02') as IDR_CREATION_TIME,
       MAIN_ACCOUNT_NAME,
       SUB_ACCOUNT_NAME,
       replace(OPERATE_TIME,'2017-01-01',concat('2017-02-',floor(RAND() * 27) +1)) as OPERATE_TIME,
       OP_TYPE_ID,
       OP_TYPE_NAME,
       OP_LEVEL_ID,
       OPERATE_CONTENT,
       OPERATE_RESULT,
       MODULE_ID,
       MODULE_NAME,
       TASK_CODE,
       CLIENT_NETWORK_ADDRESS,
       CLIENT_NAME,
       CLIENT_ADDRESS,
       CLIENT_MAC,
       CLIENT_CPU_SERIAL,
       CLIENT_PORT,
       SERVER_MAC,
       SERVER_PORT,
       SERVER_ADDRESS,
       FROM_PROVINCES_ID,
       FROM_PROVINCES_NAME,
       TO_PROVINCES_ID,
       TO_PROVINCES_NAME,
       IS_LOGIN_BYFOURA,
       BANKAPPROVE,
       BANKFLAG,
       replace(ORI_GATHER_TIME,'2017-01','2017-02') as ORI_GATHER_TIME,
       ORI_FILE_NAME,
       ORI_FILE_ROWNUM,
       RECHECK_DATA_ID,
       LOGRANDOMNO,
       replace(ORI_CREATE_TIME,'2017-01-01',concat('2017-02-',floor(RAND() * 27) +1)) as ORI_CREATE_TIME,
       CLIENT_BOIS_SERIAL,
       HARD_DISK_SERIAL,
       RETAIN1,
       RETAIN2,
       RETAIN3,
       RETAIN4,
       RETAIN5,
       RETAIN6,
       RETAIN7,
       RETAIN8,
       RETAIN9,
       RETAIN10 from IAP_ORI_APP_LOG_201701 t;



insert into IAP_ORI_APP_LOG_201703
select UUID() as LOG_ID,
       IDENTITY_NAME,
       RESOURCE_KIND,
       RESOURCE_CODE,
       concat('2017-03-',floor(RAND() * 30)+1,' ',floor(RAND() * 22)+1,':',floor(RAND() * 58)+1,':',floor(RAND() * 58)+1) as IDR_CREATION_TIME,
       MAIN_ACCOUNT_NAME,
       SUB_ACCOUNT_NAME,
       concat('2017-03-',floor(RAND() * 30)+1,' ',floor(RAND() * 22)+1,':',floor(RAND() * 58)+1,':',floor(RAND() * 58)+1) as OPERATE_TIME,
       OP_TYPE_ID,
       OP_TYPE_NAME,
       OP_LEVEL_ID,
       OPERATE_CONTENT,
       OPERATE_RESULT,
       MODULE_ID,
       MODULE_NAME,
       TASK_CODE,
       CLIENT_NETWORK_ADDRESS,
       CLIENT_NAME,
       CLIENT_ADDRESS,
       CLIENT_MAC,
       CLIENT_CPU_SERIAL,
       CLIENT_PORT,
       SERVER_MAC,
       SERVER_PORT,
       SERVER_ADDRESS,
       FROM_PROVINCES_ID,
       FROM_PROVINCES_NAME,
       TO_PROVINCES_ID,
       TO_PROVINCES_NAME,
       IS_LOGIN_BYFOURA,
       BANKAPPROVE,
       BANKFLAG,
       concat('2017-03-',floor(RAND() * 30)+1,' ',floor(RAND() * 22)+1,':',floor(RAND() * 58)+1,':',floor(RAND() * 58)+1) as ORI_GATHER_TIME,
       ORI_FILE_NAME,
       ORI_FILE_ROWNUM,
       RECHECK_DATA_ID,
       LOGRANDOMNO,
       concat('2017-03-',floor(RAND() * 30)+1,' ',floor(RAND() * 22)+1,':',floor(RAND() * 58)+1,':',floor(RAND() * 58)+1) as ORI_CREATE_TIME,
       CLIENT_BOIS_SERIAL,
       HARD_DISK_SERIAL,
       RETAIN1,
       RETAIN2,
       RETAIN3,
       RETAIN4,
       RETAIN5,
       RETAIN6,
       RETAIN7,
       RETAIN8,
       RETAIN9,
       RETAIN10 from IAP_ORI_APP_LOG_201702 t;

select concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60));
insert into `IAP_ORI_APP_LOG_201703` (`LOG_ID`, `IDENTITY_NAME`, `RESOURCE_KIND`, `RESOURCE_CODE`, `IDR_CREATION_TIME`, `MAIN_ACCOUNT_NAME`, `SUB_ACCOUNT_NAME`, `OPERATE_TIME`, `OP_TYPE_ID`, `OP_TYPE_NAME`, `OP_LEVEL_ID`, `OPERATE_CONTENT`, `OPERATE_RESULT`, `MODULE_ID`, `MODULE_NAME`, `TASK_CODE`, `CLIENT_NETWORK_ADDRESS`, `CLIENT_NAME`, `CLIENT_ADDRESS`, `CLIENT_MAC`, `CLIENT_CPU_SERIAL`, `CLIENT_PORT`, `SERVER_MAC`, `SERVER_PORT`, `SERVER_ADDRESS`, `FROM_PROVINCES_ID`, `FROM_PROVINCES_NAME`, `TO_PROVINCES_ID`, `TO_PROVINCES_NAME`, `IS_LOGIN_BYFOURA`, `BANKAPPROVE`, `BANKFLAG`, `ORI_GATHER_TIME`, `ORI_FILE_NAME`, `ORI_FILE_ROWNUM`, `RECHECK_DATA_ID`, `LOGRANDOMNO`, `ORI_CREATE_TIME`, `CLIENT_BOIS_SERIAL`, `HARD_DISK_SERIAL`, `RETAIN1`, `RETAIN2`, `RETAIN3`, `RETAIN4`, `RETAIN5`, `RETAIN6`, `RETAIN7`) 
values
(UUID(),'4AAthLog','1','UAP',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'lijinze','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1-AIUAP-10027','系统退出',NULL,'lijinze，退出登录！','0','','','','10.1.69.70,192.168.193.1,192.168.93.1','','10.1.69.70','50:B7:C3:16:74:D5,00:50:56:C0:00:01,00:50:56:C0:00:08,50:B7:C3:16:74:D6,E8:03:9A:E1:83:4B,72:B7:C3:16:74:D5','BFF0003690A36154D7','','','','','','','','','','','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'TCP-XML201712050912339.dat','1','120fc36b-bce2-412a-9d28-50f7b20582f6','1',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','','','','','','','',''),
(UUID(),'4AAthLog','1','UAP',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'lijinze','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1-AIUAP-10000','系统登录',NULL,'登录成功！登录IP：10.1.69.70，客户端IP[10.1.69.70, 192.168.193.1, 192.168.93.1]，客户端MAC[50:B7:C3:16:74:D5, 00:50:56:C0:00:01, 00:50:56:C0:00:08, 50:B7:C3:16:74:D6, E8:03:9A:E1:83:4B, 72:B7:C3:16:74:D5]，#[#强认证方式=无强认证#]#','0','','','','10.1.69.70,192.168.193.1,192.168.93.1','','10.1.69.70','50:B7:C3:16:74:D5,00:50:56:C0:00:01,00:50:56:C0:00:08,50:B7:C3:16:74:D6,E8:03:9A:E1:83:4B,72:B7:C3:16:74:D5','BFF0003690A36154D7','','','40303','10.1.198.67','','','','','','','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'TCP-XML201712051512604.dat','1','9caa10a3-f6d1-41fd-80c3-4cbe6d7c7218','5',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'undefined','WD-WX31A24A0654','','','','','','',''),
(UUID(),'4AAthLog','1','UAP',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'admin','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1-AIUAP-10058','认证中心锁屏操作',NULL,'锁屏操作成功，登录主帐号：admin！','0','','','','10.1.69.70,192.168.193.1,192.168.93.1','','10.1.69.70','50:B7:C3:16:74:D5,00:50:56:C0:00:01,00:50:56:C0:00:08,50:B7:C3:16:74:D6,E8:03:9A:E1:83:4B,72:B7:C3:16:74:D5','BFF0003690A36154D7','','','40303','10.1.198.67','','','','','','','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'TCP-XML201712061012891.dat','1','af53a8e8-6cd6-49a9-8a9b-c48265c836d0','0',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'undefined','WD-WX31A24A0654','','','','','','',''),
(UUID(),'4AIAPLog','1','AIIAP',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','ycyz1',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1-AIIAP-30110','选中快速链接查询',NULL,'选中快速链接列表查询成功！详细信息为:[com.asiainfo.a4.iap.workspace.entity.IapWorkSpaceLinkData@14172b7, com.asiainfo.a4.iap.workspace.entity.IapWorkSpaceLinkData@4443fcfb, com.asiainfo.a4.iap.workspace.entity.IapWorkSpaceLinkData@777a295, com.asiainfo.a4.iap.workspace.entity.IapWorkSpaceLinkData@754d9c4d, com.asiainfo.a4.iap.workspace.entity.IapWorkSpaceLinkData@7f939c99, com.asiainfo.a4.iap.workspace.entity.IapWorkSpaceLinkData@246c03b4]','0','','','','','','10.1.52.134','','','','','9030','10.1.198.53','','','','','','','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1512529592258.dat','0','f6d0204c-f4e1-4498-a3d3-4e3b0e7c4f2d','7',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','','','','','','','',''),
(UUID(),'4AIAPLog','1','AIIAP',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','ycyz2',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1-AIIAP-30106','选中报表列表查询',NULL,'选中报表列表查询成功！详细信息为:[com.asiainfo.a4.iap.workspace.entity.IapWorkSpaceReportData@3cba7593, com.asiainfo.a4.iap.workspace.entity.IapWorkSpaceReportData@79b8fc60, com.asiainfo.a4.iap.workspace.entity.IapWorkSpaceReportData@5fab40b2, com.asiainfo.a4.iap.workspace.entity.IapWorkSpaceReportData@488b4232, com.asiainfo.a4.iap.workspace.entity.IapWorkSpaceReportData@2772a05d]','0','','','','','','10.1.52.134','','','','','9030','10.1.198.53','','','','','','','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1512529592262.dat','0','f5107738-5742-44b5-8545-bf25229c9618','8',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','','','','','','','',''),
(UUID(),'4AIAPLog','1','AIIAP',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','ycwg1',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1-AIIAP-30109','策略个数任务数查询',NULL,'策略个数任务数查询成功！详细信息为:','0','','','','','','10.1.52.134','','','','','9030','10.1.198.53','','','','','','','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1512529592265.dat','0','d95dc03e-758f-4ba2-9eed-945fabe2c489','8',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','','','','','','','',''),
(UUID(),'4AIAPLog','1','AIIAP',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','xqyz',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1-AIIAP-30115','审计任务最新、即将超时、超时、待办日周月查询',NULL,'审计任务最新、即将超时、超时、待办日周月查询成功！详细信息为:{permissions=1, waitMonth=3, waitWeek=2, newNum=0, waitDay=7, pastNum=0, timeOut=12}','0','','','','','','10.1.52.134','','','','','9030','10.1.198.53','','','','','','','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1512529592268.dat','0','c1f7e12b-bdc8-4fd2-a5f5-6089fac3db15','7',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','','','','','','','',''),
(UUID(),'4AIAPLog','1','AIIAP',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','xxyz',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1-AIIAP-30101','个人工作台告警信息查询',NULL,'查询个人告警信息成功！','0','','','','','','10.1.52.134','','','','','9030','10.1.198.53','','','','','','','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1512529592271.dat','0','1d9cb4dd-942a-44e4-9af1-f6aad0f29193','7',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','','','','','','','',''),
(UUID(),'4AIAPLog','1','AIIAP',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','xq5jyz',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1-AIIAP-3001001','访问标准化策略',NULL,'访问标准化策略操作成功！','0','','','','','','10.1.52.60','','','','','9030','10.1.198.53','','','','','','','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1512529592274.dat','0','52520c34-7600-4f42-971f-c8ff1bf8c638','4',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','','','','','','','',''),
(UUID(),'4AIAPLog','1','AIIAP',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','ycwg2',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1-AIIAP-30010113','检索日志完整性策略',NULL,'检索日志完整性策略操作成功！','0','','','','','','10.1.52.60','','','','','9030','10.1.198.53','','','','','','','',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'1512529592276.dat','0','7d50d18b-c23f-4536-9fcb-d7fd3aa766d9','8',concat('2017-03-',floor(RAND() * 31)+1,' ',floor(RAND() * 24),':',floor(RAND() * 60),':',floor(RAND() * 60)),'','','','','','','','','');
