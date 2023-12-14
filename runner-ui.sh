#!/bin/sh

echo "* RUN .. check container"
echo "Container  *-ui-test-service-run-* created and alive...."

echo "Run automated UI tests (using runner script)..."

#whoami
pwd
ls -lrt
mvn -version

#docker ps

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
#mvn test -Dtest=TestRunnerUI -Dcucumber.filter.tags=$TYPE -DHUB_HOST=$HUB_HOST -DBROWSER=$BROWSER
mvn test -Dtest=TestRunnerUI -Dcucumber.filter.tags=@UI -DHUB_HOST=$SE_EVENT_BUS_HOST -DBROWSER="chrome"


#docker ps

echo "List files - shows target"
ls -lrt


