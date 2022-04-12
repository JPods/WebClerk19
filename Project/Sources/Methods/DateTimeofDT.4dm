//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $3; $4)
//Procedure: DateTimeofDT
C_TEXT:C284($0)
//
C_TIME:C306($theTime)
C_DATE:C307($theDate)
C_TEXT:C284($space)
C_TEXT:C284($strDate; $strTime)
$0:=""
If (Count parameters:C259=0)
	$0:=String:C10(Current date:C33; 1)+" "+String:C10(Current time:C178; 1)
Else 
	$theDate:=!1990-01-01!+($1\86400)  //86400=24*60*60
	$strDate:=String:C10($theDate)
	$timeMod:=Abs:C99($1%86400)
	$strTime:=Time string:C180($timeMod)
	$theTime:=Time:C179($strTime)
	If (Count parameters:C259=1)
		$0:=String:C10($theDate; 1)+" "+String:C10($theTime; 1)
	Else 
		If (($2<7) & ($2>1))
			$0:=String:C10($theDate; $2)
		Else 
			$0:=String:C10($theDate; 1)*Num:C11($2#0)
		End if 
		If (Count parameters:C259>2)
			$space:=" "*Num:C11(($2>0) & ($3>0))
			If (($3<6) & ($3>1))
				$0:=$0+$space+String:C10($theTime; $3)
			Else 
				$0:=$0+$space+String:C10($theTime; 1)
			End if 
		End if 
	End if 
End if 