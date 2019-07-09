# Jenkins Performance Regression Monitor

Build Image:
docker build --tag jenkins-monitor/jenkins docker
Run:
docker run -p 8080:8080 -p 50000:50000 jenkins-monitor/jenkins
