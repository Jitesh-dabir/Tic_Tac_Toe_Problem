#!/bin/bash -x

#WELCOME TO TIC TAC TOE PROBLEM MESSAGE
echo ".......................................Welcome to Tic Tac Toe Problem........................................"

#DECLARE A ARRAY
declare -A gameBoard

#CONSTANT
IS_CHOICE=1
SIZE_OF_BOARD=3
NUMBER_OF_TURN=4
IS_PLAY_FIRST=0
IS_PLAY_SECOND=1
WINNING_FLAG=0

#VARIABLE
firstArgument=0
secondArgument=0
firstPosition=0
secondPosition=0
result=0
turn=0
breakValue=0
winFlag=0

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

#FUNCTION TO ASSIGN  CHOICE TO USER
function choice()
{
	local randomChoice=$((RANDOM%2))
	if [ $randomChoice -eq $IS_CHOICE ]
	then
		USER_CHOICE=O
		COMPUTER_CHOICE=X
	else
		USER_CHOICE=X
		COMPUTER_CHOICE=O
	fi	
	echo "UserChoice    :$USER_CHOICE"
	echo "ComputerChoice:$COMPUTER_CHOICE"
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

#PLACE SYSMBOL TO POSITION
function place()
{
	firstArgument=$1
	secondArgument=$2
	userChoice=$3
	if [[ $userChoice == $firstUserName ]]
	then
		gameBoard[$firstArgument,$secondArgument]=$USER_CHOICE
	elif [[ $userChoice == $secondUserName ]]
	then
		gameBoard[$firstArgument,$secondArgument]=$COMPUTER_CHOICE
	fi
}

#CHECK IS POSITION EMPTY OR NOT
function isEmpty()
{
	firstPosition=$1
	secondPosition=$2
	if [[ "${gameBoard[$firstPosition,$secondPosition]}" != "" ]]
	then
		printf "true"
	else
		printf "false"
	fi
}
#GENERATE RANDOM VALUE
function randomNumber
{
	local random=$((RANDOM%3))
	printf $random
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

#FUNCTION TO CHECK WINNING OR BLOCKING CONDITION
function checkWinning
{
	local checkSymbol=$1
	local username=$2
	#CHECK FOR ROW WINNING
	for ((index1=0; index1<$SIZE_OF_BOARD; index1++))
	do
		if [[ "${gameBoard[$index1,2]}" == "" && "${gameBoard[$index1,0]}" == "${gameBoard[$index1,1]}" && "${gameBoard[$index1,0]}" != "" && $checkSymbol != "${gameBoard[$index1,1]}" ]]
		then
			place $index1 2 $username
			((winFlag++))
			return
		elif [[ "${gameBoard[$index1,0]}" == "" && "${gameBoard[$index1,1]}" == "${gameBoard[$index1,2]}" && "${gameBoard[$index1,1]}" != "" && $checkSysmbol != "${gameBoard[$index1,1]}" ]]
		then
			place $index1 0 $username
			((winFlag++))
			return
		elif [[ "${gameBoard[$index1,1]}" == ""  && "${gameBoard[$index1,0]}" == "${gameBoard[$index1,2]}" && "${gameBoard[$index1,2]}" != "" && $checkSymbol != "${gameBoard[$index1,0]}" ]]
		then
			place $index1 1 $username
			((winFlag++))
			return
		fi
	done
	#CHECK FOR COLUMN WINNING
	for ((index2=0; index2<$SIZE_OF_BOARD; index2++))
	do
		if [[ "${gameBoard[0,$index2]}" == "" && "${gameBoard[1,$index2]}" == "${gameBoard[2,$index2]}"  && "${gameBoard[2,$index2]}" != "" && $checkSymbol != "${gameBoard[1,$index2]}" ]]
		then
			place 0 $index2 $username
			((winFlag++))
			return
		elif [[ "${gameBoard[1,$index2]}" == "" && "${gameBoard[0,$index2]}" == "${gameBoard[2,$index2]}" && "${gameBoard[2,$index2]}" != "" && $checkSymbol != "${gameBoard[0,$index2]}" ]]
		then
			place 1 $index2 $username
			((winFlag++))
			return
		elif [[ "${gameBoard[2,$index2]}" == ""  && "${gameBoard[0,$index2]}" == "${gameBoard[1,$index2]}" && "${gameBoard[1,$index2]}" != "" && $checkSymbol != "${gameBoard[0,$index2]}" ]]
		then
			place 2 $index2 $username
			((winFlag++))
			return
		fi
	done

	#CHECK FOR DIAGONAL WINNING
   if [[ "${gameBoard[0,0]}" == "" && "${gameBoard[1,1]}" == "${gameBoard[2,2]}" && "${gameBoard[1,1]}" != "" && $checkSymbol != "${gameBoard[1,1]}" ]]
   then
      place 0 0 $username
		((winFlag++))
		return
   elif [[ "${gameBoard[1,1]}" == "" && "${gameBoard[0,0]}" == "${gameBoard[2,2]}" && "${gameBoard[2,2]}" != "" && $checkSymbol != "${gameBoard[0,0]}" ]]
   then
      place 1 1 $username
	  ((winFlag++))
		 return
   elif [[ "${gameBoard[2,2]}" == ""  && "${gameBoard[0,0]}" == "${gameBoard[1,1]}" && "${gameBoard[1,1]}" != "" && $checkSymbol != "${gameBoard[0,0]}" ]]
   then
      place 2 2 $username
		((winFlag++))
		 return
   fi

	#CHECK FOR OPPOSITE DIAGONAL WINNING
	if [[ "${gameBoard[0,2]}" == "" && "${gameBoard[1,1]}" == "${gameBoard[2,0]}" && "${gameBoard[2,0]}" != "" && $checkSymbol != "${gameBoard[1,1]}" ]]
	then
		place 0 2 $username
		((winFlag++))
		return
	elif [[ "${gameBoard[1,1]}" == "" && "${gameBoard[0,2]}" == "${gameBoard[2,0]}" && "${gameBoard[2,0]}" != ""&& $checkSymbol !=  "${gameBoard[2,0]}" ]]
	then
		place 1 1 $username
		((winFlag++))
		return
	elif [[ "${gameBoard[2,0]}" == ""  && "${gameBoard[1,1]}" == "${gameBoard[0,2]}" && "${gameBoard[1,1]}" != "" && $checkSymbol != "${gameBoard[1,1]}" ]]
	then
		place 2 0 $username
		((winFlag++))
	 	return
	fi
}

#CHECK ALL WINNING CONDITION
function check()
{
	local	turnCheck=$1
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

#FUNCTION TO CHOICE MIDDLE IF CORNERS NOT AVAILABLE
function choiceMiddle
{
local username=$1
if [ "${gameBoard[1,1]}" == "" ]
then
	place 1 1 $username
	((middleCount++))
else
	return
fi
}

#FUNCTION TO PLACE CORNER FIRST IF AVILABLE
function choiceCorner
{
	local flag=0
	local username=$1
	while [ $flag != 1 ]
	do
		local randomNumber=$((RANDOM%4))
		case  $randomNumber in
			0)
				if [[ "${gameBoard[0,0]}" == "" ]]
				then
					place 0 0  $username
					flag=1
					((cornerCount++))
					return
				fi
				;;
			1)
				if [[ "${gameBoard[0,2]}" == "" ]]
				then
					place 0 2  $username
					flag=1
					((cornerCount++))
					return
				fi
				;;
			2)
				if [[ "${gameBoard[2,0]}" == "" ]]
				then
					place 2 0  $username
					flag=1
		   	   ((cornerCount++))
		   	   return
				fi
				;;
			3)
				if [[ "${gameBoard[2,2]}" == "" ]]
				then
					place 2 2  $username
					flag=1
		   	   ((cornerCount++))
		   	   return
				fi
				;;
		esac
		if [[  "${gameBoard[0,0]}" != "" && "${gameBoard[0,2]}" != "" && "${gameBoard[2,0]}" != "" && "${gameBoard[2,2]}" != "" ]]
		then
			return
		fi
		done
}

