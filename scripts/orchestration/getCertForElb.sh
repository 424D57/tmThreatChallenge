#!/bin/bash
dsmFqdn=${1}
curl -O https://dl.eff.org/certbot-auto
chmod a+x certbot-auto
Stage=$(cat /home/ec2-user/variables/Stage)

# If we are creating a production environment...
if [ "$Stage" = "prod" ]; then
  # create an official certificate...
  ./certbot-auto --debug certonly --webroot -w /usr/share/nginx/html/ -d ${dsmFqdn} --non-interactive --agree-tos --register-unsafely-without-email
else
  # else use the let's encrypt staging environment
  ./certbot-auto --staging --debug certonly --webroot -w /usr/share/nginx/html/ -d ${dsmFqdn} --non-interactive --agree-tos --register-unsafely-without-email
fi
sudo chown -R ec2-user:ec2-user /etc/letsencrypt
aws iam delete-server-certificate --server-certificate-name ${dsmFqdn}
uploadResponse=$(aws iam upload-server-certificate --server-certificate-name ${dsmFqdn} --certificate-body file:///etc/letsencrypt/archive/${dsmFqdn}/cert1.pem --private-key file:///etc/letsencrypt/archive/${dsmFqdn}/privkey1.pem)
arn=$(echo $uploadResponse | jq -r .ServerCertificateMetadata.Arn)
echo $arn > /home/ec2-user/variables/certArn
sudo cp /etc/letsencrypt/archive/${dsmFqdn}/fullchain1.pem /etc/pki/ca-trust/source/anchors/
sudo update-ca-trust
