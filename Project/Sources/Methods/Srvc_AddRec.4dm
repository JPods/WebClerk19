//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
KeyModifierCurrent
Case of 
	: (OptKey=1)
		OBJECT SET ENTERABLE:C238([Customer:2]dateService:63; True:C214)
	: (CmdKey=1)
		[Customer:2]dateService:63:=Current date:C33
	Else 
		READ WRITE:C146([TallyResult:73])
		QUERY:C277([TallyResult:73]; [TallyResult:73]customerID:30=[Customer:2]customerID:1; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12=DateTime_Enter([Customer:2]dateService:63; ?00:00:00?); *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="Service Contract")
		If (Records in selection:C76([TallyResult:73])=0)
			myOK:=10
			ADD RECORD:C56([TallyResult:73])
		Else 
			MODIFY SELECTION:C204([TallyResult:73])
		End if 
		If (($1=1) & (Record number:C243([TallyResult:73])>-1))
			[Customer:2]dateService:63:=Date:C102([TallyResult:73]profile2:18)
			[Customer:2]serviceHrAvail:82:=[TallyResult:73]real2:14
			SAVE RECORD:C53([Customer:2])
		End if 
		READ ONLY:C145([TallyResult:73])
End case 