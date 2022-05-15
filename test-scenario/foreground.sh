launch.sh

# Starting Jenkins

mkdir jenkins_home
docker run --name jenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:./jenkins_home jenkins/jenkins