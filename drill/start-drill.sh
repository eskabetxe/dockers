#!/usr/bin/env bash

CLUSTER_ID=drill_cluster
LOG_DIR=$DRILL_HOME/log

if [[ -z "$ZOOKEEPER" && -n "$HOSTNAME_COMMAND" ]]; then
    export KAFKA_ADVERTISED_HOST_NAME=$(eval $HOSTNAME_COMMAND)
fi


sed -r -i "s/(zk.connect):(.*)/\1: \"$ZOOKEEPER\"/g" /$DRILL_HOME/conf/drill-override.conf
sed -r -i "s/(cluster-id):(.*)/\1: \"$CLUSTER_ID\"/g" /$DRILL_HOME/conf/drill-override.conf

$DRILL_HOME/bin/drillbit.sh --config $DRILL_HOME/conf/ start