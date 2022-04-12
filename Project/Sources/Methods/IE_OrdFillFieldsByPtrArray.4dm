//%attributes = {"publishedWeb":true}
//Method: PM:  IE_OrdFillFieldsByPtrArray
//Noah Dykoski   May 13, 2000 / 4:16 AM
C_TEXT:C284($0)  //Audit Trail comment
C_POINTER:C301($1; $FieldArrayPtr)
$FieldArrayPtr:=$1
C_POINTER:C301($2; $DataArrayPtr)
$DataArrayPtr:=$2

$0:="IE_Ord import updated the following data on "+String:C10(Current date:C33; Internal date short:K1:7)+"\r"

C_LONGINT:C283($index)
For ($index; 1; Size of array:C274($FieldArrayPtr->))
	C_POINTER:C301($pointer)
	$pointer:=$FieldArrayPtr->{$index}
	C_LONGINT:C283($Type)
	$Type:=Type:C295($pointer->)
	Case of 
		: (($Type=Is alpha field:K8:1) | ($Type=Is text:K8:3) | ($Type=Is string var:K8:2))  //string
			If ($pointer->#$DataArrayPtr->{$index})
				If ($pointer->#"")
					$0:=$0+Util_GetPointerName($pointer)+" was: "+$pointer->+"\r"
				End if 
				$pointer->:=$DataArrayPtr->{$index}
			End if 
		: (($Type=Is integer:K8:5) | ($Type=Is longint:K8:6) | ($Type=Is real:K8:4))  //Numbers
			If ($pointer->#Num:C11($DataArrayPtr->{$index}))
				$0:=$0+Util_GetPointerName($pointer)+" was: "+String:C10($pointer->)+"\r"
				$pointer->:=Num:C11($DataArrayPtr->{$index})
			End if 
		: ($Type=Is time:K8:8)  //time
			If ($pointer->#Time:C179($DataArrayPtr->{$index}))
				$0:=$0+Util_GetPointerName($pointer)+" was: "+String:C10($pointer->; HH MM SS:K7:1)+"\r"
				$pointer->:=Time:C179($DataArrayPtr->{$index})
			End if 
		: ($Type=Is date:K8:7)  //date
			If ($pointer->#Date:C102($DataArrayPtr->{$index}))
				$0:=$0+Util_GetPointerName($pointer)+" was: "+String:C10($pointer->; Internal date short:K1:7)+"\r"
				$pointer->:=Date:C102($DataArrayPtr->{$index})
			End if 
		: ($Type=Is boolean:K8:9)  //boolean
			C_BOOLEAN:C305($NewBooleanValue)
			If (($DataArrayPtr->{$index}="true") | ($DataArrayPtr->{$index}="yes") | ($DataArrayPtr->{$index}="1"))
				$NewBooleanValue:=True:C214
			Else 
				$NewBooleanValue:=False:C215
			End if 
			If ($pointer->#$NewBooleanValue)
				$0:=$0+Util_GetPointerName($pointer)+" was: "+String:C10($pointer->; "true;false")+"\r"
				$pointer->:=$NewBooleanValue
			End if 
	End case 
End for 