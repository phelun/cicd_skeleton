#!/usr/bin/env groovy
/**
 Top 10 Jenkins concepts in one script
  1. AWS credentials setup
  2. Parameterized pipeline
  3. Dropdown selection based on requirements
  4. Custom Library Configurations
  5. Slack/email notifications
  6.
*/

// Beautify display
def seperator60 = '\u2739' * 60
def seperator20 = '\u2739' * 20

node('misc') {
      echo "${seperator60}\n${seperator20} Inbuilt tools \n${seperator60}"
      stage('Tool Versions') {
        sh "aws --version"
        sh "terraform --version"
        sh "ansible --version"
      }

}
