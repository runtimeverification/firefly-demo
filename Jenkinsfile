pipeline {
  agent {
    dockerfile {
      label 'docker'
      additionalBuildArgs '--build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g)'
    }
  }
  options { ansiColor('xterm') }
  stages {
    stage('Init title') {
      when { changeRequest() }
      steps { script { currentBuild.displayName = "PR ${env.CHANGE_ID}: ${env.CHANGE_TITLE}" } }
    }
    stage('Test') {
      options { timeout(time: 5, unit: 'MINUTES') }
      steps {
        sh '''
          npm install
          firefly compile
          firefly launch   -p 8145
          firefly test
          firefly coverage -p 8145
          firefly close    -p 8145
        '''
      }
    }
  }
}
