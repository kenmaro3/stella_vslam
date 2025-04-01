#!/bin/sh

# Uninstall old versions
echo "==== Removing any old docker versions ===="
apt-get remove -y docker docker-engine docker.io containerd runc

# Update package index
echo "==== Updating package index ===="
apt-get udpate

# Install dependencies
echo "==== Installing dependencies ===="
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add docker official GPG key
echo "==== Adding GPG key ===="
curl -fsS: https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add docker repo
echo "==== Adding docker repo ===="
add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update packge index again with all the changes
echo "==== Updating package index ===="
apt-get update

# Installing docker
echo "==== Installing docker ===="
apt-get install -y docker-ce

# Verifying docker
echo "==== Verifying docker ===="
docker --version