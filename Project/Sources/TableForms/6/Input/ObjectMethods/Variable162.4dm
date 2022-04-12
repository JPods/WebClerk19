[Service:6]dtAction:35:=DateTime_Enter
KeyModifierCurrent
If (OptKey=1)
	// zzzqqq jDateTimeStamp(->[Service:6]comment:11)
End if 
_O_OBJECT SET COLOR:C271([Service:6]timer:34; -(15+(256*8)))
If ([Customer:2]dateService:63>=Current date:C33)
	TRACE:C157
	QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="Service Contract"; *)
	QUERY:C277([TallyResult:73];  & [TallyResult:73]customerID:30=[Customer:2]customerID:1)
End if 
Case of 
	: ([Service:6]noteType:21#"")  //no action
	: ((Records in selection:C76([TallyResult:73])=1) & (Date:C102([TallyResult:73]profile2:18)>=Current date:C33))  //currently on maint
		[Service:6]noteType:21:="TS-Maint"
		[Service:6]costToCustomer:8:=100
		//: (([Customer]DateService=!00/00/00!)|([Customer]DateService<Current date))
	Else 
		[Service:6]noteType:21:="TS-Billable"
End case 
UNLOAD RECORD:C212([TallyResult:73])