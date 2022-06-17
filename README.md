# gobackup-docker

基于 [GoBackup](https://github.com/huacnlee/gobackup) 的 database 计划备份 docker 镜像。

```bash
sudo docker run --name gobackup -e 'BAK_SCHEDULE=* * * * *' -v <your-gobackup.yml-parent-path>:/etc/gobackup/ -d tonghs/gobackup:latest
```


## build
docker build . -t gobackup

### 环境变量
`BAK_SCHEDULE`

备份周期，参考 crontab 格式，比如：`0 13 * * *`

### 配置文件（gobackup.yml 所在的文件夹）
- /conf/:/etc/gobackup/


## docker compose
```yml
version: "3"
services:
  gobackup:
    restart: always
    container_name: gobackup
    image: tonghs/gobackup:latest

    environment:
      - BAK_SCHEDULE=* * * * *

    volumes:
      - ./conf/:/etc/gobackup/
      - ./data/backups/:/data/backups/
```
