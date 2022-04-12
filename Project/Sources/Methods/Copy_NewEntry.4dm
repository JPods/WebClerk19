//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2; $3)
If (Record number:C243($1->)=-3)  //text or strings only
	//  If ($3="")//add a case statement to allow other types
	$3->:=$2->
	//  End if 
End if 