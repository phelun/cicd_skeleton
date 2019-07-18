#!/usr/bin/env groovy
/**
 Top 10 Jenkins concepts in one script
  1. AWS credentials setup
  2. Parameterized pipeline
  3. Dropdown selection based on requirements
  4. Custom Library Configurations
  5. Slack/email notifications
  6. Integrate with artefactory/s3 bucket
  7. USing github source branch plugin to scan your repo/project on github/bitbucket

  7. - if/else statements
     - switch/case statement
     - try/catch/finally aka exception handlin
     - def
     - return
     - internel variables
     - properties

  8. Taking concept from this guy https://gist.github.com/jonico/e205b16cf07451b2f475543cf1541e70
*/

// Import some library 
import groovy.json.JsonOutput
import groovy.json.JsonSlurper 

// Beautify display
def seperator60 = '\u2739' * 60
def seperator20 = '\u2739' * 20


node('misc') {
      echo "${seperator60}\n${seperator20} Inbuilt tools \n${seperator60}"
      ansiColor('xterm') {
          // Just some echoes to show the ANSI color.
          stage "\u001B[31mI'm Red\u001B[0m Now not"
          checkout scm 
          check_tools_ver() 
          check_branch() 
      }
    

      echo "${seperator60}\n${seperator20} AWS ENV \n${seperator60}"
      check_aws_connection() 
      setup_k8s_kube()

      echo "${seperator60}\n${seperator20} Makefile Introduced \n${seperator60}"
      //stage('Intro to Makefile'){
      //  try {
      //    sh "make test-build"
      //    sh "make calc-compile" 
      //  }
      //  catch (exc) {
      //      echo "Something failed with makefile"
      //  }
      //  check_tools_ver()
      //}
}

// CUSTOM DSL METHODS 
def setup_k8s_kube {
    stage('Prep k8s'){
      withCredentials([usernamePassword(credentialsId: 'cicd-skeleton', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID' )]){
        sh """
           aws eks describe-cluster fmbah01 --region eu-west-1
           aws sts get-caller-identity
           aws eks update-kubeconfig --name fmbah01 --region eu-west-1
           kubectl get nodes 
        """
      }    
    }
}

def check_aws_connection() {
    stage('AWS Creds'){
      withCredentials([usernamePassword(credentialsId: 'cicd-skeleton', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID' )]){
        sh """
           aws ec2 describe-instances --region eu-west-1
        """
      }
    }
}


def check_tools_ver() {
    stage('Checking Tools version'){
        sh "aws --version"
        sh "terraform --version"
        sh "ansible --version"
        sh "kubectl version --client=true"
        sh "helm version -c"
        sh "aws-iam-authenticator help" 

    }
}


def check_branch() {
      stage('DSL syntax'){
        if (env.BRANCH_NAME == 'develop'){
            echo "I am develop branch"
        } else {
            echo "Xren znaet kto vui: I am not develop " //TODO
        }
      }
}

 
