//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/14/17, 9:34:17
// ----------------------------------------------------
// Method: TPB_GetValueFromCurRec
//
// Description:
// 
// This method is sent the name of a process array variable
// and a iterator and returns the content of that variable,
// if it exists.
//
// Parameters
// ----------------------------------------------------

// ******************************************* //
// ****** TYPE AND INITIALIZE PARAMETERS ***** //
// ******************************************* //

// RETURN VARIABLE
C_TEXT:C284($0; $vtOutput)
$0:=""
$vtOutput:=""

// PARAMETER 1 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_TEXT:C284($1; $vtTableNum)
$vtTableNum:=$1

// PARAMETER 2 IS THE SPECIFIED FORMAT TO RETURN
// THE VALUE IN. THIS CONTROLS THINGS LIKE CHANGING
// LINE BREAKS TO "<br>" FOR HTML OUTPUT.
C_TEXT:C284($2; $vtFieldNum)
$vtFieldNum:=$2

// PARAMETER 2 IS THE SPECIFIED FORMAT TO RETURN
// THE VALUE IN. THIS CONTROLS THINGS LIKE CHANGING
// LINE BREAKS TO "<br>" FOR HTML OUTPUT.
C_TEXT:C284($3; $vtOutputFormat)
$vtOutputFormat:=$3


// ********************************************* //
// **** CONVERT TABLE AND FIELD NUMS TO INT **** //
// ********************************************* //

C_LONGINT:C283($viTableNum; $viFieldNum)

$viTableNum:=Num:C11($vtTableNum)
$viFieldNum:=Num:C11($vtFieldNum)

// ********************************************* //
// ****** PROCESS THE TABLE AND FIELD ********** //
// ****** NUM, THEN FORMAT AND RETURN ********** //
// ********************************************* //

If ($viTableNum<0)
	$vtOutput:="Error: "+$vtTableNum+" is not a valid table number."
Else 
	If ($viFieldNum<=0)
		Case of 
			: ($viFieldNum=-2)  //Record number
				$vtOutput:=String:C10(Record number:C243(Table:C252($viTableNum)->))
			: ($viFieldNum=0)  //Records in selection
				$vtOutput:=String:C10(Records in selection:C76(Table:C252($viTableNum)->))
			: ($viFieldNum=-1)  //Table Name
				$vtOutput:=Table name:C256($viTableNum)
			Else 
				$vtOutput:="Error: "+String:C10($viFieldNum)+" is not a valid special number."
		End case 
	Else 
		C_POINTER:C301($vpField)
		$vpField:=Field:C253($viTableNum; $viFieldNum)
		$vtOutput:=TP_FormatOutput($vpField; $vtOutputFormat)
	End if 
End if 

$0:=$vtOutput