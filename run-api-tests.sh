#!/bin/sh

export HOST_UID_GID=$JENKINS_USER_ID:$JENKINS_GROUP_ID
echo "User/Group ID - ${HOST_UID_GID}"
# JOB_NAME is the name of the project of this build. This is the name you gave your job. It is set up by Jenkins

#COMPOSE_ID=${JOB_NAME}
#echo $COMPOSE_ID
#
## Remove Previous Stack
#docker-compose -p $COMPOSE_ID rm -f
#
## Starting new stack environment
#docker-compose -p $COMPOSE_ID -f docker-compose-api.yaml up -d --no-color --build
#
#echo "* UP - sleeping for 180s.. check containers and target folder"
#sleep 180s
#
#docker-compose -p $COMPOSE_ID -f docker-compose-api.yaml run -e TYPE="@API" -u ${HOST_UID_GID} api-test-service
#
#echo "* RUN - sleeping AGAIN for 180s.. check containers and target folder"
#sleep 180s
#
##docker-compose -p $COMPOSE_ID -f docker-compose-api.yaml run -e TYPE="@API" -u ${HOST_UID_GID} api-test-service --name "api"
##docker exec api bash
##chown -R $JENKINS_USER_ID:$JENKINS_GROUP_ID /home/jenkins
##exit
#
#echo "Project Name - service - status.."
#docker-compose -p $COMPOSE_ID ps -a


# Remove Previous Stack
docker-compose -f docker-compose-api.yaml rm -f

# Starting new stack environment
#docker-compose -f docker-compose-api.yaml up -d -v /var/run/docker.sock:/var/run/docker.sock --no-color --build
#docker-compose -f docker-compose-api.yaml ps
#echo "* UP - sleeping for 180s.. check container"
#sleep 180s

#echo "Container maven-5-api-test-service-1 created and exits.... (using project image created in previous stage)"

#mkdir -p /home/jenkins/target
#chown -R ${HOST_UID_GID} /home/jenkins/target
#chmod -R ug+rwx /home/jenkins/target

echo "* RUN "
docker-compose -f docker-compose-api.yaml run -e TYPE="@API" -u ${HOST_UID_GID} api-test-service
#docker-compose -f docker-compose-api.yaml run -e TYPE="@API" -u ${HOST_UID_GID} --entrypoint="./runner-api.sh" api-test-service
#docker-compose -f docker-compose-api.yaml run --rm -e TYPE="@API" -u ${HOST_UID_GID} --entrypoint="./runner-api.sh" -v "$PWD/target:/home/jenkins/target" api-test-service
#docker-compose -f docker-compose-api.yaml ps
#docker-compose -f docker-compose-api.yaml run --rm -e TYPE="@API" -u ${HOST_UID_GID} --project-directory="/var/jenkins_home/workspace/maven-6" --entrypoint="./runner-api.sh" api-test-service
#docker-compose -f docker-compose-api.yaml run --rm -e TYPE="@API" -u 1001:1001 --project-directory="/var/jenkins_home/workspace/maven-6" --entrypoint="./runner-api.sh" api-test-service

#docker-compose --project-directory "/var/jenkins_home/workspace/maven-6" -f docker-compose-api.yaml -p api-project run -d --entrypoint="./runner-api.sh" api-test-service

#docker-compose -f /var/jenkins_home/workspace/maven-9/docker-compose-api.yaml run --rm -e TYPE="@API" -u ${HOST_UID_GID} --entrypoint="./runner-api.sh" api-test-service

#docker-compose -f docker-compose-api.yaml run --rm -e TYPE="@API" -u ${HOST_UID_GID} --entrypoint="./runner-api.sh" -v "$PWD:/home/jenkins" -v "$HOME/.m2:/root/.m2" -v "$PWD/target:/home/jenkins/target" api-test-service

#docker-compose -p $COMPOSE_ID -f docker-compose-api.yaml run -e TYPE="@API" -u ${HOST_UID_GID} api-test-service --name "api"
#docker exec api bash
#chown -R $JENKINS_USER_ID:$JENKINS_GROUP_ID /home/jenkins
#exit

echo "service - status.."
docker-compose -f docker-compose-api.yaml ps