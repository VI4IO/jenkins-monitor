# Jenkins Performance Regression Monitor
Also see: [Jenkins Docker documentation]( https://github.com/jenkinsci/docker)

Build Image:
```
docker build --tag jenkins-monitor/jenkins docker
```
Run:
```
docker run -p 8080:8080 -p 50000:50000 jenkins-monitor/jenkins
```
The inital admin password is displayed on first startup. It can also be found within the docker container at ```/var/jenkins_home/secrets/initialAdminPassword```.
