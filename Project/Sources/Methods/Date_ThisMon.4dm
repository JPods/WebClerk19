//%attributes = {"publishedWeb":true}


//Procedure: Date_EndThisMon
C_DATE:C307($0; $1; $theDate)
C_LONGINT:C283($day; $2)
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
$day:=Day of:C23($theDate)
If ($doEOM)
	If (<>vbDateByDDMMYY)
		$0:=Date:C102("1/"+String:C10(Month of:C24($theDate))+"/"+String:C10(Year of:C25($theDate)))
	Else 
		$0:=Date:C102(String:C10(Month of:C24($theDate))+"/1/"+String:C10(Year of:C25($theDate)))
	End if 
Else 
	$theDate:=$1+(Num:C11($day>=25)*7)+(Num:C11($day<25)*32)  //vdDateBeg+32
	If (<>vbDateByDDMMYY)
		$0:=Date:C102("1/"+String:C10(Month of:C24($theDate))+"/"+String:C10(Year of:C25($theDate)))-1
	Else 
		$0:=Date:C102(String:C10(Month of:C24($theDate))+"/1/"+String:C10(Year of:C25($theDate)))-1
	End if 
End if 