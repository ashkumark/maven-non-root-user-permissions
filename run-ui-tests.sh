#!/bin/bash

export HOST_UID_GID=$JENKINS_USER_ID:$JENKINS_GROUP_ID

# Remove Previous Stack
docker-compose -f docker-compose-api.yaml rm -f

# Starting new stack environment
echo "* RUN UI tests using ${BROWSER}"
#docker-compose -f docker-compose-ui.yaml run -e TYPE="@UI" -e BROWSER="chrome" -u ${HOST_UID_GID} ui-test-service
#docker-compose -f docker-compose-ui.yaml run -e TYPE="@UI" -e BROWSER="firefox" -u ${HOST_UID_GID} ui-test-service

docker-compose -f docker-compose-ui.yaml run -e TYPE="@UI" -e BROWSER=${BROWSER} -u ${HOST_UID_GID} ui-test-service

echo "service - status.."
docker-compose -f docker-compose-api.yaml ps