pipeline {
  agent {
    docker {
      image 'node:alpine'
      args '-p 3000:3000'
    }
  }
    stages {
        stage('Build') { 
            steps {
                sh 'pwd'
                sh 'ls'
                sh '${WORKSPACE}/build.sh ${BRANCH_NAME} ${BUILD_NUMBER}' 
            }
        }
    }

  }
