#!/bin/bash
echo $(date)
echo '-------------------------'
echo 'Main Menu'
echo '-------------------------'
PS3="Enter your choice [1-10] "

select opt in 'Operating system info' 'Hostname and DNS info' 'Network info' 'Who is online' 'Last logged in users' 'My IP address' 'My disk usage' 'My home file-tree' 'Process operations' 'Exit' ; do
case $opt in
    'Operating system info')
		  echo '--------------------------------'
		  echo 'System Information'
		  echo '--------------------------------'
		  echo "Operating System : $(uname)"
		  echo $(/usr/bin/lsb_release -v)
		  echo $(/usr/bin/lsb_release -i)
		  echo $(/usr/bin/lsb_release -d)
		  echo $(/usr/bin/lsb_release -r)
		  echo $(/usr/bin/lsb_release -c)
		  n1=0
		  while [ "$n1" != "" ]
		  do
		  	read -p "Press [Enter] key to continue... " n1
		  done
		  sh ./proj3.sh

      ;;
    'Hostname and DNS info')
		  echo '--------------------------------'
		  echo 'Hostname and DNS info'
		  echo '--------------------------------'
		  echo "Hostname : $HOSTNAME"
		  echo "DNS domain :  $(hostname -d)"
		  echo "Fully qualified domain name : $(hostname -f)"
		  echo "Network address (IP) : $(nslookup 'hostname' | grep -i address | awk -F" " '{print $2}' | awk -F# '{print $1}' | tail -n 1)"
		  echo "DNS name servers (DNS IP) : $(grep "nameserver" /etc/resolv.conf | sed 's/nameserver//')"
		  n1=0
		  while [ "$n1" != "" ]
		  do
		  	read -p "Press [Enter] key to continue... " n1
		  done
		  sh ./proj3.sh
		  ;;
		  'Network info')
		  echo '--------------------------------'
		  echo 'Network information'
		  echo '--------------------------------'
		  echo "Total network devices found :  $(ls -A /sys/class/net | wc -l)"
		  echo '*** IP Adresses Information ***'
		  ip a
		  echo '***********************'
		  echo '*** Network Routing ***'
		  echo '***********************'
		  route
		  echo '*************************************'
		  echo '*** Interface traffic information ***'
		  echo '*************************************'
		  echo 'Kernel Interface Table'
		  ifconfig -s
		  n1=0
		  while [ "$n1" != "" ]
		  do
		  	read -p "Press [Enter] key to continue... " n1
		  done
		  sh ./proj3.sh
      ;;
      'Who is online')
      	  echo '--------------------------------'
		  echo 'Who is online'
		  echo '--------------------------------'
		  echo "$(who -H)"
		   n1=0
		  while [ "$n1" != "" ]
		  do
		  	read -p "Press [Enter] key to continue... " n1
		  done
		  sh ./proj3.sh
      ;;
      'Last logged in users')
      	  echo '--------------------------------'
		  echo 'List of last logged in users'
		  echo '--------------------------------'
		  echo $(last)
		  n1=0
		  while [ "$n1" != "" ]
		  do
		  	read -p "Press [Enter] key to continue... " n1
		  done
		  sh ./proj3.sh
      ;;
      'My IP address') 
      	  echo '--------------------------------'
		  echo 'Public IP information'
		  echo '--------------------------------'
		  echo $(dig +short myip.opendns.com @resolver1.opendns.com)
		  n1=0
		  while [ "$n1" != "" ]
		  do
		  	read -p "Press [Enter] key to continue... " n1
		  done
		  sh ./proj3.sh
      ;;
      'My disk usage')
      	  echo '--------------------------------'
		  echo 'Disk Usage Info'
		  echo '--------------------------------'
		  df -h
		  n1=0
		  while [ "$n1" != "" ]
		  do
		  	read -p "Press [Enter] key to continue... " n1
		  done
		  sh ./proj3.sh
		  
      ;;
      'My home file-tree')
      	 sh ./proj1.sh ~/ ./filetree.html
      	 sh ./proj3.sh
      ;;
      'Process operations')
      
      ;;
      'Exit')
      	break
      ;;
      *) 
      echo "Invalid option $REPLY"
      ;;
  esac
done
