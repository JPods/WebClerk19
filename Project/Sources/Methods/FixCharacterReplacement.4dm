//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/25/20, 15:59:07
// ----------------------------------------------------
// Method: FixCharacterReplacement
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283(vi7; vi8)

vi2:=Get last field number:C255(2)
For (vi1; 1; vi2)
	GET FIELD PROPERTIES:C258(2; vi1; vi7)  // file #, field #, type, length, index
	If ((vi7=Is alpha field:K8:1) | (vi7=Is text:K8:3))
		Field:C253(2; vi1)->:=Replace string:C233(Field:C253(2; vi1)->; "+"; " ")
	End if 
End for 
SAVE RECORD:C53([QQQCustomer:2])

