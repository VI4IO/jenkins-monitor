#!/bin/bash

cd $(dirname $0)
pwd
IMG=$(docker ps|grep jenkins-monitor/jenkins|cut -d " " -f 1)
if [[ $IMG != "" ]] ; then
  docker stop $IMG
fi

docker run -d --rm -p 8080:8080 -p 50000:50000 -v $PWD/docker/jenkins/:/var/jenkins_home jenkins-monitor/jenkins
