Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"
#!/bin/bash
yum -y update

echo "###################################  grabbing docker-compose file from S3 bucket  #############################"
aws s3api get-object --bucket homelab-applications --key nba-player-guesser/docker-compose.yml docker-compose.yml

echo "###################################  install docker & docker-compose  #############################"
yum -y install docker

curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

# Fix permissions after download
chmod +x /usr/local/bin/docker-compose

echo "###################################  start docker  #############################"
systemctl start docker

echo "###################################  ECR AUTH #############################"
docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 939365853055.dkr.ecr.us-east-1.amazonaws.com/nba-player-guesser-api

# echo "###################################  PULL docker image  #############################"
# docker pull 939365853055.dkr.ecr.us-east-1.amazonaws.com/nba-player-guesser-api:master

# echo "###################################  RUN docker  #############################"
# export PORT="${port}"
# # for bash variable use on yaml:
# # export PORT="${port}"
# envsubst < docker-compose.yml

# docker run --name nba-playersapicontainer -e PORT -p ${port}:${port} 939365853055.dkr.ecr.us-east-1.amazonaws.com/nba-player-guesser-api
# docker ps

export ud_PORT="${port}"
# for bash variable use on yaml:
# envsubst < docker-compose.yml
echo "###################################"
echo "###################################"
echo "$ud_port"
echo "###################################"
echo "###################################"

echo "###################################  RUN DOCKER COMPOSE  #############################"
# docker-compose up
PORT=$ud_PORT docker-compose up
# PORT=$env_PORT docker-compose ps -a
