//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/12/09, 14:14:34
// ----------------------------------------------------
// Method: SOAP_ItemProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($theProcess)
C_LONGINT:C283($found)
$found:=Prs_CheckRunnin("Get Item")
//
If ($found>0)
	If (Frontmost process:C327#<>aPrsNum{$found})
		BRING TO FRONT:C326(<>aPrsNum{$found})
	End if 
Else 
	$theProcess:=New process:C317("SOAP_ItemGetWindow"; <>tcPrsMemory; "Get Item")
End if 

