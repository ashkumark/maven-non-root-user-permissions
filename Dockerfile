
FROM ghcr.io/carlossg/maven:3.9.5-eclipse-temurin-17

ENV user=jenkins
ENV group=jenkins
ENV uid=1001
ENV gid=1001
ENV JENKINS_HOME=/home/$user
ENV WORKING_DIR=/usr/src/test-project

RUN mkdir -p $JENKINS_HOME

WORKDIR $WORKING_DIR
COPY src $WORKING_DIR/src
COPY pom.xml $WORKING_DIR
COPY runner-api.sh $WORKING_DIR
COPY run-api-tests.sh $WORKING_DIR

#Basic Utils
RUN apt-get update
RUN apt-get install -y wget curl jq unzip sudo tar acl apt-transport-https ca-certificates software-properties-common --no-install-recommends

RUN groupadd $group -g $gid \
    && useradd -m $user -u $uid -g $gid -d $JENKINS_HOME

RUN usermod -aG sudo ${user}

RUN chown -R $user:$group $JENKINS_HOME $WORKING_DIR
RUN chmod -R ug+rwx $JENKINS_HOME $WORKING_DIR

RUN mkdir -p /usr/share/maven/.m2
RUN groupadd $group -g $gid \
    && useradd -m $user -u $uid -g $gid -d /usr/share/maven/.m2

#Docker - https://docs.docker.com/engine/api/
ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 23.0.6
ENV DOCKER_API_VERSION 1.42
RUN curl -k -fsSL "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
  | tar -xzC /usr/local/bin --strip=1 docker/docker

RUN groupadd docker
RUN usermod -aG docker ${user}

#Docker compose - https://docs.docker.com/compose/release-notes/
ENV DOCKER_COMPOSE_VERSION v2.23.0
RUN curl -k -fsSL "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64" \
    -o /usr/local/bin/docker-compose

#RUN curl -fsSL "https://sourceforge.net/projects/docker-compose.mirror/files/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64/download"  \
#    -o /usr/local/bin/docker-compose

RUN chown -R $user:$group /usr/local/bin/docker-compose
RUN chmod ug+x /usr/local/bin/docker-compose

USER ${user}

