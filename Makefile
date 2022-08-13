USERNAME = vshender

.PHONY: all up down build docker_login \
	build_ui build_comment build_post build_prometheus build_mongodb_exporter build_blackbox_exporter build_fluentd \
	push_ui push_comment push_post push_prometheus push_mongodb_exporter push_blackbox_exporter push_fluentd


all: build


up: build
	cd docker && docker-compose up -d

down:
	cd docker && docker-compose down


build: build_ui build_comment build_post build_prometheus build_mongodb_exporter build_blackbox_exporter build_fluentd

build_ui:
	cd src/ui && USER_NAME=${USERNAME} bash docker_build.sh

build_comment:
	cd src/comment && USER_NAME=${USERNAME} bash docker_build.sh

build_post:
	cd src/post-py && USER_NAME=${USERNAME} bash docker_build.sh

build_prometheus:
	cd monitoring/prometheus && docker build -t ${USERNAME}/prometheus .

build_mongodb_exporter:
	cd monitoring/mongodb && docker build -t ${USERNAME}/mongodb-exporter .

build_blackbox_exporter:
	cd monitoring/blackbox && docker build -t ${USERNAME}/blackbox-exporter .

build_fluentd:
	cd logging/fluentd && docker build -t ${USERNAME}/fluentd .


docker_login:
	docker login


push: push_ui push_comment push_post push_prometheus push_mongodb_exporter push_blackbox_exporter push_fluentd

push_ui: docker_login
	docker push ${USERNAME}/ui

push_comment: docker_login
	docker push ${USERNAME}/comment

push_post: docker_login
	docker push ${USERNAME}/post

push_prometheus: docker_login
	docker push ${USERNAME}/prometheus

push_mongodb_exporter: docker_login
	docker push ${USERNAME}/mongodb-exporter

push_blackbox_exporter: docker_login
	docker push ${USERNAME}/blackbox-exporter

push_fluentd: docker_login
	docker push ${USERNAME}/fluentd
