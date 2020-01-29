
IMAGE=docker-compose:local

default: build test
.PHONY: build test

build: 
	docker build -t $(IMAGE) .

test:
	docker-compose up -d
	inspec exec profiles/docker -t docker://docker-compose --chef-license=accept-silent
	docker-compose down -v
