#!/bin/bash

dsmT0Password=$(cat /home/ubuntu/variables/t0AdminPassword)
baseDomain=$(cat /home/ubuntu/variables/baseDomain)
eventName=$(cat /home/ubuntu/variables/eventName)
GitHubCtfUsername=$(cat /home/ubuntu/variables/GitHubCtfUsername)
GitHubCtfRepoName=$(cat /home/ubuntu/variables/GitHubCtfRepoName)
Stage=$(cat /home/ubuntu/variables/Stage)

cd /home/ubuntu/
apt-get update
apt-get -y install git
git clone https://github.com/${GitHubCtfUsername}/${GitHubCtfRepoName}.git fbctf
chown -R ubuntu:ubuntu fbctf
cd fbctf
export HOME=/root

# If we are creating a production environment...
if [ "$Stage" = "prod"]; then
  # get an official certificate from let's encrypt...
  Certificate="certbot"
else
  # else use a self signed certificate
  Certificate="self"
fi

./extra/provision.sh -m prod -c ${Certificate} -D ctf.${eventName}.${baseDomain} -e admin@${baseDomain} -s $PWD
source ./extra/lib.sh
set_password ${dsmT0Password} ctf ctf fbctf $PWD
