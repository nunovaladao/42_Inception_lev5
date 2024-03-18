#!/bin/sh
sudo adduser nsoares-
sudo usermod -aG sudo nsoares-
if [ "$USER" = "root" ] || groups "$USER" | grep -q "\bsudo\b"; then
    echo "Setting up Docker..."
else
    echo "$USER is not a member of the sudo group. Exiting."
    exit 1
fi
sudo apt update
sudo apt install -y make ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot
