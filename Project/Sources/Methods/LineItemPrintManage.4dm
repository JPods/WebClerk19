//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/28/08, 14:43:50
// ----------------------------------------------------
// Method: LineItemPrintManage
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $2)
Case of 
	: ($1=1)  //setup 
		
	: ($1=2)  //click on the tag
		If (pPrintThis=1)
			pPrintThis:=0
		Else 
			pPrintThis:=1
		End if 
End case 
If (pPrintThis=0)
	pvPrintThis:="Print = True.  Click to set False"
Else 
	pvPrintThis:="Print = False.  Click to set True"
End if 