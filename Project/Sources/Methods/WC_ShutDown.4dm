//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-01T00:00:00, 19:12:02
// ----------------------------------------------------
// Method: WC_ShutDown
// Description
// Modified: 09/01/17
// 
// 
//
// Parameters
// ----------------------------------------------------



<>vbWCstop:=True:C214  //issue a stop to all WC_ThreadPoolWorker

QUERY:C277([TallyResult:73]; [TallyResult:73]purpose:2="WebClerkSummary"; *)
QUERY:C277([TallyResult:73]; [TallyResult:73]name:1=String:C10(Current date:C33; Internal date short:K1:7))
If (Records in selection:C76([TallyResult:73])=0)
	CREATE RECORD:C68([TallyResult:73])
	[TallyResult:73]purpose:2:="WebClerkSummary"
	[TallyResult:73]name:1:=String:C10(Current date:C33; Internal date short:K1:7)
End if 
If ([TallyResult:73]textBlk1:5#"")
	[TallyResult:73]textBlk1:5:=("\r"*2)
End if 
[TallyResult:73]textBlk1:5:=[TallyResult:73]textBlk1:5+"Period of Operation: "+String:C10(Current date:C33)+": "+String:C10(<>dtStartWebClerk-DateTime_Enter)+("\r"*2)
[TallyResult:73]textBlk1:5:=WebClerkPageUsage
SAVE RECORD:C53([TallyResult:73])
REDUCE SELECTION:C351([TallyResult:73]; 0)