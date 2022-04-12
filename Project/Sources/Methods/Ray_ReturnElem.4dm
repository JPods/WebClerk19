//%attributes = {"publishedWeb":true}
C_LONGINT:C283($0)
C_POINTER:C301($1)
Case of 
	: (Size of array:C274($1->)=0)
		$0:=0
	: (Size of array:C274($1->)<$1->)
		$0:=Size of array:C274($1->)
	Else 
		$0:=$1->
End case 