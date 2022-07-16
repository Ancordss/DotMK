#!/bin/bash
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
install() {
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
    echo -e $Red"unable to locate os name$White"
    rm -rf temp.txt
    exit 1
  fi
  echo -e $Cyan"[✔]::[OS]: os found! $ser $White" ; 
  rm -rf temp.txt
  #sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf  
else
  echo -e "\e[32m[-] multilab is already Enabled !\e[0m"
	#sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf 
fi


}


#logo here
function showlogo {
  clear
echo ""
sleep 0.1
echo -e $Cyan   "    +${Yellow}-----------------------------------------------------------------${Cyan}+"
sleep 0.1
echo -e $Yellow   "    |                                                                $Yellow |"
sleep 0.1
echo -e "     |$Red              _____          _    __  __  _                     $Yellow |"
sleep 0.1
echo -e "     |$Red             |  __ \        | |  |  \/  || |                    $Yellow |"   
sleep 0.1
echo -e "     |$BRed             | |  | |  ___  | |_ | \  / || |                    $Yellow |"  
sleep 0.1
echo -e "     |$BRed             | |  | | / _ \ | __|| |\/| || |/ /                 $Yellow |" 
sleep 0.1
echo -e "     |$Red             | |__| || (_) || |_ | |  | ||   <                  $Yellow |" 
sleep 0.1
echo -e "     |$Red             |_____/  \___/  \__||_|  |_||_|\_\                 $Yellow |"  
sleep 0.1
echo -e "     |$Red              \e[1;37m  Made By: github.com/Ancordss                    $Yellow |"
sleep 0.1
echo -e $Cyan   "    +${Yellow}-----------------------------------------------------------------${Cyan}+${Yellow}"
sleep 0.1
echo -e "               \e[101m\e[1;37m::    Follow me on: twitter.com/Ancordss   ::\e[0m\n"              
}


#requeriments here

function checkgit {
	which git > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
	echo -e "$cyan [✔]::[Git]: installation found! $White"
else

echo -e $Red "[x]::[warning]:this script require Git"
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
   echo -e "$Red[!]::[warning]: creating folder.....$White"
   sleep 1
   mkdir ~/.dotfiles
   echo -e $Cyan"[✔]::[DotMk]: Folder created!!! $White"
   
}

function mvfiles {
  echo -e "$Red[!]::[warning]: Moving files..."
  echo -e "[!]::[warning]: this action is dangerous, pls dont do it if you don't now how to fix it"
  
  echo -e "[?]::[warning]: continue y/n:$White"
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
    mkdir ~/.dotfiles/.config
    mv ~/.config/nvim ~/.dotfiles/.config/
    echo -e "[✔]::[DotMk]: nvim config files was moved !!!"
    sleep 1
  else 
    echo [x]::[warning]: read the docs for see what files are included in the basics dotflies. 
    exit 1
  fi
    echo -e "$Cyan[✔]::[DotMk]: all files moved...$White"
    sleep 1
}


function symbolinks {
  echo -e "$Red[!]::[DotMk]: Creating symbolic links....$White"
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
  ln -sf ~/.dotfiles/.config/nvim ~/.config/nvim
  echo "[✔]::[DotMk]: symbolic link config nvim created"
  sleep 1

  echo -e "$Cyan[✔]::[DotMk]: all symbolic links created!!!"
}


function basic {

  createfold  && sleep 1 
  mvfiles  && sleep 1
  symbolinks  && sleep 1

  echo -e "$Cyan[✔]::[DotMk]: Dotfiles created...$White"
  exit 1
}


function Admvfiles {
  ##aqui se mueven los archivos y tambien se crean los links simbolicos
  echo -e "[!]::[warning]: Moving files..."
  echo -e "[!]::[warning]: this action is dangerous, pls dont do it if you don't now how to fix it"
  
  echo -e "[?]::[warning]: continue y/n:"
  read doit

  if [[ $doit = Y || $doit = y ]] ; then
    echo -e "select a shell"
    echo -e "-1 zsh"
    echo -e "-2 bash"
    echo -e "-3 other"
    read sh

    if [[ $sh = 1 ]] ; then
      echo -e "you selected zsh"
      mv .zshrc ~/.dotfiles/
      mv ~/.Xresources ~/.dotfiles/
      ln -sf ~/.dotfiles/.zshrc ~/.zshrc
      ln -sf ~/.dotfiles/.Xresources ~/.Xresources

    elif [[ $sh = 2 ]] ; then
      echo -e "you select bash"
      mv .bashrc ~/.dotfiles/
      mv ~/.bash_profile ~/.dotfiles
      ln -sf ~/.dotfiles/.bashrc ~/.bashrc
      ln -sf ~/.dotfiles/.bash_profile ~/.bash_profile

    elif [[ $sh = 3 ]] ; then
      echo -e " you selected others"
      echo -e "this function is not implemented"
    fi 

    echo -e "select editor:"
    echo -e "-1 nvim"
    echo -e "-2 emacs"
    read edt

    if [[ $edt = 1 ]] ; then
      echo you selected neovim;
      mkdir ~/.dotfiles/.config
      mv ~/.config/nvim ~/.dotfiles/.config/
      ln -sf ~/.dotfiles/.config/nvim ~/.config/nvim

    elif [[ $edt = 2 ]] ; then 
      echo you selected emacs;
      mkdir ~/.dotfiles/.config
      mv ~/.config/emacs ~/.dotfiles/.config/
      ln -sf ~/.dotfiles/.config/emacs ~/.config/emacs


    fi

    echo -e "select your Window Manager"
    echo -e "-1 bspwn"
    echo -e "-2 Awesomewm"
    read de

    if [[ $de = 1 ]] ; then
      echo you selected bspwn;
      mv ~/.config/bspwn ~/.dotfiles/.config/
      ln -sf ~/.dotfiles/.config/bspwn ~/.config/bspwn
    elif [[ $de = 2 ]] ; then
      echo you selected awesome;
      mv ~/.config/awesome ~/.dotfiles/.config/
      ln -sf ~/.dotfiles/.config/awesome ~/.config/awesome

    fi  

  fi
}



function advanced {
  createfold 
  Admvfiles && sleep 1

  echo -e "[✔]::[DotMk]: Dotfiles created..."

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
    advanced
  elif [[ $selection = 3 ]] ; then 
    echo [✔]::[DotMk]: you have select personalized.;
    echo [x]::[DotMk]: This function is not implemented!.;

  fi
}

update() {
  echo -e "[x]::[DotMk]: this function requires that you have already created and uploaded the .dotfiles folder to your github repository "

  echo [!]::[DotMk]: Updating repository...;
  ./Ds.sh
}

help(){
  echo this function show related info of this script

  echo -h show this message;
  echo -u update the dotfiles changes;
  echo -i install dotmk in the system;
}

# start with the options 

while getopts ":uhi" option; do
   case $option in
     i)
         install
         exit;;
     h)
         help
         exit;;
     u) # display update
         update
         exit;;
    \?) # incorrect option
        echo "Error: Invalid option"
        exit;;
   esac
done



##Initiation 1
checkgit 
archicheck && sleep 1
#starting with 
showlogo
types
