FROM centos:7

RUN yum remove docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-engine -y

RUN yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2; \
  yum-config-manager \
  --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo; \
  yum install docker-ce docker-ce-cli containerd.io -y

RUN curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; \
  chmod +x /usr/local/bin/docker-compose; \
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

VOLUME [ "/var/run/docker.sock" ]
