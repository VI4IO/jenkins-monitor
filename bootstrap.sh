#!/bin/bash
docker build --tag jenkins-monitor/jenkins docker
docker run -p 8080:8080 -p 50000:50000 jenkins-monitor/jenkins

