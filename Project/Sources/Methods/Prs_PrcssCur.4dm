//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Prs_PrcssCur
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283(<>processAlt)
C_POINTER:C301(<>ptCurTable; $ptFile)
//If (Count parameters=0)
KeyModifierCurrent
//Else 
//OptKey=$1
//End if 
myOK:=0
If (vHere>1)
	PUSH RECORD:C176(ptCurTable->)
	$ptFile:=ptCurTable
End if 
If (OptKey=1)
	File_Select("Select the file for which you wish to show records.")  //Show an existing selection in the a new process
	//If myOK is zero, skips next actions
	//testThis
Else 
	<>ptCurTable:=(->[Control:1])
	myOK:=1
	<>prcControl:=2
End if 
TRACE:C157
If (myOK=1)
	If (Not:C34(curTableNum>0))
		curTableNum:=Table:C252(->[Customer:2])
	End if 
	DB_ShowCurrentSelection(Table:C252(curTableNum))
End if 
If (vHere>1)
	ptCurTable:=$ptFile
	POP RECORD:C177(ptCurTable->)
End if 
jrelateClrFiles
C_LONGINT:C283($viProcess)
$viProcess:=Current process:C322
Case of   //why is this here???
	: (vHere=0)
		SET MENU BAR:C67(splashMenu; $viProcess)
	: (vHere=1)
		SET MENU BAR:C67(oLoMenu; $viProcess)
	: (vHere>1)
		SET MENU BAR:C67(iLoMenu; $viProcess)
End case 