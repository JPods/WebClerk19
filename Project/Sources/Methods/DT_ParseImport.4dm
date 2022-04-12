//%attributes = {"publishedWeb":true}
//Procedure: DT_ParseImport( Field(curTableNum;aMatchNum{$incFld});
//aImpFields{$incFld}
//TRACE
C_POINTER:C301($1)
C_TEXT:C284($2)
If (Field name:C257($1)="DT@")
	$p:=Position:C15("/"; $2)
	If ($p=0)
		$p:=Position:C15(" "; $2)
		If ($p=0)
			$p:=Position:C15("."; $2)
			If ($p=0)
				$p:=Position:C15("-"; $2)
			End if 
		End if 
	End if 
	If ($p>0)
		C_DATE:C307($theDate)
		C_TIME:C306($theTime)
		$p:=Position:C15(" "; $2)
		$theDate:=Date_GoFigure($2)
		If ($p>0)
			$theTime:=Time:C179(Substring:C12($2; $p+1))
		Else 
			$theTime:=?00:00:00?
		End if 
		$1->:=DateTime_Enter($theDate; $theTime)
	Else 
		$1->:=Num:C11($2)
	End if 
Else 
	If (($2="Y@") | ($2="t@"))  // Modified by: williamjames (110823)
		$1->:=1
	Else 
		$1->:=Num:C11($2)
	End if 
End if 