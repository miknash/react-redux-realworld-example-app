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
                sh '${WORKSPACE}/build.sh ${BRANCH_NAME} ${BUILD_NUMBER}' 
            }
        }
        stage('Publish_artifacts'){
            steps{
                withAWS(region:'eu-central-1', credentials:'test-tarik') {
                    s3Upload file:"staging/${BRANCH_NAME}_${BUILD_NUMBER}.tar.gzip", bucket:'tarik-devops-react-artifacts', path:'staging/'
                    s3Upload file:"production/${BRANCH_NAME}_${BUILD_NUMBER}.tar.gzip", bucket:'tarik-devops-react-artifacts', path:'production/'
                }
            }
        }
        stage('Deploy_Staging'){
            steps{
                withAWS(region:'eu-central-1', credentials:'test-tarik'){
                    s3Upload bucket:'tarik-devops-react-staging', includePathPattern:'**/*', workingDir:'staging/build'
                }
            }
        }
    }

  }
