FROM jenkins/jenkins:2.230

ADD . /opt
WORKDIR /opt

ENV COMPOSE_VERSION=1.25.5 \
    FINGER_PRINT=0EBFCD88

USER root

# get docker ce
RUN apt-get -y update \
    && apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common acl \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && apt-key fingerprint $FINGER_PRINT \
    && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" \
    && apt-get -y update \
    && apt-get -y install docker-ce docker-ce-cli containerd.io

# get docker compose
RUN curl -L "https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# post install to docker on linux
RUN usermod -aG docker jenkins

# start on boot
RUN systemctl enable docker

USER jenkins
