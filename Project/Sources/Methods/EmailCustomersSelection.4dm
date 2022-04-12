//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-11-01T00:00:00, 00:22:07
// ----------------------------------------------------
// Method: EmailCustomersSelection
// Description
// Modified: 11/01/17
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283(vi5)
C_TEXT:C284(vText1)
vi5:=Character code:C91("@")
vText1:=Char:C90(vi5)

vi2:=Records in selection:C76([QQQCustomer:2])
FIRST RECORD:C50([QQQCustomer:2])
For (vi1; 1; vi2)
	If ((Position:C15("&~"; [QQQCustomer:2]email:81)>0) | (Position:C15(vText1; [QQQCustomer:2]email:81)>0))
		C_LONGINT:C283(bEmailVerified)
		EmailVerifyNow([QQQCustomer:2]email:81; [QQQCustomer:2]nameFirst:73+" "+[QQQCustomer:2]nameLast:23; ptCurTable)
		DELAY PROCESS:C323(Current process:C322; 30)
	Else 
		[QQQCustomer:2]emailVerified:110:=!2002-01-01!
	End if 
	SAVE RECORD:C53([QQQCustomer:2])
	NEXT RECORD:C51([QQQCustomer:2])
End for 
UNLOAD RECORD:C212([QQQCustomer:2])



