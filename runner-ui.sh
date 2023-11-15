#!/bin/bash

echo "* RUN .. check container"
echo "Container  *-ui-test-service-run-* created and alive...."

echo "Run automated UI tests (using runner script)..."

whoami
pwd
ls -lrt
mvn -version

docker ps

echo "Browser - $BROWSER"
echo "Validate $HUB_HOST status.."

STATUS=false

echo "Loop until the hub status is true.."
while [ $STATUS != true ]
do
 sleep 1
 STATUS=$(curl -s http://selenium-hub:4444/wd/hub/status | jq -r .value.ready)
 echo "Status of Selenium Hub is - $STATUS"
done

# Run tests
mvn -f pom.xml test -Dtest=TestRunner -Dcucumber.filter.tags=$TYPE -DHUB_HOST=$HUB_HOST -DBROWSER=$BROWSER


docker ps

echo "List files - shows target"
ls -lrt


