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
echo "Validate hub status.."

STATUS=false
selenium_hub=192.168.60.2
port=32001
hub_host_url="http://$selenium_hub:$port/wd/hub"

echo "Loop until the hub status is true.."
while [ $STATUS != true ]
do
 sleep 1
 #STATUS=$(curl -s http://selenium-hub:4444/wd/hub/status | jq -r .value.ready)
 STATUS=$(curl -s http://$selenium-hub:$port/wd/hub/status | jq -r .value.ready)
 echo "Status of Selenium Hub is - $STATUS"
done

# Run tests
#mvn test -Dtest=TestRunnerUI -Dcucumber.filter.tags=$TYPE -DHUB_HOST=$HUB_HOST -DBROWSER=$BROWSER
mvn test -Dtest=TestRunnerUI -Dcucumber.filter.tags=@UI -DHUB_HOST=$hub_host_url -DBROWSER=$BROWSER


#docker ps

echo "List files - shows target"
ls -lrt


