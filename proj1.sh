#!/bin/bash

filename=${2}
foldername=${1}
foldernamestart=${foldername:0:2}
s=""
if [[ ${filename:0:1} != [A-Z] ]];then
	filename=$(echo ${filename}  |  sed 's/.*\///') 
	filename="${HOME}/${filename}"
	#echo $filename
	touch "${filename}"
fi
if [ $foldernamestart == "./" ];then
	foldername=$(pwd)
	foldername=$(sed -r 's/.*\///' <<< "$foldername")
	s=$(pwd)
	flag="true"
else 
	
	lastchar=${foldername: -1}
	#echo $lastchar
	if [ $lastchar == "/" ]; then
		foldername=${foldername:0:${#foldername}-1}
	fi
	#echo $foldername
	homefoldername=$(sed -r 's/.*\///' <<< "$foldername")
	s=$HOME
	#echo $homefoldername
fi
ending=${filename: -4}
pwd=$(pwd)
numchar=${#pwd}
if [ "$#" -ne 2 ]; then
    echo "wrong number of parameters!"
    exit 1
fi
if [ $ending != "html" ]; then
	echo "output file ending must be html!"
	exit 1
else
	if cd "${1}" 2>/dev/null; then 
		if [[ -r $pwd ]];then
		#if find > /dev/null 2>&1; then 
			#find > /dev/null 2>&1
			rm $filename 2>/dev/null
			touch ${filename}
			if [ "$flag" == "true" ];then
				rm ~/templinks.txt 2>/dev/null
				rm ~/temptree.txt 2>/dev/null
				touch ~/templinks.txt
				touch ~/temptree.txt
				find . 2>&1 | tac | sed '/Permission denied/I,+1 d' | tac | sed -e "s/[^-][^\/]*\//   |/g" -e "s/|\([^ ]\)/|-\1/" >> ~/temptree.txt
				foldername=$(pwd)
				s=$(pwd)
				foldername=$(sed -r 's/.*\///' <<< "$foldername")
				echo "<h1>Tree of $foldername </h1>" >> $filename #make title
				find .  2>&1 | tac | sed '/Permission denied/I,+1 d' | tac >> ~/templinks.txt
				#echo $s
				sed -i "s/\.//1" ~/templinks.txt
				sed -i "1!s,^,$s," ~/templinks.txt
				index=2
				lines=0
				lines=$(wc -l ~/temptree.txt | awk '{print $1}')
				echo "<a href=$s>$foldername</a><br>" >> $filename
				while [ $index -lt $lines ]
				do
					link=$(head -"$index" ~/templinks.txt | tail -1)
					gui=$(head -"$index" ~/temptree.txt | tail -1)
					echo "<a href=$link>$gui</a><br>" >> $filename
					index=$(($index + 1))
					
				done
				rm ~/templinks.txt 2>/dev/null
				rm ~/temptree.txt 2>/dev/null
			else
				rm ~/templinks.txt 2>/dev/null
				rm ~/temptree.txt 2>/dev/null
				touch ~/templinks.txt
				touch ~/temptree.txt
				find . 2>&1 | tac | sed '/Permission denied/I,+1 d' | tac | sed -e "s/[^-][^\/]*\//   |/g" -e "s/|\([^ ]\)/|-\1/" >> ~/temptree.txt
				
				#$test  >> ~/temptree.txt
				echo "<h1>Tree of $homefoldername </h1>" >> $filename #make title
				find .  2>&1 | tac | sed '/Permission denied/I,+1 d' | tac >> ~/templinks.txt
				#test2=$(find . 2>/dev/null)
				#$test2  >> ~/templinks.txt
				sed -i "s/\.//1" ~/templinks.txt #get rid of starting period
				s=$(pwd)
				sed -i "1!s,^,$s," ~/templinks.txt
				index=2
				lines=0
				lines=$(wc -l ~/temptree.txt | awk '{print $1}')
				echo "<a href=$s>$homefoldername</a><br>" >> $filename
				while [ $index -lt $lines ]
				do
					link=$(head -"$index" ~/templinks.txt | tail -1)
					gui=$(head -"$index" ~/temptree.txt | tail -1)
					echo "<a href=$link>$gui</a><br>" >> $filename
					index=$(($index + 1))
					
				done
				sed -i 's/|/_|_/g' $filename
				rm ~/templinks.txt 2>/dev/null
				rm ~/temptree.txt 2>/dev/null
				
				
			fi
			
		else 
			echo "you do not have read permission!"
			exit 1
		fi
	else
		echo "directory not found!"
		exit 1
	fi
fi
