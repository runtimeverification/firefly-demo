pipeline {
  parameters { string(name: 'DOCKERHUB_TAG', defaultValue: 'ubuntu-bionic-master', description: 'Tag to use for Firefly Docker image.') }
  agent {
    dockerfile {
      label 'docker'
      additionalBuildArgs "--build-arg USER_ID=\$(id -u) --build-arg GROUP_ID=\$(id -g) --build-arg DOCKERHUB_TAG=${params.DOCKERHUB_TAG}"
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
          firefly launch   -p 8145 --quiet &
          sleep 2
          firefly test
          firefly coverage -p 8145
          firefly close    -p 8145
        '''
      }
    }
  }
}
