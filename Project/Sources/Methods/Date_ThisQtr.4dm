//%attributes = {"publishedWeb":true}
//Procedure: Procedure: Date_ThisQtr
C_DATE:C307($theDate; $0; $1)
C_LONGINT:C283($month; $2; $monBeg; $monEnd)
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
$month:=Month of:C24($theDate)
Case of 
	: ($month<4)
		$monBeg:=1
		$monEnd:=3
	: ($month>9)
		$monBeg:=10
		$monEnd:=12
	: ($month>6)
		$monBeg:=7
		$monEnd:=9
	Else 
		$monBeg:=4
		$monEnd:=6
End case 
If ($doEOM)
	If (<>vbDateByDDMMYY)
		$0:=Date:C102("1/"+String:C10($monBeg)+"/"+String:C10(Year of:C25($theDate)))
	Else 
		$0:=Date:C102(String:C10($monBeg)+"/1/"+String:C10(Year of:C25($theDate)))
	End if 
Else 
	If (<>vbDateByDDMMYY)
		$theDate:=Date:C102("1/"+String:C10($monEnd)+"/"+String:C10(Year of:C25($theDate)))
	Else 
		$theDate:=Date:C102(String:C10($monEnd)+"/1/"+String:C10(Year of:C25($theDate)))
	End if 
	$0:=Date_ThisMon($theDate; 1)
End if 