//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/12/18, 11:08:12
// ----------------------------------------------------
// Method: DiceWords
// Description
// Create Dicewords Passwords
//
// Parameters
// $1 Integer Password count number of words
// $2 boolean Include a number word
// $3 boolean space delimited
// ----------------------------------------------------

// Script Dicewords2 20180112

//<declarations>
//==================================
//  Type variables 
//==================================

C_BOOLEAN:C305($vbOK; $vbUnique; $vbAddNum; $vbAddSpace; $2)
C_LONGINT:C283($vi1; $vi2; $vi3; $viCount; $viRecords; $viNum; $1)
C_TEXT:C284($vtDice; $vtSpacePassword; $vtPassword; $vtSet; $vtUniqueID; $0)

//==================================
//  Initialize variables 
//==================================

$vbOK:=False:C215
$vbUnique:=False:C215
$vbAddNum:=False:C215
$vbAddSpace:=False:C215
$vi1:=0
$vi2:=0
$vi3:=0
$viCount:=0
$viRecords:=0
$viNum:=0
$vtDice:=""
$vtSpacePassword:=""
$vtPassword:=""
$vtSet:=""
$vtUniqueID:=""
//</declarations>

// save current selection of RemoteUsers
COPY NAMED SELECTION:C331([RemoteUser:57]; "RemoteUser")

// save current selection of GenericChild2
COPY NAMED SELECTION:C331([GenericChild2:91]; "GenericChild2")

// check for diceword data
QUERY:C277([GenericChild2:91]; [GenericChild2:91]name:3="DiceWord"; *)
QUERY:C277([GenericChild2:91]; [GenericChild2:91]purpose:4="Password"; *)
QUERY:C277([GenericChild2:91])


If (Records in selection:C76([GenericChild2:91])#0)
	
	If (Count parameters:C259>=1)
		$viCount:=$1
	Else 
		$viCount:=2
	End if 
	
	If (Count parameters:C259>=2)
		$vbAddNum:=$2
	Else 
		$vbAddNum:=False:C215
	End if 
	
	If (Count parameters:C259>=3)
		$vbAddSpace:=$3
	Else 
		$vbAddSpace:=False:C215
	End if 
	
	$vbUnique:=False:C215
	While ($vbUnique=False:C215)
		
		ARRAY TEXT:C222($atDiceWords; 0)
		ARRAY TEXT:C222($atDiceNumbers; 0)
		$vtPassword:=""
		$vtSpacePassword:=""
		
		For ($vi1; 1; $viCount)
			
			$vtDice:=""
			For ($vi2; 1; 4)
				$vbOK:=PHP Execute:C1058(""; "mt_rand"; $vi3; 1; 6)  // Mersenne Twister
				$vtDice:=$vtDice+String:C10($vi3)
			End for 
			
			QUERY:C277([GenericChild2:91]; [GenericChild2:91]name:3="DiceWord"; *)
			QUERY:C277([GenericChild2:91]; [GenericChild2:91]purpose:4="Password"; *)
			QUERY:C277([GenericChild2:91]; [GenericChild2:91]a01:28=$vtDice; *)
			QUERY:C277([GenericChild2:91])
			
			If ($vi1<=$viCount)
				APPEND TO ARRAY:C911($atDiceWords; [GenericChild2:91]a05:27)
				APPEND TO ARRAY:C911($atDiceNumbers; $vtDice)
			End if 
			
		End for 
		
		// choose random position for number
		If ($vbAddNum)
			$vbOK:=PHP Execute:C1058(""; "mt_rand"; $viNum; 1; $viCount)  // Mersenne Twister
		Else 
			$viNum:=0
		End if 
		
		// build password
		For ($vi1; 1; $viCount)
			
			If ($viNum=$vi1)
				$vtPassword:=$vtPassword+$atDiceNumbers{$vi1}
				$vtSpacePassword:=$vtSpacePassword+$atDiceNumbers{$vi1}+" "
			Else 
				$vtPassword:=$vtPassword+$atDiceWords{$vi1}
				$vtSpacePassword:=$vtSpacePassword+$atDiceWords{$vi1}
				If ($viNum<$viCount)
					$vtSpacePassword:=$vtSpacePassword+" "
				End if 
				
			End if 
			
		End for 
		
		// check for duplicate password
		QUERY:C277([RemoteUser:57]; [RemoteUser:57]userPassword:3=$vtPassword)
		$viRecords:=Records in selection:C76([RemoteUser:57])
		If ($viRecords>0)
			$vbUnique:=False:C215
			If (<>ConsoleProcess#0)  // send message to console if open
				ConsoleLog("Duplicate Password")
			End if 
		Else 
			$vbUnique:=True:C214
		End if 
		
	End while 
	
	If ($vbAddSpace=True:C214)
		$0:=$vtSpacePassword
	Else 
		$0:=$vtPassword
	End if 
	
	ConsoleLog($0)
	
Else 
	If (<>ConsoleProcess#0)  // send message to console if open
		ConsoleLog("Error:No Diceword Data")
	End if 
	$0:="Error:No Diceword Data"
End if 

// restore saved selection of RemoteUsers
USE NAMED SELECTION:C332("RemoteUser")

// restore saved selection of GenericChild2
USE NAMED SELECTION:C332("GenericChild2")

