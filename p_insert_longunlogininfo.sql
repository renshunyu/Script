create or replace procedure p_insert_longunlogininfo
as
       i_sql varchar2(1000); 
 
begin
       delete from iap30.iap_reports_longunlogininfo;
       i_sql:='INSERT INTO iap30.iap_reports_longunlogininfo
select a.*,null from aiuap20.uap_main_acct a where sysdate-90 > a.last_login_time';
-- and to_char(a.last_login_time,''yyyy-mm'')=to_char(sysdate-90,''yyyy-mm'')
-- and  not exists (select 1 from iap30.iap_reports_longunlogininfo b where a.main_acct_id=b.main_acct_id and to_char(a.last_login_time,''yyyy-mm'')=to_char(sysdate-90,''yyyy-mm''))' ;
       P_INSERT_REPORTDATA(i_sql);
       commit;
    
end;


--Ö´ÐÐ
begin
	iap30.p_insert_longunlogininfo();
end;

begin
iap30.p_iap_longunlonginvalue();
end;
