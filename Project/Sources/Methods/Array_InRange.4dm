//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Array_InRange  
	//Date: 07/01/02
	//Who: Bill James
	//Description: Admin control of AreaList Arrays
	VERSION_960
End if 

C_BOOLEAN:C305($0)
$0:=False:C215
C_POINTER:C301($1; $2)
If (Size of array:C274($1->)>0)
	If ($1->{1}<=Size of array:C274($2->))
		$0:=True:C214
	End if 
End if 