//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/31/11, 07:21:09
// ----------------------------------------------------
// Method: UTLoadDoc2Array
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($0; $incRay)
C_TEXT:C284($1; $docPath)
C_POINTER:C301($2)
C_TIME:C306($myDoc)
$docPath:=$1
$0:=0
$incRay:=0
$myDoc:=Open document:C264($docPath)
If (OK=1)
	ARRAY TEXT:C222($2->; 0)
	Repeat   //load in the document
		$incRay:=$incRay+1
		INSERT IN ARRAY:C227($2->; $incRay; 1)
		RECEIVE PACKET:C104($myDoc; $2->{$incRay}; 15000)
		If (OK=1)
			$2->{$incRay}:=Replace string:C233($2->{$incRay}; Storage:C1525.char.crlf; "\r")  //small chance of a spliting a Storage.char.crlf and miss reading.
			$2->{$incRay}:=Replace string:C233($2->{$incRay}; "\n"; "\r")  //would be better converting this to a blob behavior
		End if 
	Until (OK=0)  //|(Length($2->{$incRay})<15000))
	CLOSE DOCUMENT:C267($myDoc)
	$0:=1
End if 
