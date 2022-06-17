FROM golang:1.16-alpine as builder

# Build
ARG GOPROXY=https://mirrors.aliyun.com/goproxy/
ARG CGO_ENABLED=0
ARG GOOS=linux
COPY src /usr/src
RUN cd /usr/src/ && go build -o gobackup

FROM golang:1.16-alpine

COPY --from=builder /usr/src/gobackup /usr/local/bin/
# Set backup schedule
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh 

# Run the command on container startup
CMD /startup.sh && crond -f -l 8
