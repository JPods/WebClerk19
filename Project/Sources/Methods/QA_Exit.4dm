//%attributes = {"publishedWeb":true}
//Procedure: QA_Exit
//January 2, 1996//TRACE
//called in AL Definitions
C_BOOLEAN:C305($0)  //Entry Valid (True) or Entry Rejected (False)
C_LONGINT:C283($1)  //Area Name
C_LONGINT:C283($2)  //Action that Caused Entry Finished
$0:=True:C214
C_LONGINT:C283($col; $row)
//
//  CHOPPED  AL_GetCurrCell($1; $col; $row)
If (aQaAskedBy{$row}="")
	aQaAnswDt{$row}:=Current date:C33
	aQaAskedBy{$row}:=Current user:C182
End if 
If (aQaAnswrRec{$row}>-1)
	READ WRITE:C146([QA:70])
	GOTO RECORD:C242([QA:70]; aQaAnswrRec{$row})
	[QA:70]answer:6:=aQaAnswr{$row}
	[QA:70]idNumQAAnswer:3:=aQaAnswKey{$row}
	[QA:70]dateOfAnswer:4:=Current date:C33
	[QA:70]seq:10:=aQaSeq{$row}
	SAVE RECORD:C53([QA:70])
	UNLOAD RECORD:C212([QA:70])
	//READ ONLY([WorkOrder])
End if 
//  --  CHOPPED  AL_UpdateArrays($1; -2)