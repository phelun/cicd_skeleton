## Setup Jenkins cluster with containers  

1. Setup Jenkins cluster
  - Spin up jenkins master container from your local home machine
    - docker run -d -p 8080:8080 -v $HOME/jenkins_home:/tmp/jenkins_home --name jenkins_master jenkins/jenkins
      - This will download your "jenkins/jenkins:latest" image
      - Then spiins up a container with name jenkins_master  
      - Configure jenkins master from http://192.168.xx.66:8080
    - docker logs jenkins_master # Obtain password
    - Go into GUI first to update your password.

2. Setup jenkins slaves that will be used(spun up) for provisioning
  - Install the plugin that makes ur jenkins cluster a cluster :)
    - Install docker plugin
      - THIS PLUGIN: This plugin integrates Jenkins with Docker # TODO, find a way to install all of this via cmd
  - Enable docker plugin to communicate over API with the docker host(where your master container is running from)
        /usr/lib/systemd/system/docker.service
        ExecStart=/usr/bin/dockerd  -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock
        sudo systemctl daemon-reload
        sudo systemctl restart docker
  - GUI Configurations(Always problematic)
    - Navigate to configure system 
    - Scroll down to bottom of the page, CLOUD section
    - Add a docker cloud 
    - Fill in with below steps
    - Docker Host URI = tcp://172.17.0.1:4243
      Enabled = tick this box
    - Add Docker Template (You can have multilpe of this)
      Labels = random name
      Eanabled = tick this box
      Docker image =  phelun/jslave_with_awscli_terrform_ansible_packer_gradle_java_jre-jdk:tagname
      Remote File System Root = /home/jenkins
      Connect method = Connection with SSH AND non verification strategy
        - Remmeber the just on you dockerfile for the slave image has always being jenkins/jenkins
        - Set SSH credentials to jenkins/jenkins
    - Go to manage nodes from jenkins setting.
        - set master to 	# of executors = 0 # THis will avoid jobs from running on master node
    - Finally for each job you create, you will need to specify which labels to use
        - Restrict where this project can be run = LABEL_NAME
    -

3. Configure AWS credentials
https://support.cloudbees.com/hc/en-us/articles/203802500-Injecting-Secrets-into-Jenkins-Build-Jobs

4. Jenkins Best practices 
https://www.cloudbees.com/blog/top-10-best-practices-jenkins-pipeline-plugin


## Build image from container
Aim: 
    - The steps is used for creating a jenkins container, that will be able to build and image from itself. 
    - This will allow us use the jenkins container for build pipeline and deploypipline.
    - Using label to tell build jobs to use the master container as build 
    - https://getintodevops.com/blog/the-simple-way-to-run-docker-in-docker-for-ci will help you with the steps 

```
apt-get update 
apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common 
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey 
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" 
apt-get update 
apt-get -y install docker-ce
```
