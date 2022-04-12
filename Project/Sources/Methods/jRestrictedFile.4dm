//%attributes = {"publishedWeb":true}
C_POINTER:C301($ptFile; $1)
C_BOOLEAN:C305($0)
If (Count parameters:C259=1)
	$ptFile:=$1
Else 
	$ptFile:=ptCurTable
End if 
$0:=False:C215
Case of 
	: ($ptFile=(->[QQQCounter:41]))
		//if((
		//$0:=True
		//end if
	: (($ptFile=(->[DefaultQQQ:15])) | ($ptFile=(->[DefaultAccount:32])))
		If (Records in table:C83($ptFile->)=1)
			$0:=True:C214
		Else 
			$0:=False:C215
		End if 
End case 