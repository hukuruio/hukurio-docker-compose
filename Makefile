IMAGE=docker-compose:local

default: dependencies build test
.PHONY: dependencies build test

build: 
	docker build -t $(IMAGE) .

test:
	docker-compose up -d
	inspec exec profiles/docker -t docker://docker-compose
	docker-compose down -v

# release:
# 	./scripts/release.sh $(IMAGE) $(TAG)

# clean:
# 	docker rmi -f $(IMAGE)
