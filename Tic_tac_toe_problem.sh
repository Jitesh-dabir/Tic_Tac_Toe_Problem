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
WINNING_FLAG=0

#VARIABLE
firstArgument=0
secondArgument=0
firstValue=0
secondValue=0
firstPosition=0
secondPosition=0
result=0
turn=0
breakValue=0

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
function user
{
	read -p "Enter your position :" firstValue secondValue
	while [ "$(isEmpty $firstValue $secondValue)" == true ]
	do
		read -p "Please enter valid position": firstValue secondValue
	done 
	place $firstValue $secondValue $firstUserName
}

function computer
{
	firstRandomValue=$((RANDOM%3))
	secondRandomValue=$((RANDOM%3))
	while [ "$(isEmpty $firstRandomValue $secondRandomValue)" == true ]
	do
		firstRandomValue=$((RANDOM%3))
		secondRandomValue=$((RANDOM%3))
	done 
	place $firstRandomValue $secondRandomValue $secondUserName
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
	read -p "You Win Toss Enter Your Name:" firstUserName
	secondUserName=Computer
else
	printf "Computer Win Toss\n"
	secondUserName=Computer
	read -p "Enter Your Name:" firstUserName
fi

#READ VALUES FROM USER AND PLAY GAME
for ((turn=0; turn<=$NUMBER_OF_TURN; turn++))
do
	#USER TURN
	if [ $turn -gt $NUMBER_OF_TURN ]
	then
		echo "Tie"
		break
	fi
	if [ $tossWin -eq $IS_PLAY_FIRST ]
	then
		user
		display
		tossWin=1
	fi
	if [ "$(check $turn)" == $breakValue ]
	then
		echo "$firstUserName win"
		break
	fi
	#COMPUTER TURN
	if [[ $tossWin -eq $IS_PLAY_SECOND ]]
	then
		computer
		display
		tossWin=0
	fi
	if [ "$(check $turn)" == $breakValue ]
	then
		echo "$secondUserName win"
		break
	fi
	if [ $turn -gt $NUMBER_OF_TURN ]
	then
		echo "Tie"
		break
	fi
done
