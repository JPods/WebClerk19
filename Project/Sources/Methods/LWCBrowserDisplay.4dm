//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: LWCBrowserDisplay
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
If (Find in array:C230(<>aPrsNameWeb; "WC_@")<1)
	ALERT:C41("You must launch WebClerk server to use this feature.")
Else 
	$doKeepGoing:=True:C214
	<>jitPageOne:=""
	<>jitScript:=""
	<>jitRecordNum:=-1
	C_LONGINT:C283($theRecNum)
	If (Count parameters:C259>0)
		<>jitPageOne:=$1
		If (Count parameters:C259>1)
			<>jitScript:=$2
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
				<>jitRecordNum:=-11
				CREATE SET:C116(<>ptCurTable->; "<>curSelSet")
			Else 
				FIRST RECORD:C50(<>ptCurTable->)
				<>jitRecordNum:=Record number:C243(ptCurTable->)
				<>prcControl:=2
			End if 
		: (vHere>1)
			<>prcControl:=2
			AcceptPrint
			C_LONGINT:C283(<>jitRecordNum)
			<>jitRecordNum:=Record number:C243(ptCurTable->)
	End case 
	If ($doKeepGoing)
		<>processAlt:=New process:C317("LWCStartProcess"; <>tcPrsMemory; "2 Browser")
	End if 
End if 
