//%attributes = {"publishedWeb":true}
C_DATE:C307($0; $1; $theDate)
C_LONGINT:C283($2)
C_BOOLEAN:C305($doEOM)
Case of 
	: (Count parameters:C259=0)
		$theDate:=Current date:C33
		$doEOM:=True:C214
	: (Count parameters:C259=1)
		$theDate:=$1
		$doEOM:=True:C214
	Else 
		$theDate:=$1
		$doEOM:=($2=0)
End case 
If ($doEOM)
	$0:=Date:C102("1/1/"+String:C10(Year of:C25($theDate)))
Else 
	If (<>vbDateByDDMMYY)
		$0:=Date:C102("31/12/"+String:C10(Year of:C25($theDate)))
	Else 
		$0:=Date:C102("12/31/"+String:C10(Year of:C25($theDate)))
	End if 
End if 