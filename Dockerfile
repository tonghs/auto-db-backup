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
	&& apt-get install tar mysql-client cron tzdata -y \
	&& apt-get autoremove && apt-get autoclean \
	&& ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& dpkg-reconfigure --frontend noninteractive tzdata \
	&& touch /var/log/cron.log \
	&& rm -rf /var/lib/apt-get/lists/* \
	&& rm -rf /root/.cache

# Run the command on container startup
CMD /startup.sh && cron && tail -f /var/log/cron.log
