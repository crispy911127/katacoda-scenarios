#/bin/bash

docker run --name=scope -d --net=host --pid=host --privileged -v /var/run/docker.sock:/var/run/docker.sock:rw weaveworks/scope:1.9.1 --probe.docker=true

curl -L -O https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip

unzip terraform_1.1.9_linux_amd64.zip

mkdir -p /root/jenkins/jenkins_home

mv terraform /usr/bin

rm terraform*

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