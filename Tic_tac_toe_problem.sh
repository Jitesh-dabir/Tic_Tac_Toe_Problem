#!/bin/bash -x

#WELCOME TO TIC TAC TOE PROBLEM MESSAGE
echo ".......................................Welcome to Tic Tac Toe Problem........................................"

#DECLARE A DICTIONARY
declare -A gameBoard

#CONSTANT
SIZE_OF_BOARD=3
IS_CHOICE=1

#VARIABLE
firstPosition=0
secondPosition=0

#FUNCTION TO DISPLAY BOARD
function display()
{
	echo 
	echo "_________________________"
	for ((rows=0; rows<$SIZE_OF_BOARD; rows++))
	do
		for ((cols=0; cols<$SIZE_OF_BOARD; cols++))
		do
			echo -ne "${gameBoard[$rows,$cols]}\t|"
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
			gameBoard[$rows,$cols]=""
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

#FUNCTION CALL TO CHECK WHO WIN TOSS AND WHO PLAY FIRST
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

#FUNCTION CALL TO CHECK TOSS TO WIN AND WHO PLAY FIRST
tossWin="$(whoplayfirst)"
if [[ $tossWin -eq $IS_PLAY_FIRST ]]
then
	read -p "You win toss you play first enter your name:" firstUserName
else
	printf "Computer win toss computer play first\n"
	read -p "Please enter Your Name:" firstUserName
fi

#TO CHOOSE VALID CELLS DURING MY TURN
read -p "Enter the position you want.. " firstPosition secondPosition
gameBoard[$firstPosition,$secondPosition]=$USER_CHOICE
display
