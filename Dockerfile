FROM golang:1.16-alpine as builder

# Build
ARG GOPROXY=https://mirrors.aliyun.com/goproxy/
ARG CGO_ENABLED=0
ARG GOOS=linux
COPY src /usr/src
RUN cd /usr/src/ && go build -o gobackup

FROM ubuntu:22.04

COPY --from=builder /usr/src/gobackup /usr/local/bin/

# Set backup schedule
COPY startup.sh /startup.sh

ENV DEBIAN_FRONTEND=noninteractive
RUN chmod +x /startup.sh && apt-get update \
	&& touch /var/log/cron.log \
	&& apt-get install -y \
        tar mysql-client postgresql-client \
        redis-tools cron tzdata curl \
    && curl -Lo /tmp/mongodb-tools.deb https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2004-x86_64-100.5.3.deb \
    && apt-get install /tmp/mongodb-tools.deb \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt-get autoremove && apt-get clean autoclean \
    && rm -rf /var/lib/apt-get/lists/* \
    && rm -rf /root/.cache \
    && rm -rf /tmp/*

# Run the command on container startup
CMD /startup.sh && cron && tail -f /var/log/cron.log
