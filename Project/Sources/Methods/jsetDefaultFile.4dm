//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-07-25T00:00:00, 09:29:46
// ----------------------------------------------------
// Method: jsetDefaultFile
// Description
// Modified: 07/25/13
// 
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptToSet)
If (Count parameters:C259=0)
	$ptToSet:=(->[QQQCustomer:2])
Else 
	If (Is nil pointer:C315($1))
		$1:=(->[Control:1])
	Else 
		$ptToSet:=$1
	End if 
End if 
//If (<>ptCurTable#$ptToSet)//### jwm ### 20130501_1448 changed ptCurTable to <>ptCurTable
<>ptCurTable:=$ptToSet
DEFAULT TABLE:C46($ptToSet->)
//OUTPUT FORM($ptToSet->;"o"+Table name($ptToSet)+"_"+screenSize)
//INPUT FORM($ptToSet->;"i"+Table name($ptToSet)+"_"+screenSize)
iLoPagePopUpMenuBar($ptToSet)
curTableNumAlt:=Table:C252($ptToSet)
//End if 