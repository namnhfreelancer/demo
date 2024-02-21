#!/bin/bash
# Install sudo
apt install sudo
usermod -aG sudo thudo-vn
sudo apt update && sudo apt upgrade -y
# Install Essential packages
sudo apt install build-essential -y
sudo apt install software-properties-common
sudo apt update
# Install OpenSSH
sudo apt install openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh
 hostname -I
#  Nvidia driver + Cuda
wget https://developer.download.nvidia.com/compute/cuda/12.3.2/local_installers/cuda-repo-debian11-12-3-local_12.3.2-545.23.08-1_amd64.deb
sudo dpkg -i cuda-repo-debian11-12-3-local_12.3.2-545.23.08-1_amd64.deb
sudo cp /var/cuda-repo-debian11-12-3-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo add-apt-repository contrib
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-3
sudo apt-get install -y cuda-drivers
# Docker
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Speedtest
docker run --rm robinmanuelthiel/speedtest:latest
sudo chmod +x /etc/profile.d/proxy.sh
source /etc/profile.d/proxy.sh
env | grep -i proxy
#Proxy
sudo vim /etc/profile.d/proxy.sh
# Io.net
