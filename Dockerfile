# syntax=docker/dockerfile:1

# Importing base image Ubuntu
FROM --platform=linux/amd64 ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

# Updating and Upgrading Ubuntu
RUN apt-get -y update && apt-get -y upgrade

# Installing Basic Packages & Utilities in Ubuntu
RUN apt-get -y install software-properties-common vim cron wget curl man-db build-essential libtool autoconf uuid-dev pkg-config ssh openssh-server openssh-client openssl

# Clear cache
RUN apt-get clean

# Jenkins Prerequisites
RUN apt search openjdk

# Install Java as prerequisite for jenkins
RUN apt-get -y install openjdk-17-jre

# Get Jenkins related stuff
RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
RUN echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]  https://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Get Grafana related stuff
RUN mkdir -p /etc/apt/keyrings/
RUN wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null
RUN echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee -a /etc/apt/sources.list.d/grafana.list
#echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | tee -a /etc/apt/sources.list.d/grafana.list

# Updating packages
RUN apt-get update

# Install Jenkins
RUN apt-get -y install jenkins

# Install Grafana
RUN apt-get -y install grafana-enterprise

# Start jenkins
RUN service jenkins start

# Expose port 8080 for jenkins
EXPOSE 8080

# Start Grafana
#RUN systemctl daemon-reload
RUN systemctl enable grafana-server
#RUN service grafana-server start
#RUN service grafana-server status

# Check the status of service
RUN ps -ef | grep grafana
RUN ps -ef | grep jenkins

# Expose port 3000 for Grafana
EXPOSE 3000

# COPY startup script
COPY start_services.sh .