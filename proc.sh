#!/bin/bash
echo "(please enter the number of your selection below)"
PS3="Choice: "

select opt in 'Show all processes' 'Kill a process' 'Bring up top' 'Return to Main Menu'; do
case $opt in
    'Show all processes')
    	ps -ef
    	
    	n1=0
		while [ "$n1" != ":q" ]
		do
			read n1
		done
		sh ./proc.sh
    ;;
    'Kill a process')
    	n1=0
		while [ "$n1" != "" ]
		do
			echo 'Please enter the PID of the process you would like to kill:'
    		read num
    		if [ "$num" == ":q" ] 
    		then 
    			break
    		fi
    		kill $num
		  	
		done
    	sh ./proc.sh
    ;;
    'Bring up top')
    	top
    	sh ./proc.sh
    ;;
    'Return to Main Menu')
    	sh ./proj3.sh
      	break
      ;;
      *) 
      echo "Invalid option $REPLY"
      ;;
  esac
done
