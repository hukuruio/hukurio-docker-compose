FROM centos:7

ARG DOCKER_COMPOSE_VERSION="1.25.0"
ARG INSPEC_PKG="https://packages.chef.io/files/stable/inspec/4.18.39/el/7/inspec-4.18.39-1.el7.x86_64.rpm"

RUN yum remove docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-engine -y; \
  yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2; \
  yum-config-manager \
  --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo; \
  yum install docker-ce docker-ce-cli containerd.io -y; \
  curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; \
  chmod +x /usr/local/bin/docker-compose; \
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose; \
  yum install -y ${INSPEC_PKG}; \
  yum install -y make; \
  yum clean all

COPY scripts/test.sh /tmp/test.sh

VOLUME [ "/var/run/docker.sock" ]

