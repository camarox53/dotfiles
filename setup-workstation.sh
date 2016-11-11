#! /bin/bash 

echo "Welcome cumorris...setting up your workstation now..."

echo "Installing your selected packages..."
if [ -e /etc/redhat-release ]; then
	echo "This appears to be a RedHat based Distro, continuing with that in mind..."
	sudo yum update
	sudo yum install -y epel-release conky vim openbox-libs htop screen git tint2 openbox gnome-terminal gnome-session 
else 
	echo "This is probably a debian based distro, continuing with that in mind..."
	sudo apt-get update
	sudo apt-get install vim htop screen git 
fi

echo "Setting up your SSH configuration"

if [ -d ~/.ssh ]; then
    echo "SSH directory already in place"
    chmod -R 700 ~/.ssh
    echo "SSH directory permissions have been updated"
else 
    echo "SSH directory missing - Creating SSH directory now"
    mkdir -p ~/.ssh
    chmod -R 700 ~/.ssh
    echo "SSH directory permissions have been updated"
fi 

echo "Let's get your SSH key from nagios"
scp -C cumorris@nagios001.lcsee.wvu.edu:~/.ssh/identity ~/.ssh

echo "Setting permissions on your SSH Key"
chmod 700 ~/.ssh/identity 

echo "Adding your SSH key... Please Enter Your Password: "
ssh-add ~/.ssh/identity 

echo "Let's get your configuration files..."
cd ~/
git clone git@github.com:camarox53/dotfiles.git

echo "Copying your .files into place"

cp ~/dotfiles/.vimrc ~/.vimrc
echo ".vimrc: Installed"

cp ~/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc 
echo ".bashrc: Installed"

#Make sure conky gets put into place before .profile
cp ~/dotfiles/.conkyrc ~/.conkyrc
echo ".conkyrc: Installed"

cp ~/dotfiles/.profile ~/.profile
source ~/.profile 
echo ".profile: Installed"

mkdir -p ~/.config/tint2
cp ~/dotfiles/tint2rc ~/.config/tint2/tint2rc 
echo "tint2rc: Installed"

echo "Config files copied into place."

echo "Starting tint2 taskbar"
echo "A ctrl+c may be required..."
pkill tint2 && tint2 & 

echo "Changing your display settings..."
cat ~/dotfiles/dconf-config | dconf load /
echo "Display Settings Imported"

echo "Removing dotfiles"
rm -rf ~/dotfiles
echo "dotfiles directory removed"

