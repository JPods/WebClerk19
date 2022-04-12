//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2; $3)
C_BOOLEAN:C305($doCombine)
C_LONGINT:C283($revert; $curRec)
$curRec:=Record number:C243([Customer:2])
//File;AcctCode;srAcct
KeyModifierCurrent
PUSH RECORD:C176([Customer:2])
QUERY:C277([Customer:2]; [Customer:2]customerID:1=srAcct)
TRACE:C157
Case of 
	: (($curRec=-3) & (Records in selection:C76([Customer:2])=0))
		POP RECORD:C177([Customer:2])
		[Customer:2]customerID:1:=srAcct
	: (OptKey=1)
		$revert:=Record number:C243([Customer:2])*Num:C11(Records in selection:C76([Customer:2])=1)
		POP RECORD:C177([Customer:2])
		If (Record number:C243([Customer:2])>-3)
			$doCombine:=ConsolidateRecs(->[Customer:2]; ->[Customer:2]customerID:1; ->srAcct)
		End if 
		Case of 
			: (Is new record:C668([Customer:2]))
				[Customer:2]customerID:1:=srAcct
			: ($doCombine=False:C215)
				$3->:=$2->
			: ($revert>0)
				TRACE:C157
				GOTO RECORD:C242([Customer:2]; $curRec)
				DELETE RECORD:C58([Customer:2])
				GOTO RECORD:C242([Customer:2]; $revert)
				srVarLoad(2)  //fill with customer information
				//jCancelButton (False)
			Else 
				$2->:=$3->
				SAVE RECORD:C53([Customer:2])
		End case 
	: (Records in selection:C76($1->)=0)
		POP RECORD:C177([Customer:2])
		$doCombine:=ConsolidateRecs(->[Customer:2]; ->[Customer:2]customerID:1; $3)
		$2->:=$3->
		SAVE RECORD:C53([Customer:2])
	Else 
		vTempAcct:=$2->
		vDiaCom:="Create a unique Customer Account Code."
		jCenterWindow(266; 204; 1)
		DIALOG:C40([Customer:2]; "diaAcctNums")
		CLOSE WINDOW:C154
		vDiaCom:=""
		ARRAY TEXT:C222(aCustCodes; 0)
		POP RECORD:C177($1->)
		If (OK=1)
			$3->:=vTempAcct
			$2->:=$3->
			$doChange:=True:C214
		End if 
		CLEAR VARIABLE:C89(vTempAcct)
End case 