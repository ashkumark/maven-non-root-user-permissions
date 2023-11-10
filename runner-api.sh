#!/bin/bash

echo "* RUN - sleeping for 180s.. check container"
#sleep 180s
echo "Container  maven-5-api-test-service-run-57a0c7b69c06 created and alive...."

echo "Run automated API tests (using runner script)..."
whoami
pwd
ls -lrt
mvn -version
#chown -R 1001:1001 /home/jenkins

#mvn -f pom.xml test -Dtest=TestRunner -Dcucumber.filter.tags=$TYPE
#mvn clean test -Dtest=TestRunner -Dcucumber.filter.tags=$TYPE
mvn test -Dcucumber.filter.tags=$TYPE
echo "API tests run completed..."

#version 2 - copy target from container to host
#sleep 180s
echo "Check permissions in runner"
pwd
ls -lrt

echo "Copying target to workspace.."
#sleep 180s
#cp -R ./target /var/jenkins_home/*/*/target

#cd target/
#ls -lrt

#version 3
##install docker
#sleep 2s
#echo "Installing docker"
#apt-get update
#apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin --no-install-recommends
docker version
#
#echo "Copy target from docker container to workspace"
#docker cp api-test-container:/home/docker-jenkins-test/target/ ${currentWorkspace}/reports/