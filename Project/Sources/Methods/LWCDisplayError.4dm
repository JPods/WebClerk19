//%attributes = {"publishedWeb":true}
ConsoleLog("TEST: start")
If (False:C215)
	//Method: LWCDisplayInBrowser
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
If (Find in array:C230(<>aPrsNameWeb; "WC_@")<1)
	ALERT:C41("You must launch WebClerk server to use this feature.")
Else 
	$doKeepGoing:=True:C214
	$thePage:=""
	$theScript:=""
	C_LONGINT:C283($theRecNum)
	If (Count parameters:C259>0)
		$thePage:=$1
		If (Count parameters:C259>1)
			$theScript:=$2
		End if 
	End if 
	<>ptCurTable:=ptCurTable
	Case of 
		: (vHere<1)
			$doKeepGoing:=False:C215
			ALERT:C41("Must the in a Record to display pages")
		: (vHere=1)
			If (Records in selection:C76(ptCurTable->)>1)
				<>prcControl:=1
				$theRecNum:=-11
				CREATE SET:C116(<>ptCurTable->; "<>curSelSet")
			Else 
				FIRST RECORD:C50(<>ptCurTable->)
				$theRecNum:=Record number:C243(ptCurTable->)
				<>prcControl:=2
			End if 
		: (vHere>1)
			<>prcControl:=2
			AcceptPrint
			C_LONGINT:C283($theRecNum)
			$theRecNum:=Record number:C243(ptCurTable->)
	End case 
	ConsoleLog("TEST: process ready")
	If ($doKeepGoing)
		<>processAlt:=New process:C317("LWCStartProcess"; <>tcPrsMemory; String:C10(Count user processes:C343)+"- 2 Browser"; $thePage; $theRecNum; $theScript)
	End if 
End if 
ConsoleLog("TEST: process launched")