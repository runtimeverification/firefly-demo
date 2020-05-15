pipeline {
  agent none
  options {
    ansiColor('xterm')
  }
  stages {
    stage("Init title") {
      when { changeRequest() }
      steps {
        script {
          currentBuild.displayName = "PR ${env.CHANGE_ID}: ${env.CHANGE_TITLE}"
        }
      }
    }
    stage('Build and Test') {
      agent { dockerfile { dir "jenkins" } }
      when { changeRequest() }
      stages {
        stage('Checkout Firefly') { steps { dir('firefly') { git url: 'git@github.com:runtimeverification/firefly.git' } } }
        stage('Build Firefly') {
          options { timeout(time: 60, unit: 'MINUTES') }
          steps {
            sh '''
              ./firefly-setup.sh
            '''
          }
        }
        stage('Run Firefly') {
          options { timeout(time: 30, unit: 'MINUTES') }
          steps {
            sh '''
              ./firefly-run.sh
            '''
          }
        }
      }
    }
  }
}
