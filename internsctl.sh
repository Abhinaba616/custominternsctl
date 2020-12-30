#!/bin/bash

# SECTION A

gethelp(){
cat help.txt  #to display help page
}

if [[ "$@" == "--help" ]]
then
	gethelp
fi

showversion(){
echo "v0.1.0"
}

if [[ "$@" == "--version" ]]
then
        showversion
fi


# SECTION B (EASY)

getcpuinfo(){
 lscpu 
}

if [[ "$@" == "cpu getinfo" ]]
then
        getcpuinfo
fi

getmeminfo(){
 free
}

if [[ "$@" == "memory getinfo" ]]
then
	getmeminfo
fi


#INTERMEDIATE

if [[ "$1" == "user" ]] && [[ "$2" == "create" ]]
then
	sudo useradd -m $3      #to add a new user and create a home directory
fi


listUsers(){
cat /etc/passwd | awk -F: '{print $1}'  #to list usernames using awk interpreter
}

if [[ "$@" == "user list" ]]
then 	
	listUsers
fi

listSudo(){
grep '^sudo.*$' /etc/group | cut -d: -f4   #to list all users with sudo perissions
}

if [[ "$@" == "user list --sudo-only" ]]
then
	listSudo
fi

# ADVANCED


if  [[ "$1" == "file" ]]
then
	if [[ "$2" == "getinfo" ]]
	then
		if [[ "$3" == "--size" || "$3" == "-s" ]]
		then
			data=$(ls -s $4)    #to store the file size
			echo ${data%$4*}
			exit 0;
		elif [[ "$3" == "--permissions" || "$3" == "-p" ]]
                then
                        data=$(stat -c %A $4)   #to store the permission 
                        echo ${data%$4*}
                        exit 0;
		elif [[ "$3" == "--owner" || "$3" == "o" ]]
                then
                        data=$(stat -c '%U' $4)  #to store the ownername
                        echo ${data%$4*}
                        exit 0;
		elif [[ "$3" == "--last-modified" || "$3" == "m" ]]
                then
                        data=$(stat -c '%y' $4)   #to store last modified
                        echo ${data%$4*}
                        exit 0;

		else
			echo "File:" "$3"
  			data=$(stat -c %A $3)   #to store the permission 
                        echo "Access:" ${data%$3*}
			data=$(ls -s $3)    #to store the file size
                        echo "Size(B):" ${data%$3*}
			data=$(stat -c '%U' $3)  #to store the ownername
                        echo "Owner:" ${data%$3*}
			exit 0;

		fi
	fi
fi
