# docker compose redis cluster

[TOC]

## 1、create redis config、data path

```bash
$: python3 docker_compose_redis_cluster_config.py
$: tree
.
├── 7001
│   ├── data
│   └── redis.conf
├── 7002
│   ├── data
│   └── redis.conf
├── 7003
│   ├── data
│   └── redis.conf
├── 7004
│   ├── data
│   └── redis.conf
├── 7005
│   ├── data
│   └── redis.conf
├── 7006
│   ├── data
│   └── redis.conf
├── README.md
├── create_cluster.sh
├── docker-compose.yml
└── docker_compose_redis_cluster_config.py
```

redis.conf 为 redis 的配置文件，data 为映射数据目录。


## 2、start redis docker nodes

```
$: docker-compose up -d
Creating network "redis_cluster_redis_cluster_net" with driver "bridge"
Recreating redis-cluster-6 ... done
Recreating redis-cluster-1 ... done
Recreating redis-cluster-3 ... done
Recreating redis-cluster-4 ... done
Recreating redis-cluster-2 ... done
Recreating redis-cluster-5 ... done
```

报错加上 `--force-recreates`

## 3、create redis cluster

```
$: sh create_cluster.sh 
Start redis cluster nodes meet
redis meet 7002 port  OK
redis meet 7003 port  OK
redis meet 7004 port  OK
redis meet 7005 port  OK
redis meet 7006 port  OK
End redis cluster nodes meet

Start config redis cluster announce ip
OK
OK
OK
OK
OK
OK
OK
OK
OK
OK
OK
OK
End config redis cluster announce ip

Start config redis cluster slots
OK
OK
OK
End config redis cluster slots

Start config redis cluster replicate
OK
OK
OK
End config redis cluster replicate
```

## 4、test redis cluster

```
$: redis-cli -h 127.0.0.1 -p 7001 -c
redis> get a
-> Redirected to slot [15495]
redis> get b
-> Redirected to slot [3300]
redis> get c
-> Redirected to slot [7365]
```

It's OK!