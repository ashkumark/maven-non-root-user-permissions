pipeline {
    agent any
    //agent { label 'jenkins-agent' }
    
    environment {
    	//uri = '518637836680.dkr.ecr.eu-west-2.amazonaws.com/ashkumarkdocker/docker-e2e-automation'
    	//registryCredential = '518637836680'
    	dockerImage = ''
        currentWorkspace = ''
    }

    stages {
        stage('Build Image') {
            steps {
                script {
                        dockerImage = docker.build("ashkumarkdocker/docker-e2e-automation")
                }
            }
        }
        stage('API Automation') {
        	agent {
                docker {
                    image 'ashkumarkdocker/docker-e2e-automation'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
                script {
                    currentWorkspace = "$WORKSPACE"
                    echo "Current workspace is ${currentWorkspace}"
                }
            	sh 'mvn test -Dcucumber.filter.tags="@API"'
            }
        }
        stage('Generate HTML report') {
            steps {
                cucumber buildStatus: '',
                        reportTitle: 'Cucumber report',
                        fileIncludePattern: '**/*.json',
                        //jsonReportDirectory: "./target",
                        jsonReportDirectory: "${currentWorkspace}/target",
                        trendsLimit: 10,
                        classifications: [
                                [
                                        'key'  : 'API',
                                        'value': 'API'
                                ]
                        ]
            }
        }
        /*stage('Push Image') {
            steps {
                script {     
                   docker.withRegistry("https://" + uri, "ecr:eu-west-2:" + registryCredential) {
                         dockerImage.push()
				   }				       
				}
             }
        }*/
    }

    post {
        always {
            // publish html
            publishHTML target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: "${currentWorkspace}/target/Reports/",
                    reportFiles: 'automated-test-report.html',
                    reportName: 'Extent Test Report'
            ]
            publishHTML target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: false,
                    keepAll: true,
                    reportDir: "${currentWorkspace}/target/cucumber-html-report/",
                    reportFiles: 'regression-tests.html',
                    reportName: 'Cucumber Test Report'
            ]
        }
    }

}