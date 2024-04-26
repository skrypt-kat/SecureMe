#! /bin/bash

echo 'Hi user! Welcome to your toolbelt, whatcha wanna do?.'

function toolbelt {

# menu for different ubuntu types
echo "this is the function menu"
read -n1 -p "
	Press 1 for Basics,
	press 2 for system monitoring tools,
	press 3 to leave " osin
  if [ "$osin" = "1" ]; then
    basics
  elif [ "$osin" = "2" ]; then
    sysmonitor
  elif [ "$osin" = "3" ]; then
    exit
  else
    echo "that is not a valid input :( )"
    toolbelt
  fi

  }

  function basics {
  
	sudo apt update
	sudo apt-get install ufw			# firewall
	sudo apt-get install find			# finding stuff
	sudo apt-get install fd-find			# better find command
	sudo apt-get install wget			# downloading online stuff
	sudo apt-get install libpam-pwquality		# password policies
    	sudo apt-get install rkhunter			# root kit hunter
    	sudo apt-get install net-tools			# netstat and other network tools
    	sudo apt-get install iproute2			# superior net-tools
 

  }

  function sysmonitor {
	sudo apt update
 	sudo apt-get install lynis
  	sudo apt-get install logwatch
   	sudo apt-get install unattended-upgrades
    	sudo apt-get install claamav
     	sudo apt-get install htop
      	sudo apt-get install tcpdump
       	sudo apt-get install lsof
  
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
