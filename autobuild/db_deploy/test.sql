CREATE TABLE SMP_UPLOAD_FILE_RECORD ( 
UPLOAD_ID VARCHAR2(64) NOT NULL, 
FILE_NAME VARCHAR2(250), 
LOCAL_DIR VARCHAR2(250), 
FTP_FILE_NAME VARCHAR2(250), 
FTP_DIR VARCHAR2(250), 
STATUS VARCHAR2(128), 
UPLOAD_TIME TIMESTAMP(6), 
ERROR_MESSAGE VARCHAR2(4000) 
);