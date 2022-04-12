//%attributes = {"publishedWeb":true}
//Method: PM:  Util_GetPointerName
//Noah Dykoski   May 22, 2000 / 10:58 PM
C_TEXT:C284($0)  //the name of the object pointed to
C_POINTER:C301($1; $pointer)
$pointer:=$1

C_TEXT:C284($Name)
C_LONGINT:C283($Table; $Field)
RESOLVE POINTER:C394($pointer; $Name; $Table; $Field)
If ($Name="")
	If ($Table>0)
		$0:=Table name:C256($Table)
		If ($Field>0)
			$0:=$0+Field name:C257($Table; $Field)
		End if 
	Else 
		$0:="Nil"
	End if 
Else 
	If ($table=-1)
		$0:=$Name
	Else 
		$0:=$Name+"{"+String:C10($Table)+"}"
	End if 
End if 