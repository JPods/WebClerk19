//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/17/17, 12:35:22
// ----------------------------------------------------
// Method: jSrchResponse
// Description
// 
//
// Parameters
// ----------------------------------------------------
//(P)  jSrchResponse
C_TEXT:C284($response; $4; $idStr; $defaultResponse)
C_POINTER:C301($1; $2; ptCurTable)  //File and field to search
C_TEXT:C284($3)  //Type of field
C_LONGINT:C283($recDo; $recNum)
C_LONGINT:C283(vHere)

SET MENU BAR:C67(6; Current process:C322; *)  // ### jwm ### 20170517_1235 is there a better method to call

If (Is nil pointer:C315(ptCurTable))
	ptCurTable:=$1
End if 
If (Count parameters:C259=4)
	$idStr:=$4
Else 
	$idStr:=""
End if 

If (vHere>1)
	If (Modified record:C314(ptCurTable->))  //NO CANCEL
		myCycle:=6
		jAcceptButton
	End if 
	$recNum:=Record number:C243(ptCurTable->)
End if 
// Modified by: williamjames (121107)
C_LONGINT:C283($docNum)

$defaultResponse:=Get text from pasteboard:C524
// $response:=Request("Search "+Field name($2)+"="+$idStr;$defaultResponse)
$response:=Request:C163("Search "+Field name:C257($2)+"="+$idStr; Substring:C12(Get text from pasteboard:C524; 1; 50); "OK"; "Cancel")
If (OK=1)  //assure cmd only is available to the current file
	MESSAGES OFF:C175
	Case of 
		: (($3="A") | ($3="T"))
			QUERY:C277($1->; $2->=$response+"@")
		: ($3="C")
			QUERY:C277($1->; $2->="@"+$response+"@")
		: (($3="i") | ($3="L"))  //  :(type($2->)=Is LongInt)
			$response:=Preg Replace("[^0-9]"; ""; $response; Regex Multi Line+Regex Ignore Case)
			
			$docNum:=Num:C11($response)
			QUERY:C277($1->; $2->=$docNum)  // (UtilReturn_number ($response;"longint")))
		: ($3="R")
			$response:=Preg Replace("[^0-9.-]"; ""; $response; Regex Multi Line+Regex Ignore Case)
			$docNum:=Num:C11($response)
			QUERY:C277($1->; $2->=$docNum)  // (UtilReturn_number ($response;"longint")))
			// QUERY($1->;$2->=(UtilReturn_number ($response;"real")))
		: ($3="D")
			QUERY:C277($1->; $2->=(Date:C102($response)))
		: ($3="h")
			QUERY:C277($1->; $2->=(Time:C179($response)))
	End case 
	$recDo:=1
	//If ((vHere=2)&(Records in selection(ptCurFile)=0))
	//GOTO RECORD(ptCurFile;$recNum)
	//BEEP
	//BEEP
	//End if   
	If ((vHere<2) & (ptCurTable#($1)))
		//Assure that the menus and screens are set w/o (P) jSetDefaultFile     
		iLoPagePopUpMenuBar($1)  // This should be reviewed for removal
	End if 
	MESSAGES ON:C181
	//booPreNext:=True
	//If (StopModLoop=True)
	//StopModLoop:=False
	//End if 
	//ProcessTableOpen ($1)
	JSrchEnd($recDo; $recNum)  //assumes you know the file you want
End if 

