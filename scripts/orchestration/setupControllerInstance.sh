#!/bin/bash
## get DSA installed
wget https://app.deepsecurity.trendmicro.com:443/software/agent/amzn1/x86_64/ -O /tmp/agent.rpm --quiet
rpm -ihv /tmp/agent.rpm
/opt/ds_agent/dsa_control -r
## set appropriate dsm url and tid/tpw
#/opt/ds_agent/dsa_control -a dsm://agents.deepsecurity.trendmicro.com:443/ "tenantID:12345678-abcd-1234-abcd-XXXXXXXXXXXX" "tenantPassword:12345678-abcd-1234-abcd-XXXXXXXXXXXX" "policyname:Linux Server"

sudo yum -y install git
sudo yum -y install jq
sudo yum -y install perl-XML-Twig
sudo yum -y install libunwind libicu

cd /home/ec2-user/
git clone https://github.com/424D57/tmThreatChallenge.git
chown -R ec2-user:ec2-user tmThreatChallenge
mkdir .aws
touch .aws/config
chown -R ec2-user:ec2-user .aws
echo "[default]" > .aws/config
region=$(curl http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')
echo "region = ${region}" >> .aws/config
##todo: aws create-key-pair threatChallengeKeyPair for DSM and team instances
##todo: setup bashrc

