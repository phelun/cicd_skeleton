#!/usr/bin/env groovy
/**
 Top 10 Jenkins concepts in one script
  1. AWS credentials setup
  2. Parameterized pipeline
  3. Dropdown selection based on requirements
  4. Custom Library Configurations
  5. Slack/email notifications
  6. Integrate with artefactory/s3 bucket
*/

// Beautify display
def seperator60 = '\u2739' * 60
def seperator20 = '\u2739' * 20

node('misc') {
      echo "${seperator60}\n${seperator20} Inbuilt tools \n${seperator60}"

      ansiColor('xterm') {
          // Just some echoes to show the ANSI color.
          stage "\u001B[31mI'm Red\u001B[0m Now not"
      }

      stage('Tool Versions') {
        checkout scm
        shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
        sh "aws --version"
        sh "terraform --version"
        sh "ansible --version"
      }

      echo "${seperator60}\n${seperator20} AWS ENV \n${seperator60}"
      stage('AWS Creds'){
        withCredentials([usernamePassword(credentialsId: 'cicd-skeleton', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID' )]){
        sh """
           aws ec2 describe-instances --region eu-west-1
        """
        }
      }

      // echo "${seperator60}\n${seperator20} Terraform Build|Wait|Destroy Instance\n${seperator60}"
      // stage('Terraform Res.'){
      //   withCredentials([usernamePassword(credentialsId: 'cicd-skeleton', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]){
      //     sh """
      //        cd ./terraform_infra
      //        terraform init
      //        terraform plan -out=create.tfplan
      //        terraform apply create.tfplan
      //        sleep 45s
      //        terraform destroy -force
      //     """
      //   }
      //
      // }
}
