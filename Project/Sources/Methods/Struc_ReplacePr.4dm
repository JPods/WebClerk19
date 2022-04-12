//%attributes = {"publishedWeb":true}
//Procedure: Struc_ReplacePr(theArrayStr;FldNameStr;number of them)
C_TEXT:C284($1; $2; $theField)
C_LONGINT:C283($i; $3)
C_POINTER:C301($ptRay)
For ($i; 1; $3)
	$theField:=$2+String:C10($i)
	$w:=Find in array:C230(theFields; $theField)
	$ptRay:=Get pointer:C304($1+String:C10($i))
	theFields{$w}:="P"+String:C10($i)+"_"+$ptRay->{1}
End for 