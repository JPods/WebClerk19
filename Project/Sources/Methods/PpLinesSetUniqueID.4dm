//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 2013-11-25T00:00:00, 12:12:22
// ----------------------------------------------------
// Method: PpLinesSetUniqueID
// Description
// Modified: 11/25/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



Open window:C153(100; 200; 500; 300; 5; "Setting ProposalLines UniqueID ...")
ERASE WINDOW:C160
GOTO XY:C161(6; 3)

QUERY:C277([ProposalLine:43]; [ProposalLine:43]idUnique:52=0; *)
QUERY:C277([ProposalLine:43])

vi2:=Records in selection:C76([ProposalLine:43])
FIRST RECORD:C50([ProposalLine:43])
For (vi1; 1; vi2)
	
	vrPercent:=Round:C94((vi1/vi2*100); 0)
	ERASE WINDOW:C160
	GOTO XY:C161(6; 3)
	MESSAGE:C88(" Record "+String:C10(vi1)+" of "+String:C10(vi2)+"  "+String:C10(vrPercent)+" %")
	
	
	SAVE RECORD:C53([ProposalLine:43])
	NEXT RECORD:C51([ProposalLine:43])
End for 

ERASE WINDOW:C160
CLOSE WINDOW:C154