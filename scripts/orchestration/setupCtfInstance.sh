#!/bin/bash

dsmT0Password=$(cat /home/ubuntu/variables/t0AdminPassword)
baseDomain=$(cat /home/ubuntu/variables/baseDomain)
eventName=$(cat /home/ubuntu/variables/eventName)
GitHubCtfUsername=$(cat /home/ec2-user/variables/GitHubCtfUsername)
GitHubCtfRepoName=$(cat /home/ec2-user/variables/GitHubCtfRepoName)

cd /home/ubuntu/
apt-get update
apt-get -y install git
git clone https://github.com/${GitHubCtfUsername}/${GitHubCtfRepoName}.git fbctf
chown -R ubuntu:ubuntu fbctf
cd fbctf
export HOME=/root
./extra/provision.sh -m prod -c certbot -D ctf.${eventName}.${baseDomain} -e admin@${baseDomain} -s $PWD
source ./extra/lib.sh
set_password ${dsmT0Password} ctf ctf fbctf $PWD
