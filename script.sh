#!/bin/bash
sudo yum update -y docker
sudo amazon-linux-extras install docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
sudo docker run --name docker-nginx -p 8080:80 nginx
                            