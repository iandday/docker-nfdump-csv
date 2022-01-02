pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'dockerImage = docker.build imagename'
      }
    }

    stage('Deploy') {
      steps {
        sh 'sh'
      }
    }

    stage('Cleanup') {
      steps {
        sh 'docker rmi $imagename:$BUILD_NUMBER'
        sh 'docker rmi $imagename:latest'
      }
    }

  }
  environment {
    imagename = 'ianday/nfdump-csv'
    registryCredential = 'ianday-dockerhub'
    dockerImage = '\'\''
  }
}