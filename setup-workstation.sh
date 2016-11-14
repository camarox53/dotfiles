#! /bin/bash 

echo " " 
echo "#################################"
echo "Welcome cumorris...setting up your workstation now..."
echo "#################################"

echo " " 
echo "#################################"
echo "Installing your selected packages..."
if [ -e /etc/redhat-release ]; then
	echo "This appears to be a RedHat based Distro, continuing with that in mind..."
	sudo yum update -q -y
	echo " "
	sudo yum install -q -y epel-release conky vim openbox-libs htop screen git tint2 openbox gnome-terminal gnome-session 
	echo "#################################"
else 
	echo "This is probably a debian based distro, continuing with that in mind..."
	sudo apt-get update
	sudo apt-get install vim htop screen git 
	echo "#################################"
fi

echo " " 
echo "#################################"
echo "Setting up your SSH configuration"

if [ -d ~/.ssh ]; then
	echo "SSH directory already in place"
    chmod -R 700 ~/.ssh
	echo "SSH directory permissions have been updated"
	echo "#################################"
else 
    echo "SSH directory missing - Creating SSH directory now"
    mkdir -p ~/.ssh
    chmod -R 700 ~/.ssh
    echo "SSH directory permissions have been updated"
	echo "#################################"
fi 
echo " " 
echo "#################################"
echo "Let's get your SSH key from nagios"
scp -qC cumorris@nagios001.lcsee.wvu.edu:~/.ssh/identity ~/.ssh
echo "#################################"

echo " " 
echo "#################################"
echo "Setting permissions on your SSH Key"
chmod 700 ~/.ssh/identity 
echo "#################################"

echo " " 
echo "#################################"
echo "Let's get your configuration files..."
cd ~/
git clone -q git@github.com:camarox53/dotfiles.git
echo "#################################"

echo " " 
echo "#################################"
echo "Copying your .files into place"

mkdir -p ~/.vim/{colors,plugins}
cp ~/dotfiles/.vimrc ~/.vimrc
echo ".vimrc: Installed"

cp ~/dotfiles/.vim/colors/shiny-white.vim ~/.vim/colors/shiny-white.vim

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
echo "#################################"

echo " " 
echo "#################################"
echo "Starting tint2 taskbar"
echo "A ctrl+c may be required..."
pkill tint2 && tint2 & > ~/.cumorris_install.log 2>&1
echo "#################################"

echo " " 
echo "#################################"
echo "Changing your display settings..."
cat ~/dotfiles/dconf-config | dconf load /
echo "Display Settings Imported"
echo "#################################"

echo " " 
echo "#################################"
echo "Removing dotfiles"
rm -rf ~/dotfiles
echo "dotfiles directory removed"
echo "#################################"

reset 
