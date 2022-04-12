//%attributes = {"publishedWeb":true}
C_POINTER:C301($0)  //Resulting pointer to a field
C_POINTER:C301($1)  //pointer to Info from a Field Row of a TextOut Doc
C_LONGINT:C283($Pos; $soa)
$0:=<>cptNilPoint
If ((Strc_GetVersInt($1->)<=Strc_GetVersInt(Storage:C1525.version.rev)))
	$soa:=Size of array:C274(aTIOText)+1
	INSERT IN ARRAY:C227(aTIOText; $soa)
	aTIOText{$soa}:=$1->
	$0:=->aTIOText{$soa}
End if 