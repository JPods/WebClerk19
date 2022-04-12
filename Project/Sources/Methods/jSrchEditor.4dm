//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/19/18, 15:17:36
// ----------------------------------------------------
// Method: jSrchEditor
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptSrchFile; $ptBaseFile)

If (Count parameters:C259=0)
	Case of 
		: ((curTableNum<2) & (vHere<1))
			curTableNum:=2
		: (curTableNum<2)
			curTableNum:=Table:C252(ptCurTable)
	End case 
	$ptSrchFile:=Table:C252(curTableNum)
Else 
	$ptSrchFile:=$1
End if 
C_LONGINT:C283($recDo; $recNum)
$recDo:=0
$recNum:=-1
myOK:=0
If (vHere<1)
	Srch_FullDia($ptSrchFile)
Else 
	If ((vHere>1) & ($ptSrchFile=ptCurTable))
		If (Modified record:C314(ptCurTable->))
			myCycle:=6
			jAcceptButton
		End if 
		$recNum:=Record number:C243(ptCurTable->)
		Srch_FullDia(ptCurTable)
		$recDo:=myOK
	Else 
		Srch_FullDia($ptSrchFile)
		If ((vHere=0) & (myOK=1))
			iLoPagePopUpMenuBar(Table:C252(curTableNum))
		End if 
		$recDo:=myOK
	End if 
	
	JSrchEnd($recDo; $recNum)
	MenuBarByLevel
	MenuTitle
End if 