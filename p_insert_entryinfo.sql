create or replace procedure p_insert_entryinfo
as
       i_sql varchar2(4000);
       i_table varchar2(64);
       i_org varchar2(20);
       i_date varchar2(6);
       i_check number(1);
       cursor mycursor
  is
  select distinct a.org_id from iap30.v_uap_organization a where a.PARENT_ID=0;
begin
       i_date:=to_char(sysdate-1,'YYYY')||to_char(sysdate-1,'MM');
       open mycursor;
       loop
         fetch mycursor into i_org;
          exit when  mycursor%notfound;
           i_table:='IAP_APP_LOG_'||i_date||'_'||i_org;
            select count(*) into i_check from user_tables a where a.TABLE_NAME=i_table;
            --DBMS_OUTPUT.put_line(i_check||i_table);
          if i_check=0 then
	          continue;
          end if;

       i_sql:='INSERT INTO iap_reports_entryinfo  select a.log_id, a.domain_id, 
a.person_name, a.person_area_id, a.person_area_name, a.person_org_id, 
a.person_org_name, a.person_status_id, a.person_status as op_person_status, 
a.main_acct_id as op_main_acct_id, a.main_acct_name, a.main_acct_status_id, 
a.main_acct_status, a.client_ip, a.client_mac, a.server_ip, a.audit_level_id, 
a.audit_level_name, a.operate_type_id, a.operate_type_name, 
iap30.subContent(a.operate_content,''主帐号ID'') as beop_main_acct_id, 
a.operate_result, a.operate_time, a.is_work_time, a.is_work_day, 
a.person_duty_id, a.person_duty_name, a.client_network_address, a.log_source, 
a.is_author_others, a.bank_isneed, a.bank_isopen, a.level2_org_id, 
a.level2_org_name, a.std_create_time, a.std_begin_time, a.ori_create_time, 
a.ori_file_name, a.ori_file_rownum, a.ori_gather_time, a.recheck_data_id, 
a.acct_type as op_acct_type, a.remark as op_remark, a.effect_time as op_effect_time,
 a.expire_time as op_expire_time, b.main_acct_id as main_acct_id, 
b.login_name,b.login_pwd,b.pwd_question,b.pwd_answer,b.authen_rule_id,b.lock_status,b.lock_type,b.lock_desc,b.lock_main_acct_id,b.lock_time, 
b.pwd_type,b.pwd_wrong_times,b.pwd_update_time,b.effect_time,b.expire_time,b.last_login_time,b.create_time,b.last_update_time,b.work_no,b.area_id,b.pwd_rule_id,b.name, 
b.gender,b.birth_date,b.id_card_no,b.education,b.mobile,b.email,b.oa_email,b.tel,
b.staff_no,b.person_status,b.staff_type,b.remark,b.join_date,b.contract_expire_date,b.default_org, 
b.acct_type,b.acct_position,b.is_approve,b.nationality,b.default_sequence,b.cardtype,b.cardvalue,b.administrative_position,b.upd_work_no,b.del_work_no, 
c.ORG_ID,c.PARENT_ID,c.ORG_CODE,c.ORG_NAME,c.ORG_DESC,c.SORT_NO,c.ORG_LEVEL,c.NETFLAG,
c.CREATE_TIME as  ORG_CREATE_TIME,c.LAST_UPDATE_TIME as ORG_LAST_UPDATE_TIME,c.IS_PN_ONLY from  '||i_table||'  a 
,iap30.v_uap_main_acct b ,iap30.v_uap_organization c where 
iap30.subContent(a.operate_content,''主帐号ID'')=b.main_acct_id and 
b.default_org=c.ORG_ID and a.domain_id=''UAP'' and a.operate_type_id=''1-AIUAP-20021'' 
and not exists (select 1 from iap30.iap_reports_entryinfo t where t.log_id=a.log_id)';
       P_INSERT_REPORTDATA (i_sql);
       commit;
       end loop;
       close mycursor;

       --i_org:='33720000';
end;


--入职人员信息汇总与统计
begin
	iap30.p_insert_entryinfo();
	iap30.p_iap_entryvalue();
end;
commit;
