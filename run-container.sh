#!/bin/bash

cd $(dirname $0)
pwd
docker run -d --rm -p 8080:8080 -p 50000:50000 -v $PWD/docker/jenkins/:/var/jenkins_home jenkins-monitor/jenkins
