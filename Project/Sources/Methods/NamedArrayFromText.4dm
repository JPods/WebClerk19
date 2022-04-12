//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-01-02T00:00:00, 01:25:58
// ----------------------------------------------------
// Method: NamedArrayFromText
// Description
// Modified: 01/02/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptToArray; $2; $ptToText)
$ptToArray:=$1
$ptToText:=$2

ARRAY LONGINT:C221(aNamedArrayCustomers; 0)
ARRAY LONGINT:C221(aNamedArrayOrders; 0)
ARRAY LONGINT:C221(aNamedArrayItems; 0)
ARRAY LONGINT:C221(aNamedArrayPayments; 0)
ARRAY LONGINT:C221(aNamedArray; 0)
ARRAY LONGINT:C221(aNamedArray2; 0)
ARRAY LONGINT:C221(aNamedArray3; 0)
ARRAY TEXT:C222(aTextLongInt; 0)
TextToArray($2->; ->aTextLongInt; "\t")
C_LONGINT:C283($incRay; $cntRay)
$cntRay:=Size of array:C274(aTextLongInt)
ARRAY LONGINT:C221($ptToArray->; $cntRay)
For ($incRay; 1; $cntRay)
	$ptToArray->{$incRay}:=Num:C11(aTextLongInt{$incRay})
End for 
ARRAY TEXT:C222(aTextLongInt; 0)



