#!/bin/bash
# Install sudo
apt install sudo
usermod -aG sudo thudo-vn
sudo apt update && sudo apt upgrade -y
# Enable Internet line 2
ip link
read -p "Enter port name: " port_name
echo "allow-hotplug $port_name
iface $port_name inet dhcp" | sudo tee -a /etc/network/interfaces > /dev/null
echo "Sucess add port $port_name to /etc/network/interfaces, please 'ifup $port_name' later"
# ifup enp6s0
# Change hostname
read -p "Enter Hostname: " new_hostname
echo
sudo hostnamectl set-hostname "$new_hostname"
sudo sed -i "s/127.0.1.1.*/127.0.1.1\t$new_hostname/g" /etc/hosts
echo $new_hostname | sudo tee /etc/hostname
echo "Hostname changed to $new_hostname"
# Install Essential packages
sudo apt install build-essential -y
sudo apt install software-properties-common -y
sudo apt-get install linux-headers-$(uname -r) -y
sudo apt update
# Install OpenSSH
sudo apt install openssh-server -y
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
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
# Speedtest
sudo docker run --rm robinmanuelthiel/speedtest:latest

#Proxy
# read -p "Enter proxy IP: " proxy_ip
# read -p "Enter proxy port: " proxy_port
# read -p "Enter proxy user: " proxy_user
# read -sp "Enter proxy password: " proxy_pass
# echo

# export http_proxy="http://$proxy_user:$proxy_pass@$proxy_ip:$proxy_port/"
# export https_proxy="https://$proxy_user:$proxy_pass@$proxy_ip:$proxy_port/"
# export ftp_proxy="ftp://$proxy_user:$proxy_pass@$proxy_ip:$proxy_port/"
# export no_proxy="localhost,127.0.0.1,::1"

# echo "http_proxy=\"http://$proxy_user:$proxy_pass@$proxy_ip:$proxy_port/\"" | sudo tee -a /etc/environment
# echo "https_proxy=\"https://$proxy_user:$proxy_pass@$proxy_ip:$proxy_port/\"" | sudo tee -a /etc/environment
# echo "ftp_proxy=\"ftp://$proxy_user:$proxy_pass@$proxy_ip:$proxy_port/\"" | sudo tee -a /etc/environment
# echo "no_proxy=\"localhost,127.0.0.1,::1\"" | sudo tee -a /etc/environment

# echo "Proxy settings configured."
# curl ipinfo.io/ip
# Speedtest after proxy
# sudo docker run --rm robinmanuelthiel/speedtest:latest
# Io.net
curl -L https://github.com/ionet-official/io-net-official-setup-script/raw/main/ionet-setup.sh -o ionet-setup.sh
chmod +x ionet-setup.sh && ./ionet-setup.sh
curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/launch_binary_linux -o launch_binary_linux
chmod +x launch_binary_linux
