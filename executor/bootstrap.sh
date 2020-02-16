#!/bin/bash

azkaban_dir=$(dirname $0)/..

# Specifies location of azkaban.properties, log4j.properties files
# Change if necessary
conf=$azkaban_dir/conf

azkaban()
{
    if [[ -z "$tmpdir" ]]; then
    tmpdir=/tmp
    fi

    for file in $azkaban_dir/lib/*.jar;
    do
    CLASSPATH=$CLASSPATH:$file
    done

    for file in $azkaban_dir/extlib/*.jar;
    do
    CLASSPATH=$CLASSPATH:$file
    done

    for file in $azkaban_dir/plugins/*/*.jar;
    do
    CLASSPATH=$CLASSPATH:$file
    done

    if [ "$HADOOP_HOME" != "" ]; then
            echo "Using Hadoop from $HADOOP_HOME"
            CLASSPATH=$CLASSPATH:$HADOOP_HOME/conf:$HADOOP_HOME/*
            JAVA_LIB_PATH="-Djava.library.path=$HADOOP_HOME/lib/native/Linux-amd64-64"
    else
            echo "Error: HADOOP_HOME is not set. Hadoop job types will not run properly."
    fi

    if [ "$HIVE_HOME" != "" ]; then
            echo "Using Hive from $HIVE_HOME"
            CLASSPATH=$CLASSPATH:$HIVE_HOME/conf:$HIVE_HOME/lib/*
    fi

    echo $azkaban_dir;
    echo $CLASSPATH;

    executorport=`cat $conf/azkaban.properties | grep executor.port | cut -d = -f 2`
    echo "Starting AzkabanExecutorServer on port $executorport ..."
    serverpath=`pwd`

    if [[ -z "$AZKABAN_OPTS" ]]; then
    AZKABAN_OPTS="-Xmx3G"
    fi
    # Set the log4j configuration file
    if [ -f $conf/log4j.properties ]; then
    AZKABAN_OPTS="$AZKABAN_OPTS -Dlog4j.configuration=file:$conf/log4j.properties -Dlog4j.log.dir=$azkaban_dir/logs"
    else
    echo "Exit with error: $conf/log4j.properties file doesn't exist."
    exit 1;
    fi
    AZKABAN_OPTS="$AZKABAN_OPTS -server -Dcom.sun.management.jmxremote -Djava.io.tmpdir=$tmpdir -Dexecutorport=$executorport -Dserverpath=$serverpath"

    java $AZKABAN_OPTS $JAVA_LIB_PATH -cp $CLASSPATH azkaban.execapp.AzkabanExecutorServer -conf $conf $@
}

activate()
{
        echo "Waiting executor to be ready"
        executorport=`cat $conf/azkaban.properties | grep executor.port | cut -d = -f 2`
        while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:$executorport/executor\?action=ping)" != "200" ]]; do sleep 1; done
        echo "Activating worker"
        curl -G "localhost:$executorport/executor?action=activate" && echo
}

echo "Searching for AZK_ environment variable"
compgen -A variable AZK_ | while read v; do
    TARGET_PROPERTIES=$(echo ${v:4} | tr '[:upper:]' '[:lower:]' | tr '_' '.')
    echo "Replacing $TARGET_PROPERTIES to properties";
    grep -q $TARGET_PROPERTIES $conf/azkaban.properties && sed -i "s/\($TARGET_PROPERTIES=\).*\$/\1${!v}/" $conf/azkaban.properties || \
    echo "$TARGET_PROPERTIES=${!v}" >> $conf/azkaban.properties
done

echo "Searching for GLOBAL_ environment variable"
compgen -A variable GLOBAL_ | while read v; do
    TARGET_PROPERTIES=$(echo ${v:4} | tr '[:upper:]' '[:lower:]' | tr '_' '.')
    echo "Replacing $TARGET_PROPERTIES to global properties";
    grep -q $TARGET_PROPERTIES $conf/global.properties && sed -i "s/\($TARGET_PROPERTIES=\).*\$/\1${!v}/" $conf/global.properties || \
    echo "$TARGET_PROPERTIES=${!v}" >> $conf/global.properties
done

activate &

echo "Starting Azkaban Process"
azkaban