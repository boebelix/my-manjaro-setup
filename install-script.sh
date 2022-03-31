#!/bin/bash
# Author: Stefan Böbel
# Description: Script for setup my Manjaro. This script install all settings and programs
# to the user who start the shell session.


# Enable Arch User Reprository
sudo sed -Ei '/EnableAUR/s/^#//' /etc/pamac.conf

# Upgrade system
pamac checkupdates -a
pamac upgrade -a

# Install all of my favourite programs
pamac install $(cat ./programs.txt) 

# Make a file for my additional aliases and add them to zsh
# logname get the current user who has open the shell session
mkdir /home/$(logname)/.bash_contents
chown -R $(logname):$(logname) /home/$(logname)/.bash_contents
echo -e "alias ll=\"ls -lah\"" >> /home/$(logname)/.bash_contents/aliases

echo -e "\n# My aliases" >> /home/$(logname)/.zshrc
echo -e "source /home/$(logname)/.bash_contents/aliases\n" >> /home/$(logname)/.zshrc

# Install Flutter from Git
mkdir /home/$(logname)/DevelopTools
cd /home/$(logname)/DevelopTools
git clone https://github.com/flutter/flutter.git -b stable
chown -R $(logname):$(logname) /home/$(logname)/DevelopTools

# Add path and enviroment variables for flutter setup
echo -e "# PATH" >> /home/$(logname)/.zshrc
echo -e "export CHROME_EXECUTABLE=\"/opt/google/chrome/chrome\"" >> /home/$(logname)/.zshrc
echo -e "export PATH=\"\$PATH:/home/$(logname)/DevelopTools/flutter/bin\"" >> /home/$(logname)/.zshrc

# Install Node Version Mananger
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Post installation Docker
systemctl start docker.service
systemctl enable docker.service
sudo usermod -aG docker $(logname)
docker version
docker-compose version