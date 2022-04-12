//%attributes = {"publishedWeb":true}
//Procedure: Date_DateMMYY  $0 date, $1 MMYY string, $2 0/1 begin/eom
C_DATE:C307($0)
C_POINTER:C301($1)
C_LONGINT:C283($mon)
$year:=Num:C11(Substring:C12($1->; 3; 2))
If ($year<80)
	$year:=2000+$year
End if 
$mon:=Num:C11(Substring:C12(pCCDateStr; 1; 2))
If (($mon<1) | ($mon>12))
	BEEP:C151
	BEEP:C151
	$1->:="Err"
	$0:=!00-00-00!
Else 
	If (<>vbDateByDDMMYY)
		$0:=Date_ThisMon(Date:C102("15/"+Substring:C12($1->; 1; 2)+"/"+String:C10($year)); 1)
	Else 
		$0:=Date_ThisMon(Date:C102(Substring:C12($1->; 1; 2)+"/15/"+String:C10($year)); 1)
	End if 
End if 