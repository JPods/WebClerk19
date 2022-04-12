//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/04/14, 13:16:42
// ----------------------------------------------------
// Method: FindContactArray
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(vHere)
If (vHere=0)
	Process_InitLocal
	jsetDefaultFile(->[Contact:13])
End if 
If (Records in selection:C76([Contact:13])>20)
	REDUCE SELECTION:C351([Contact:13]; 0)
End if 
jSrchCustLoad(->[Contact:13]; ->[Contact:13]company:23; ->srCustomer; False:C215)
booPreNext:=True:C214