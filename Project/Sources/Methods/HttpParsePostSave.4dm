//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: HttpParsePostSave
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_POINTER:C301($1; ptCurTable)
C_BOOLEAN:C305($2; $newRecord)
$newRecord:=$2
ptCurTable:=$1
Case of 
	: ($1=(->[Payment:28]))
		Ledger_PaySave
		If ([Customer:2]customerID:1#[Payment:28]customerID:4)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerID:4)
			C_LONGINT:C283($curRecord)
			$curRecord:=Record number:C243([Payment:28])
			//Ledger_TallyBal(False; False)
			SAVE RECORD:C53([Customer:2])
			
			GOTO RECORD:C242([Payment:28]; $curRecord)
		End if 
End case 
QUERY:C277([TallyMaster:60]; [TallyMaster:60]tableNum:1=Table:C252(ptCurTable); *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]fieldNum:2=vWccSecurity; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="WccSave")
If ((Records in selection:C76([TallyMaster:60])=1) & ([TallyMaster:60]script:9#""))
	ExecuteText(0; [TallyMaster:60]script:9)
End if 
UNLOAD RECORD:C212([TallyMaster:60])
If (<>doFlushBuffers)
	FLUSH CACHE:C297
End if 