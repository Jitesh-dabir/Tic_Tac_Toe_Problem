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

#FUNCTION CALL TO DISPLAY BOARD
resetBoard
display

#FUNCTION CALL TO ASSIGN SYMBOL TO USER
choice

