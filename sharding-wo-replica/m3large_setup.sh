#!/bin/sh
sudo apt-get update
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install mongodb-org
mkdir -p /data /log /journal
sudo chown -R mongodb:mongodb /data /log /journal
sudo yum install -y sysstat
sudo ln -s /journal /data/journal
