#/bin/bash

docker run --name=scope -d --net=host --pid=host --privileged -v /var/run/docker.sock:/var/run/docker.sock:rw weaveworks/scope:1.9.1 --probe.docker=true

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && sudo apt-get install terraform

mkdir -p /root/jenkins/jenkins_home

cat > /root/jenkins/main.tf << EOF
terraform {
    required_providers {
        docker = {
            source  = "kreuzwerker/docker"
            version = "2.16.0"
        }
    }
}

provider "docker" {
    host = "unix:///var/run/docker.sock"
}

# Pulls the image
resource "docker_image" "jenkins" {
    name = "jenkins/jenkins:latest"
}

# Create a container
resource "docker_container" "jenkins" {
    image = docker_image.jenkins.latest
    name  = "jenkins"
    ports {
        internal = "8080"
        external = "8080"
    }

    volumes {
        container_path = "/var/jenkins_home"
        host_path = "/home/crispy/Projects/terraform/jenkins/jenkins_home"
    }
}
EOF