#!/bin/bash
docker pull jenkins/jenkins:lts
docker build --tag jenkins-monitor/jenkins docker
