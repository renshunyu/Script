#!bin/sh
export LANG=zh_CN.gb18030
export JAVA_HOME=/usr/java/jdk1.6.0_31
export ANT_HOME=/home/aiuap/tools/apache-ant-1.7.1
export HUDSON_HOME=/home/aiuap/ci/hudson_work
export CLASSPATH=.:/usr/java/jdk1.6.0_31/lib:$CLASSPATH
PATH=$JAVA_HOME/bin:$PATH:$HOME/bin:/home/aiuap/tools/apache-ant-1.7.1/bin:
export PATH

sudo cp /home/aiuap/mainConfig.xml /home/aiuap/svnproject/program30/builddir/iap_report_flex/dist/bin/config
sudo chown aiuap30:aiuap /home/aiuap/svnproject/program30/builddir/iap_report_flex/dist/bin/config/mainConfig.xml