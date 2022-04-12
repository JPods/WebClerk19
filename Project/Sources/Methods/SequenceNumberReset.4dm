//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-06-02T00:00:00, 13:44:47
// ----------------------------------------------------
// Method: SequenceNumberReset
// Description
// Modified: 06/02/17
// 
// 
//
// Parameters
// ----------------------------------------------------


// Only for LongInt

C_POINTER:C301(uPointer1)
C_LONGINT:C283(maxValue)
If (Count parameters:C259=0)
	uPointer1:=(->[ProposalLine:43])
	uPointer2:=(->[ProposalLine:43]idUnique:52)
Else 
	uPointer1:=$1
	uPointer2:=$2
End if 

READ WRITE:C146(uPointer1->)

ALL RECORDS:C47(uPointer1->)
ORDER BY:C49(uPointer1->; uPointer2->; <)
FIRST RECORD:C50(uPointer1->)
If (maxValue<uPointer2->)
	maxValue:=uPointer2->
End if 


C_LONGINT:C283(sequenceNum)
sequenceNum:=Sequence number:C244(uPointer1->)
If (sequenceNum<=maxValue)
	SET DATABASE PARAMETER:C642(uPointer1->; Table sequence number:K37:31; maxValue+10)
	// SET DATABASE PARAMETER([Project];Table sequence number;201773)
	sequenceNum:=maxValue+10
End if 
maxValue:=Records in table:C83(uPointer1->)
If ($equenceNum<maxValue)
	SET DATABASE PARAMETER:C642(uPointer1->; Table sequence number:K37:31; maxValue+10)
End if 