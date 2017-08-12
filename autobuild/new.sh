#!bin/sh
cd /home/aiuap/svnproject/program30/builddir/ap_validate_server/

mvn -v 

mvn clean package -Dmaven.test.skip=true >./build.log
