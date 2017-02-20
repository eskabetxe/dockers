#!/usr/bin/env bash

service ssh start

sed -i -r 's|#(log4j.appender.ROLLINGFILE.MaxBackupIndex.*)|\1|g' $ZOOKEEPER_HOME/conf/log4j.properties
sed -i -r 's|#autopurge|autopurge|g' $ZOOKEEPER_HOME/conf/zoo.cfg

$ZOOKEEPER_HOME/bin/zkServer.sh start-foreground