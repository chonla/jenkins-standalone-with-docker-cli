# Dockerized Jenkins with pre-installed Docker cli

## What have I done in this image?

* Pre-installed Docker cli.
* Bypass setup wizard

## To initialize user/password for Jenkins

Pass those values to `JENKINS_USERNAME` and `JENKINS_PASSWORD` in environment variables.

## To pre-install plugins

```
FROM chonla/jenkins-docker-cli:latest

ADD ./ref /opt
WORKDIR /opt

EXPOSE 8080

# Install plugins
RUN /usr/local/bin/install-plugins.sh < /opt/plugins.txt
```