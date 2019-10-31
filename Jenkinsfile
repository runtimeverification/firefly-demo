pipeline {
  options {
    ansiColor('xterm')
  }
  stages {
    stage("Init title") {
      when {
        changeRequest()
        beforeAgent true
      }
      steps {
        script {
          currentBuild.displayName = "PR ${env.CHANGE_ID}: ${env.CHANGE_TITLE}"
        }
      }
    }
    stage('Build Solidity') {
      dockerfile {
        additionalBuildArgs '--build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g)'
      }
      when {
        changeRequest()
        beforeAgent true
      }
      steps {
        sh '''
          make solc-compile
        '''
      }
    }
  }
}
