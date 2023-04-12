//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 11/16/17, 12:13:04
// ----------------------------------------------------
// Method: HTML_BuildOptions
// Description:
//
// This method builds a set of  HTML <option>s for a Select Tag 
// based off of provided arrays.
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20171121_1636 Changed to build Options from Build Select to allow more flexibility

// $vtHTML. THIS WILL HOLD THE FINAL HTML TEXT STRING, A FULLY
// FINISHED HTML SELECT ELEMENT WITH OPTIONS INSIDE

C_TEXT:C284($0; $vtHTML)
$vtHTML:=""

// $atChoiceValues. REQUIRED. THIS PARAMETER IS AN ARRAY OF CHOICE VALUES. IT IS PASSED IN
// AS A POINTER BECAUSE 4D CAN'T PASS ARRAYS

ARRAY TEXT:C222($atChoiceValues; 0)
COPY ARRAY:C226($1->; $atChoiceValues)

// $atChoices. REQUIRED. THIS PARAMETER IS AN ARRAY OF CHOICE DISPLAYS. IT IS PASSED IN
// AS A POINTER BECAUSE 4D CAN'T PASS ARRAYS

ARRAY TEXT:C222($atChoiceDisplays; 0)
COPY ARRAY:C226($2->; $atChoiceDisplays)

// $vbSelectedFoundInList IS A FLAG TO KEEP TRACK OF IF THE SELECT CHOICE HAS BEEN FOUND IN THE
// LIST OF CHOICES
C_BOOLEAN:C305($vbSelectedFoundInList)
$vbSelectedFoundInList:=False:C215

// $vtSelected. OPTIONAL. THIS PARAMETER IS CURRENTLY SELECTED OPTION. IF EMPTY,
// THE SELECT IS RETURNED WITHOUT ANY OPTION SELECTED

C_TEXT:C284($vtSelected)
If (Count parameters:C259>2)
	C_TEXT:C284($3)
	$vtSelected:=$3
Else 
	$vtSelected:=""
End if 

// FIRST, CHECK TO MAKE SURE THAT THE LENGTH OF THE TWO ARRAYS BEING SENT IS THE SAME. IF NOT, RETURN
// AN EMPTY STRING AND LOG AN ERROR MESSAGE TO THE CONSOLE.

If (Size of array:C274($atChoiceValues)#Size of array:C274($atChoiceDisplays))
	
	$0:=""
	
	ConsoleLog("Error during HTML Select creation. Size of value array doesn't match size of choice array.")
	
Else 
	
	C_LONGINT:C283($viCount; $viIncrementor)
	$viCount:=Size of array:C274($atChoiceValues)
	$viIncr:=0
	
	// BUILD HTML
	
	For ($viIncr; 1; $viCount)
		
		If (($vtSelected#"") & ($vtSelected=($atChoiceValues{$viIncr})))
			
			$vbSelectedFoundInList:=True:C214
			
			$vtHTML:=$vtHTML+"<option selected value=\""+$atChoiceValues{$viIncr}+"\">"+$atChoiceDisplays{$viIncr}+"</option>"
			
		Else 
			
			$vtHTML:=$vtHTML+"<option value=\""+$atChoiceValues{$viIncr}+"\">"+$atChoiceDisplays{$viIncr}+"</option>"
			
		End if 
		
	End for 
	
	// AZM PREPEND THE SELECTED CHOICE TO LIST IF IT ISN'T AN OPTION. THIS WILL PREVENT UNINTENDED CHANGES 
	
	If (($vtSelected#"") & ($vbSelectedFoundInList=False:C215))
		
		$vtHTML:="<option selected value=\""+$vtSelected+"\">"+$vtSelected+"</option>"+$vtHTML
		
	End if 
	
	$0:=$vtHTML
	
End if 
