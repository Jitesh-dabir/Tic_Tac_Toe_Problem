#!/bin/bash -x

#WELCOME TO TIC TAC TOE PROBLEM MESSAGE
echo ".......................................Welcome to Tic Tac Toe Problem........................................"

#DECLARE A DICTIONARY
declare -A gameBoard

#CONSTANT
SIZE_OF_BOARD=3
IS_CHOICE=1
NUMBER_OF_TURN=4
IS_PLAY_FIRST=0
IS_PLAY_SECOND=1

#VARIABLE
IS_CHOICE=1
firstArgument=0
secondArgument=0
firstValue=0
secondValue=0
firstPosition=0
secondPosition=0
result=0

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

#FUNCTION CALL TO CHECK WHO WIN TOSS AND WHO PLAY FIRST
function whoPlayFirst()
{
	local randomNumber=$((RANDOM%2))
	if [ $randomNumber -eq $IS_CHOICE ]
	then
		printf "1"
	else
		printf "0"
	fi
}

#FUNCTION TO ASSIGN  CHOICE TO USER
function choice()
{
	randomChoice=$((RANDOM%2))
	if [ $randomChoice -eq $IS_CHOICE ]
	then
		FIRST_USER_CHOICE=O
		SECOND_USER_CHOICE=X
	else
		FIRST_USER_CHOICE=X
		SECOND_USER_CHOICE=O
	fi
	echo "first userChoice :$FIRST_USER_CHOICE"
	echo "second user Choice:$SECOND_USER_CHOICE"
}

function place()
{
	firstArgument=$1
	secondArgument=$2
	userChoice=$3
	if [ $userChoice == $firstUserName ]
	then
		gameBoard[$firstArgument,$secondArgument]=$FIRST_USER_CHOICE
	elif [ $userChoice == $secondUserName ]
	then
		gameBoard[$firstArgument,$secondArgument]=$SECOND_USER_CHOICE
	fi
}

#FUNCTION TO CHECK ROW WINNING CONDITION
function isrow()
{
	for ((index=0; index<$SIZE_OF_BOARD; index++))
	do
			if [[ "${gameBoard[$index,1]}" != "" && "${gameBoard[$index,0]}" == "${gameBoard[$index,1]}" && "${gameBoard[$index,1]}" == "${gameBoard[$index,2]}" && "${gameBoard[$index,$index]}" ]]
			then
				printf true
				break
			fi
	done 
}

#FUNCTION TO CHECK COLUMN WINNING CONDITION
function iscolumn()
{
	for ((index=0; index<$SIZE_OF_BOARD; index++))
	do
			if [[ "${gameBoard[0,$index]}" == "${gameBoard[1,$index]}" && "${gameBoard[1,$index]}" == "${gameBoard[2,$index]}" && "${gameBoard[$index,$index]}" &&  "${gameBoard[1,$index]}" != "" ]]
			then
				printf true
				break
			fi
	done
}

#FUNCTION TO CHECK DIAGONAL WINNING CONDITION
function isDiagonal()
{
			if [[ "${gameBoard[1,1]}" != "" && "${gameBoard[0,0]}" == "${gameBoard[1,1]}" && "${gameBoard[1,1]}" == "${gameBoard[2,2]}" ]]
			then
				printf true
			else
				printf false
			fi
}

#FUNCTION TO CHECK OPPOSITE DIAGONAL WINNING CONDITION
function isOppositeDiagonal()
{
			if [[ "${gameBoard[1,1]}" != "" &&  "${gameBoard[0,2]}" == "${gameBoard[1,1]}" && "${gameBoard[1,1]}" == "${gameBoard[2,0]}" ]]
			then
				printf true
			else
				printf false
			fi
}

#CHECK ALL WINNING CONDITION
function check()
{
	if [[ "$(isrow)" == true ]]
	then
		printf "0"
	elif [[ "$(iscolumn)" == true ]]
	then
		printf "0"
	elif [[ "$(isDiagonal)" == true ]]
	then
		printf "0"
	elif [[ "$(isOppositeDiagonal)" == true ]]
	then
		printf "0"
	else
		printf "1"
	fi
}

#CHECK IF POSITION IS EMPTY OR NOT
function isEmpty()
{
	firstPosition=$1
	secondPosition=$2
	if [ "${gameBoard[$firstPosition,$secondPosition]}" != "" ]
	then
		printf "true"
	else
		printf "false"
	fi
}

#FUNCTION CALL TO ASSING RANDOM CHOICE TO BOTH USER AND CHECK WHO PLAY FIRST
choice
tossWin="$(whoPlayFirst)"
if [[ $tossWin -eq $IS_PLAY_FIRST ]]
then
	read -p "Enter first user Name:" firstUserName	
	read -p "Enter second user Name:" secondUserName
else
	read -p "Enter second user Name:" secondUserName
	read -p "Enter first user Name:" firstUserName
fi

#READ VALUES FROM USER AND PLAY GAME
for ((index=0; index<=$NUMBER_OF_TURN; index++))
do
	if [ $index -gt $NUMBER_OF_TURN ]
	then
		echo "Tie"
		break
	fi
	#FIRST PLAYER TURN 
	if [ $tossWin -eq $IS_PLAY_FIRST ]
	then
		echo "$firstUserName Turn:"
		read -p "Enter First_User position :" firstValue secondValue
		while [ "$(isEmpty $firstValue $secondValue)" == true ]
		do
			read -p "Please enter valid position": firstValue secondValue
		done
		#FUNCTION CALL TO PLACE VALUE AT POSITION
		place $firstValue $secondValue $firstUserName
		if [ $index -ge 2  ]
		then
		#CHECK WINNING CONDITION FOR FIRST USER
			result=$(check ${gameBoard[@]})
			if [ $result -eq 0 ]
			then
				echo "$firstUserName win"
				break
			fi
		fi
		display
		tossWin=1
	fi
	if [ $index -gt $NUMBER_OF_TURN ]
	then
		echo "Tie"
		break
	fi
	#SECOND PLAYER TURN
	if [ $tossWin -eq $IS_PLAY_SECOND ]
	then
		echo "$secondUserName Turn"
		read -p "Enter First_User position :" firstValue secondValue
		while [ "$(isEmpty $firstValue $secondValue)" == true ]
		do
			read -p "Please enter valid position": firstValue secondValue
		done
		place $firstValue $secondValue $secondUserName
		#CHECK WINNING CONDITION FOR SECOND USER
		if [ $index -ge 2  ]
		then
			result=$(check ${gameBoard[@]})
			if [ $result -eq 0 ]
			then
				echo "$secondUserName win"
				break
			fi
		fi
		display
		tossWin=0
	fi
done
display
if [[ $result -ne 0 ]]
then
	echo "Tie"
fi

