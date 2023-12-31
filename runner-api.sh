#!/bin/sh

echo "* RUN .. check container"
echo "Container  *-api-test-service-run-* created and alive...."

echo "Run automated API tests (using runner script)..."

#whoami
pwd
ls -lrt
mvn -version

#docker ps
#chown -R 1001:1001 /home/jenkins

#mvn -f pom.xml test -Dtest=TestRunner -Dcucumber.filter.tags=@API
#mvn clean test -Dtest=TestRunner -Dcucumber.filter.tags=$TYPE
mvn test -Dtest=TestRunnerAPI -Dcucumber.filter.tags=@API
#mvn test -Dcucumber.filter.tags=@API
echo "API tests run completed..."

#docker ps

#version 2 - copy target from container to host

echo "List files - shows target"
ls -lrt

#echo "Copying target to workspace.."
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
#docker version

#echo "Copy target from docker container to workspace"
#sleep 180s

#docker cp api-container:/target /var/jenkins_home/*/*/target
#docker cp api-container:target .
