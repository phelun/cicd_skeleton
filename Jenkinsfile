#!/usr/bin/env groovy

node('misc') {
      stage('Tool Versions') {
        sh "aws --version"
        sh "terraform --version"
        sh "ansible --version"

        deleteDir()
        checkout scm
      }

}
