# auto-db-backup

基于 [GoBackup](https://github.com/huacnlee/gobackup) 的 database 计划备份 docker 镜像。


## build
docker build . -t <you image name>

### 环境变量
`BAK_SCHEDULE`
备份周期，参考 crontab 格式

### 配置文件
- host: /conf/gobackup.yml - container: /etc/gobackup/gobackup.yml


## docker compose
```yml
version: "3"
services: 
 auto-sqlback:
  restart: always
  container_name: auto-sqlbak
  image: tonghs/gobackup:latest

  environment:
    - BAK_SCHEDULE=* * * * *

  volumes: 
    - ./conf/:/etc/gobackup/
    - ./data/backups/:/data/backups/
```
