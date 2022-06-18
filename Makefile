.PHONY: build publish run

build:
	sudo docker build . -t gobackup
	sudo docker image tag gobackup tonghs/gobackup:latest

publish:
	sudo docker push tonghs/gobackup -a


run:
	sudo docker-compose up
