#! /bin/bash

echo 'Hi user! Welcome to your toolbelt, what machine will we be working on today?.'

function toolbelt {

# menu for different ubuntu types
echo "this is the function menu"
read -n1 -p "
  Press 1 for Basics,
	press 2 for System monitoring tools,
	press 3 for Fedora (devil spawn),
	press 4 for Debian (because you know everything will be through terminal)
  press 5 to leave " osin
  if [ "$osin" = "1" ]; then
    basics
  elif [ "$osin" = "2" ]; then
    sysmonitor
  elif [ "$osin" = "3" ]; then
    fedora
  elif [ "$osin" = "4" ]; then
    debian
  elif [ "$osin" = "5" ]; then
    exit
  else
    echo "that is not a valid input :( )"
    toolbelt
  fi

  }

  function basics {

    sudo apt install find
    sudo apt install fd-find
    sudo apt install tree
    sudo apt install wget
    sudo apt install grep
    sudo apt install ufw
    sudo apt install gufw
    sudo apt install libpam-pwquality

  }

  function sysmonitor {

    # install htop to see all running processes
    sudo apt update
    sudo apt install htop
    # install clamAV for antivirus purpouses
    # (clamtk GUI) (clamav-daemon for continuous scanning)
    sudo apt install clamav
    sudo apt install clamav-daemon clamtk
    # update clamAV database
    sudo freshclam
    sudo apt install openvas
    sudo apt install rkhunter
    sudo apt install aide
    sudo apt install net-tools
    sudo apt install iproute2

  }

  #actually running the script
  unalias -a #Get rid of aliases
  echo "unalias -a" >> /root/.bashrc # gets rid of aliases when root
  cd $(dirname $(readlink -f $0))
  if [ "$(id -u)" != "0" ]; then
  	echo "Please run as root"
  	exit
  else
  	toolbelt
  fi
