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
    stage('Test with truffle') {
      options { timeout(time: 5, unit: 'MINUTES') }
      steps {
        sh '''
          npm install
          firefly compile
          firefly launch   -p 8145 --quiet --shutdownable --respond-to-notifications &
          sleep 2
          npx truffle test
          firefly coverage -p 8145
          firefly close    -p 8145
        '''
      }
    }
    stage('Test with buidler') {
      options { timeout(time: 5, unit: 'MINUTES') }
      steps {
        sh '''
          npm install
          firefly compile
          firefly launch   -p 8145 --quiet --shutdownable --respond-to-notifications &
          sleep 2
          npx buidler --network localhost test
          firefly coverage -p 8145
          firefly close    -p 8145
        '''
      }
    }
    stage('Update Firefly Submodule') {
      when { branch 'master' }
      environment { LONG_REV = """${sh(returnStdout: true, script: 'git rev-parse HEAD').trim()}""" }
      steps {
        build job: 'rv-devops/master', propagate: false, wait: false                                                 \
            , parameters: [ booleanParam ( name: 'UPDATE_DEPS'         , value: true                               ) \
                          , string       ( name: 'UPDATE_DEPS_REPO'    , value: 'runtimeverification/firefly-demo' ) \
                          , string       ( name: 'UPDATE_DEPS_VERSION' , value: "${env.LONG_REV}")                   \
                          ]
      }
    }
  }
}