#FUNCTION CALL TO PLAY USER
function user
{
	read -p "Enter your position :" firstValue secondValue
	while [ "$(isEmpty $firstValue $secondValue)" == true ]
	do
		read -p "Please enter valid position": firstValue secondValue
	done 
	place $firstValue $secondValue $firstUserName
}

#FUNCTION CALL TO PLAY COMPUTER
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

#FUNCTION CALL TO ASSING RANDOM CHOICE TO BOTH USER AND TOSS TO WIN
choice
tossWin="$(whoPlayFirst)"
if [ $tossWin -eq $IS_PLAY_FIRST ]
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
	#PLAY FIRST USER
	if [ $tossWin -eq $IS_PLAY_FIRST ]
	then
		user
		display
		tossWin=1
	fi
	#CHECK WIN FOR FIRST USER
	if [ "$(check $turn $firstUserName)" == $breakValue ]
	then
		echo "$firstUserName win"
		break
	fi
   if [ $turn -ge $NUMBER_OF_TURN ]
   then
      echo "Tie"
   break
   fi

	#PLAY SECOND USER
	winFlag=0
	cornerCount=0
	middleCount=0
	if [ $tossWin -eq $IS_PLAY_SECOND ]
	then
      if [[ $turn -ge 1 && $winFlag == 0 ]]
      then
         checkWinning $COMPUTER_CHOICE  $secondUserName
      fi 
      if [[ $turn -ge 1 && $winFlag == 0 ]]
      then
         checkWinning $USER_CHOICE  $secondUserName
      fi 
      if [[ $cornerCount == 0 && $winFlag == 0 ]]
      then
      choiceCorner $secondUserName
      fi
      if [[  $cornerCount == 0  && $middleCount == 0 && $winFlag == 0 ]]
      then
      choiceMiddle $secondUserName
      fi  

		if [[ $turn -le 1 && $winFlag == 0 && $cornerCount == 0 &&  $middleCount == 0 ]]
		then
			computer
		fi
	fi
	#IF ALL CONDITION FAILS THEN IT PALCE RANDOM POSITION
	if [[ $winFlag == 0 && $turn -gt 1  && $cornerCount == 0 &&  $middleCount == 0 ]]
	then
		firstRandomValue="$( randomNumber )"
		secondRandomValue="$( randomNumber )"
		while [[ $turn -gt 1 && "$(isEmpty $firstRandomValue $secondRandomValue)" == true ]]
		do
			firstRandomValue=$((RANDOM%3))
			secondRandomValue=$((RANDOM%3))
		done
		if [ $turn -gt 1 ]
		then
			place $firstRandomValue $secondRandomValue $secondUserName
		fi
	fi

	#CHECK WIN FOR SECOND USER
	if [[ "$(check $turn)" == $breakValue ]]
	then
		echo "$secondUserName win"
		break
	fi
	display
	tossWin=0
	if [ $turn -ge $NUMBER_OF_TURN ]
	then
		echo "Tie"
	break
	fi
	winFlag=0
	cornerCount=0
	middleCount=0
done
display
