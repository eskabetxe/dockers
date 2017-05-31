#!/bin/bash

set -e

if [ "$1" == "jobmanager" ]; then
    echo "Starting Job Manager"
    sed -i -e "s/jobmanager.rpc.address: localhost/jobmanager.rpc.address: ${JOB_MANAGER_RPC_ADDRESS}/g" $FLINK_DIRECTORY/conf/flink-conf.yaml

    echo "config file: " && grep '^[^\n#]' $FLINK_DIRECTORY/conf/flink-conf.yaml
    exec $FLINK_DIRECTORY/bin/jobmanager.sh start-foreground cluster
elif [ "$1" == "taskmanager" ]; then

    sed -i -e "s/jobmanager.rpc.address: localhost/jobmanager.rpc.address: ${JOB_MANAGER_RPC_ADDRESS}/g" $FLINK_DIRECTORY/conf/flink-conf.yaml
    sed -i -e "s/taskmanager.numberOfTaskSlots: 1/taskmanager.numberOfTaskSlots: $(grep -c ^processor /proc/cpuinfo)/g" $FLINK_DIRECTORY/conf/flink-conf.yaml

    echo "Starting Task Manager"
    echo "config file: " && grep '^[^\n#]' $FLINK_DIRECTORY/conf/flink-conf.yaml
    exec $FLINK_DIRECTORY/bin/taskmanager.sh start-foreground
elif [ "$1" == "webclient" ]; then

    sed -i -e "s/jobmanager.rpc.address: localhost/jobmanager.rpc.address: ${JOB_MANAGER_RPC_ADDRESS}/g" $FLINK_DIRECTORY/conf/flink-conf.yaml
    
    echo "Starting Web Client"
    echo "config file: " && grep '^[^\n#]' $FLINK_DIRECTORY/conf/flink-conf.yaml
    exec $FLINK_DIRECTORY/bin/start-webclient.sh.sh start-foreground
fi



exec "$@"