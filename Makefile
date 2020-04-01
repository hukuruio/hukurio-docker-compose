PREFIX=hukuruio
IMAGE=docker-compose:local

default: build test
.PHONY: build test

docker_login:
	sh utils/docker_login.sh

build: 
	docker build -t $(IMAGE) .

test:
	docker-compose up -d
	inspec exec profiles/docker -t docker://docker-compose --chef-license=accept-silent
	docker-compose down -v

release: docker_login
	docker tag $(IMAGE) $(PREFIX)/$(IMAGE):latest
	docker push $(PREFIX)/$(IMAGE):latest
