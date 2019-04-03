#!/bin/bash

# iptables Monitoring
grep filter /proc/net/ip_tables_names  > /dev/null 2>&1
isAlive=$?

iptablesStatus=`cat /tmp/iptablesMonitoringHealth`

# Check iptables Life or Dead
if [ $isAlive -eq 0 ] ; then
    # logger -t iptablesMonitoring testOK
    echo OK > /tmp/iptablesMonitoringHealth
    exit 0
else
    # /var/log/messages

    if [ $iptablesStatus = OK ]; then
        logger -t iptablesMonitoring iptablesDown!

        # do something

        # status Change
        echo NG > /tmp/iptablesMonitoringHealth
        exit 0
    else
        logger -t iptablesMonitoring iptablesDownAlso
        exit 1
    fi
fi
