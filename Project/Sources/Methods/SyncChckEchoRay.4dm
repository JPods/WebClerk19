//%attributes = {"publishedWeb":true}
//SyncChckEchoRay ([Customer];[Invoice];[Inv]AccountKey;[Inv]Comment)
C_POINTER:C301($1; $2; $3; $4)
C_LONGINT:C283($i; $w)
$i:=Type:C295($3->)
If (($i=0) | ($i=2))
	$tempStr:=$3->
Else 
	$tempStr:=String:C10($3->)
End if 
$w:=SyncUpDateRef(Table:C252($1); $tempStr)
If ($w#-1)  //if a relation was changed add a echo for this record.
	SyncEchoRays(Table:C252($2); Field:C253($3); Type:C295($3->); aSyMatWas{$w}; aSyMatIs{$w})
	$4->:=$4->+"\r"+"Syn mod "+aSyMatWas{$w}+" to "+aSyMatIs{$w}
	If (($i=0) | ($i=2))
		$3->:=aSyMatIs{$w}
	Else 
		$3->:=Num:C11(aSyMatIs{$w})
	End if 
End if 