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

### Startup instructions
1. The inital admin password is displayed on first startup. It can also be found within the docker container at ```/var/jenkins_home/secrets/initialAdminPassword```.
2. Select "Install Selected Plugins"
3. Select None and continue

## Issues

ESDM: If the project configuration is changed using the Jenkins web interface, add ```<pattern>build/Testing/**/Test.xml</pattern>``` under ```<ctesttype>``` in the project's config.xml file and select ```reload configuration from disk``` in the Jenkins menu.
