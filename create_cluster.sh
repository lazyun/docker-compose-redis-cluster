#! /bin/bash

ipaddr=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
node1=`redis-cli -h 127.0.0.1 -p 7001 cluster nodes | grep 7001 | awk '{print $1}'`
node2=`redis-cli -h 127.0.0.1 -p 7002 cluster nodes | grep 7002 | awk '{print $1}'`
node3=`redis-cli -h 127.0.0.1 -p 7003 cluster nodes | grep 7003 | awk '{print $1}'`

echo "Start redis cluster nodes meet"
echo "redis meet 7002 port " `redis-cli -h 127.0.0.1 -p 7001 CLUSTER MEET 202.112.14.12 7002`
echo "redis meet 7003 port " `redis-cli -h 127.0.0.1 -p 7001 CLUSTER MEET 202.112.14.13 7003`
echo "redis meet 7004 port " `redis-cli -h 127.0.0.1 -p 7001 CLUSTER MEET 202.112.14.14 7004`
echo "redis meet 7005 port " `redis-cli -h 127.0.0.1 -p 7001 CLUSTER MEET 202.112.14.15 7005`
echo "redis meet 7006 port " `redis-cli -h 127.0.0.1 -p 7001 CLUSTER MEET 202.112.14.16 7006`
echo "End redis cluster nodes meet\n"

echo "Start config redis cluster announce ip"
redis-cli -h 127.0.0.1 -p 7001 CONFIG SET cluster-announce-ip $ipaddr
redis-cli -h 127.0.0.1 -p 7001 CONFIG REWRITE

redis-cli -h 127.0.0.1 -p 7002 CONFIG SET cluster-announce-ip $ipaddr
redis-cli -h 127.0.0.1 -p 7002 CONFIG REWRITE

redis-cli -h 127.0.0.1 -p 7003 CONFIG SET cluster-announce-ip $ipaddr
redis-cli -h 127.0.0.1 -p 7003 CONFIG REWRITE

redis-cli -h 127.0.0.1 -p 7004 CONFIG SET cluster-announce-ip $ipaddr
redis-cli -h 127.0.0.1 -p 7004 CONFIG REWRITE

redis-cli -h 127.0.0.1 -p 7005 CONFIG SET cluster-announce-ip $ipaddr
redis-cli -h 127.0.0.1 -p 7005 CONFIG REWRITE

redis-cli -h 127.0.0.1 -p 7006 CONFIG SET cluster-announce-ip $ipaddr
redis-cli -h 127.0.0.1 -p 7006 CONFIG REWRITE
echo "End config redis cluster announce ip\n"

sleep 5s
echo "Start config redis cluster slots"
redis-cli -h 127.0.0.1 -p 7001 CLUSTER ADDSLOTS {0..5462}
redis-cli -h 127.0.0.1 -p 7002 CLUSTER ADDSLOTS {5463..10925}
redis-cli -h 127.0.0.1 -p 7003 CLUSTER ADDSLOTS {10925..16383}
echo "End config redis cluster slots\n"

sleep 5s
echo "Start config redis cluster replicate"
redis-cli -h 127.0.0.1 -p 7004 CLUSTER REPLICATE $node1
redis-cli -h 127.0.0.1 -p 7005 CLUSTER REPLICATE $node2
redis-cli -h 127.0.0.1 -p 7006 CLUSTER REPLICATE $node3
echo "End config redis cluster replicate\n"
