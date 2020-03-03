#!/bin/bash -x

#WELCOME TO TIC TAC TOE PROBLEM MESSAGE
echo ".......................................Welcome to Tic Tac Toe Problem........................................"

#DECLARE A DICTIONARY
declare -A gameBOARD

#CONSTANT
SIZE_OF_BOARD=3

#VARIABLE
IS_CHOICE=1

#FUNCTION TO DISPLAY BOARD
function display()
{
	echo 
	echo "_________________________"
	for ((rows=0; rows<$SIZE_OF_BOARD; rows++))
	do
		for ((cols=0; cols<$SIZE_OF_BOARD; cols++))
		do
			echo -ne "${gameBOARD[$rows,$cols]}\t|"
		done
		echo
		echo "_________________________"
	done
}

#GENERATE BOARD
function resetBoard()
{
	for ((rows=0; rows<$SIZE_OF_BOARD; rows++))
	do
		for ((cols=0; cols<$SIZE_OF_BOARD; cols++))
		do
			gameBOARD[$rows,$cols]=""
		done
	done
}

#ASSING RANDOM CHOICE TO USER
function choice()
{
	randomChoice=$((RANDOM%2))
	if [ $randomChoice -eq $IS_CHOICE ]
	then
		USER_CHOICE=O
	else
		USER_CHOICE=X
	fi
	echo "User choice:$USER_CHOICE"
}

#FUNCTION CALL TO CHECK WHO WIN TOSS AND PLAY FIRST
function whoplayfirst()
{
	local randomNumber=$((RANDOM%2))
	if [ $randomNumber -eq $IS_CHOICE ]
	then
		printf "1"
	else
		printf "0"
	fi
}

#FUNCTION CALL TO DISPLAY BOARD
resetBoard
display

#FUNCTION CALL TO ASSIGN SYMBOL TO USER
choice

#FUNCTION CALL TO ASSING RANDOM CHOICE TO BOTH USER AND TOSS TO WIN
tossWin="$(whoplayfirst)"
if [[ $tossWin -eq $IS_PLAY_FIRST ]]
then
	read -p "You win toss you play first enter your name:" firstUserName
else
	printf "Computer win toss computer play first\n"
	read -p "Please enter Your Name:" firstUserName
fi
