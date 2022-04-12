//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-10-17T00:00:00, 11:52:57
// ----------------------------------------------------
// Method: jArchExportRay
// Description
// Modified: 10/17/17
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------

// corrected for display in export editor missing the count column
C_LONGINT:C283($k2; $i)
ARRAY TEXT:C222(aMatchField; 0)
ARRAY TEXT:C222(aMatchType; 0)
For ($i; 1; Size of array:C274(theFields))
	If ((theTypes{$i}#"P") & (theTypes{$i}#"*") & (theTypes{$i}#" "))
		$k2:=Size of array:C274(aMatchField)+1
		INSERT IN ARRAY:C227(aMatchField; $k2)
		INSERT IN ARRAY:C227(aMatchType; $k2)
		INSERT IN ARRAY:C227(aMatchNum; $k2)
		aMatchField{$k2}:=theFields{$i}
		aMatchType{$k2}:=theTypes{$i}
		aMatchNum{$k2}:=theFldNum{$i}
	End if 
End for 
C_LONGINT:C283($inc; $sizeCounterRay)
$sizeCounterRay:=Size of array:C274(aMatchField)
ARRAY LONGINT:C221(aCntMatFlds; $sizeCounterRay)
For ($inc; 1; $sizeCounterRay)
	aCntMatFlds{$inc}:=$inc
End for 