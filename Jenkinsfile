pipeline {
  environment {
    imagename = 'ianday/nfdump-csv'
    registryCredential = 'ianday-dockerhub'
    dockerImage = '\'\''
  }
  agent any
  stages {
    stage('Build') {
      steps {
        script {
          dockerImage = docker.build imagename
        }
      }
    }

    stage('Deploy Image') {
                steps{
                    script {
                        docker.withRegistry( '', registryCredential ) {
                            dockerImage.push("$BUILD_NUMBER")
                            dockerImage.push('latest')

                        }
                    }
                }
            }

    stage('Cleanup') {
      steps {
        sh 'docker rmi $imagename:$BUILD_NUMBER'
        sh 'docker rmi $imagename:latest'
      }
    }

  }
  
}
