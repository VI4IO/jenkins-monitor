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

#### Issues
The docker Jenkins version is behind and the plugins have missing options in the web interface. As such editing the configuration using the website will break the set up. If  this happens, for ESDM, add ```<pattern>build/Testing/**/Test.xml</pattern>``` under ```<ctesttype>``` in the project's config.xml file and select ```reload configuration from disk``` from ```manage jenkins``` in the Jenkins menu.


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

### Adding ESDM and IOR
```
cp -r ./docker/jenkins/jobs/* /var/lib/jenkins/jobs/
chown -R jenkins:jenkins /var/lib/jenkins/jobs/
service jenkins restart
```
### Setting up jenkins
Get the set-up password
```
cat /var/lib/jenkins/secrets/initialAdminPassword 
```
Visit localhost:8081
 * Enter set-up password
 * Select "Install suggested plugins"
 
After jenkins is configured:
 * Manage Jenkins > Manage Plugins > Availiable
 * Search and install "dashboard-view", "plot", "github", "xunit", "ws-cleanup", "performance", "postbuild-task"
 
Optional:
In the configuration page of each job, in execute shell remove the wget and chmod commands.
 
## Configuring the dashboard

[Dashboard view guide]( https://wiki.jenkins.io/display/JENKINS/Dashboard+View)

To create a new view, visit: {jenkins-url}/user/admin/my-views/newView

### Using the preset
Insert the contents of [dashboard.xml](dashboard.xml) in ./var/lib/jenkins/config.xml after the node
```
<hudson.model.AllView>
  <owner class="hudson" reference="../../.."/>
  <name>all</name>
  <filterExecutors>false</filterExecutors>
  <filterQueue>false</filterQueue>
  <properties class="hudson.model.View$PropertyList"/>
</hudson.model.AllView>
<!-- --
Insert here
<!-- -->
```
 
