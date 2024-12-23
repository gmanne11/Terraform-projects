#!/bin/bash 
sudo yum update -y && sudo yum install docker -y
sudo systemctl status docker 
sudo usermod -aG docker ex2-user 

docker run -p 8080:80 nginx 