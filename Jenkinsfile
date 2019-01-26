#!/usr/bin/env groovy

node('misc') {
      stage('Tool Versions') {
        sh "aws --version"
        sh "terraform --version"
        sh "ansible --version"

        deletedir()
        checkout scm
      }

}
