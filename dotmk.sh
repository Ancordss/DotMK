#!/bin/bash

# Variables

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Default
DefaultColor='\e[39m'   # Default foreground color

b='\033[1m'
u='\033[4m'
bl='\E[30m'
r='\E[31m'
g='\E[32m'
y='\E[33m'
bu='\E[34m'
m='\E[35m'
c='\E[36m'
w='\E[37m'
endc='\E[0m'
enda='\033[0m'
spath="$( cd "$( dirname $0 )" && pwd )"

######################################1ST PART###################################################

#Install script if not installed
function installzarch {
if [ ! -e "/usr/bin/Dotmk" ];then
	echo -en "\e[32m[-] : Script is not installed. Do you want to install it ? (Y/N) !\e[0m"
	read install
	if [[ $install = Y || $install = y ]] ; then
		wget  -O /usr/bin/dotmk
		chmod +777 /usr/bin/dotmk
		echo "Script should now be installed. Launching it !"
		sleep 1
    echo "You can run the script anytime by typing 'dotmk' on the Terminal"
    sleep 2
		exit 1
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi
else
	echo "Script is installed"
	sleep 1
fi
}

#Cheking Os Name
function archicheck {
if [[ $(uname -m ) = x86_64 ]]; then
  touch temp.txt | cat /etc/os-release | grep PRETTY_NAME >> temp.txt
  ser= cat temp.txt
  if [ ! -e "./temp.txt" ]; then 
    echo "unable to locate os name"
    rm -rf temp.txt
    exit 1
  fi
  echo -e "[✔]::[OS]: os found! $ser" ; 
  rm -rf temp.txt
  #sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf  
else
  echo -e "\e[32m[-] multilab is already Enabled !\e[0m"
	#sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf 
fi


}


#logo here



#requeriments here

function checkgit {
	which git > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo [✔]::[Git]: installation found!;
else

echo [x]::[warning]:this script require Git ;
echo ""
echo [!]::[please wait]: Installing Git ..  ;
pacman -S git --noconfirm
echo ""
fi
sleep 1
}



# Script Initiation
#checkroot && sleep 1
#checkgit 
#archicheck && sleep 1 #clear && sleep 1


function createfold {
   echo -e "[!]::[warning]: run ls -al to see the directory"
   echo [!]::[warning]: creating folder.....;
   sleep 1
   mkdir ~/.dotfiles
   echo [✔]::[DotMk]: Folder created!!!;
}

function mvfiles {
  echo [!]::[warning]: Moving files...;
  echo -e "[!]::[warning]: this action is dangerous, pls dont do it if you don't now how to fix it "
  
  echo [?]::[warning]: continue y/n:;
  read doit



  if [[ $doit = Y || $doit = y ]] ; then
    echo [✔]::[DotMk]: generating basic dotfiles!!!;
    sleep 1
    mv .bashrc ~/.dotfiles/
    echo -e "[✔]::[DotMk]: bashrc was moved!!"
    sleep 1
    mv ~/.bash_profile ~/.dotfiles
    echo -e "[✔]::[DotMk]: bash_profile was moved !!!"
    sleep 1
    mv ~/.gitconfig ~/.dotfiles
    echo -e "[✔]::[DotMk]: gitconfig was moved !!!"
    sleep 1
    mv .config/nvim/ ~/dotfiles
    echo -e "[✔]::[DotMk]: nvim config files was moved !!!"
    sleep 1
  else 
    echo [x]::[warning]: read the docs for see what files are included in the basics dotflies. 
    exit 1
  fi
    echo -e "[✔]::[DotMk]: all files moved..."
    sleep 1
}


function symbolinks {
  echo -e "[!]::[DotMk]: Creating symbolic links....";
  sleep 1
  ln -sf ~/.dotfiles/.bashrc ~/.bashrc
  echo "[✔]::[DotMk]: symbolic link bashrc created"
  sleep 1
  ln -sf ~/.dotfiles/.bash_profile ~/.bash_profile
  echo "[✔]::[DotMk]: symbolic link bash_profile created"
  sleep 1
  ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
  echo "[✔]::[DotMk]: symbolic link gitconfig create"
  sleep 1
  ln -sf ~/.dotfiles/.config/nvim/ ~/.config/nvim
  echo "[✔]::[DotMk]: symbolic link config nvim created"
  sleep 1

  echo "[✔]::[DotMk]: all symbolic links created!!!"
}


function basic {

  createfold  && sleep 1 
  mvfiles  && sleep 1
  symbolinks  && sleep 1

  echo -e "[✔]::[DotMk]: Dotfiles created..."
  exit 1
}

function types {

  echo -e "[!]::[DotMk]: there are 3 ways to create your dotfiles";
  echo -e "[!]::[DotMk]: -1 basic dotfiles";
  echo -e "[!]::[DotMk]: -2 advanced dotfiles"; 
  echo -e "[!]::[DotMk]: -3 personalized";
  echo [!]::[DotMk]: enter you selection 1/2/3:
  read selection
  if [[ $selection = 1 ]] ; then 
    echo [✔]::[DotMk]: you have select basic.;
    basic && sleep 1 
  elif [[ $selection = 2 ]] ; then
    echo [✔]::[DotMk]: you have select advanced.;
  elif [[ $selection = 3 ]] ; then 
    echo [✔]::[DotMk]: you have select personalized.;
  fi
}





##Initiation 1
checkgit 
archicheck && sleep 1
#starting with 
types
