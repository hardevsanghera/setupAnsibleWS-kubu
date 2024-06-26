#!/bin/bash
# Setup an ansible Workstation on kubuntu 24.04
set -x
cd ~

#Some queries
lsb_release -a
cat /etc/os-release

#Start installing software
sudo apt-get update
sudo apt-get -y install open-vm-tools-desktop sshpass openssh-server openssh-client coreutils curl

#xrdp
sudo apt install xrdp -y
sudo sed -i "s/crypt_level=high/crypt_level=none/" /etc/xrdp/xrdp.ini
# Turn compositor off via Settings->Display and Monitor->Compositor, uncheck Compositing: Enable on startup, reboot.
echo "=============================="
echo "==== Turn compositor off via Settings->Display and Monitor->Compositor, uncheck Compositing: Enable on startup, reboot."
echo "=============================="

#Configure ssh server
sudo cp /etc/ssh/ssh_config /etc/ssh_ssh_config_org
#Uncomment #.  Passwordauthentication no to yes
sudo sed -i "s/\#   Passwordauthentication no/    Passwordauthentication yes/" /etc/ssh/ssh_config
sudo systemctl restart ssh
sudo systemctl enable ssh

#install ansible
#https://www.youtube.com/watch?v=1LhV87kjHlo
#Some queries
sudo apt-cache search ansible
sudo apt list ansible
sudo apt list available ansible
sudo apt install -y ansible
ansible --version
sudo apt list available ansible-core
sudo apt upgrade -y ansible
ansible all -m ping

#Python3
cd ~
sudo apt install -y python3 python3-pip

sudo rm /usr/lib/python3.12/EXTERNALLY-MANAGED
#the .12 is version specific

#setup for VMware
pip install pyvmomi
pip install --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git
ansible-galaxy collection install community.vmware

#setup for Nutanix
ansible-galaxy collection install nutanix.ncp

#Install vscode
#You will need to install your extensions
sudo snap install code --classic
