# Jenkins Performance Regression Monitor

 [Installing without docker](#installing-without-docker)

## Installing with docker
Also see: [Jenkins Docker documentation]( https://github.com/jenkinsci/docker)

Build Image:
```
docker build --tag jenkins-monitor/jenkins docker
```
Run:
```
docker run -p 8080:8080 -p 50000:50000 jenkins-monitor/jenkins
```

#### Startup guide
1. The inital admin password is displayed on first startup. It can also be found within the docker container at ```/var/jenkins_home/secrets/initialAdminPassword```.
2. Click on the cross on the top right or select "Select Plugins to Install" and install additonal plugins

### Issues

ESDM: If the project configuration is changed using the Jenkins web interface, add ```<pattern>build/Testing/**/Test.xml</pattern>``` under ```<ctesttype>``` in the project's config.xml file and select ```reload configuration from disk``` from ```manage jenkins``` in the Jenkins menu.


## Installing without docker
### Installing jenkins
```
apt intall gnupg2 default-jre
```
Add the key to the Jenkins repository to your system:
```
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
```
Then add the following entry in your /etc/apt/sources.list:
```
deb https://pkg.jenkins.io/debian binary/
```
Update your local package index, then finally install Jenkins:
```
sudo apt-get update
sudo apt-get install jenkins
```
Get the set-up password
```
cat /var/lib/jenkins/secrets/initialAdminPassword 
```
Visit localhost:8081
 * Enter set-up password
 * Select "Install suggested plugins"
After jenkins is configured:
 * Manage Jenkins > Manage Plugins > Availiable
 * Search and install "dashboard-view", "plot", "xunit", "ws-cleanup", "performance", "postbuild-task"
 

### Adding ESDM and IOR
TODO
