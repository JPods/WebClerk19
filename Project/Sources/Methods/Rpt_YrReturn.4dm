//%attributes = {"publishedWeb":true}
//Procedure: Rpt_YrReturn
//Year; File; SrchField; DateField; KeyFile; KeyID; RtnField1; RtnField2
//; RtnField3; RtnField4
//SEARCH([Invoice];[Invoice]customerID=[Customer]customerID;*)
//SEARCH([Invoice];&[Invoice]DateShipped>=$vDateBeg;*)
//SEARCH([Invoice];&[Invoice]DateShipped<=$vDateEnd)

C_LONGINT:C283($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $i)
ARRAY REAL:C219(aReal1; 26)
ARRAY REAL:C219(aReal2; 26)
ARRAY REAL:C219(aReal3; 26)
ARRAY REAL:C219(aReal4; 26)
ARRAY REAL:C219(aReal5; 26)
C_TEXT:C284($yearStr)
C_DATE:C307($vDateBeg; $vDateEnd)
If (Count parameters:C259>6)
	If ($1=0)
		$yearStr:=String:C10(Year of:C25(Current date:C33))
	Else 
		$yearStr:=String:C10($1)
	End if 
	aReal1{25}:=0
	aReal2{25}:=0
	aReal3{25}:=0
	aReal4{25}:=0
	aReal1{26}:=0
	aReal2{26}:=0
	aReal3{26}:=0
	aReal4{26}:=0
	For ($i; 1; 12)
		$vDateBeg:=Date:C102(String:C10($i)+"/1/"+$yearStr)
		$vDateEnd:=Date_ThisMon($vDateBeg; 1)
		QUERY:C277(Table:C252($2)->; Field:C253($2; $3)->=Field:C253($5; $6)->; *)
		QUERY:C277(Table:C252($2)->;  & Field:C253($2; $4)->>=$vDateBeg; *)
		QUERY:C277(Table:C252($2)->;  & Field:C253($2; $4)-><=$vDateEnd)
		aReal1{$i}:=Rpt_SumReturn($2; $7)
		aReal1{25}:=aReal1{25}+aReal1{$i}
		If (Count parameters:C259>7)
			aReal2{$i}:=Rpt_SumReturn($2; $8)
			aReal2{25}:=aReal2{25}+aReal2{$i}
			If (Count parameters:C259>8)
				aReal3{$i}:=Rpt_SumReturn($2; $9)
				aReal3{25}:=aReal3{25}+aReal3{$i}
				If (Count parameters:C259>9)
					aReal4{$i}:=Rpt_SumReturn($2; $10)
					aReal4{25}:=aReal4{25}+aReal4{$i}
				End if 
			End if 
		End if 
	End for 
	$yearStr:=String:C10(Num:C11($yearStr)-1)
	For ($i; 1; 12)
		$vDateBeg:=Date:C102(String:C10($i)+"/1/"+$yearStr)
		$vDateEnd:=Date_ThisMon($vDateBeg; 1)
		QUERY:C277(Table:C252($2)->; Field:C253($2; $3)->=Field:C253($5; $6)->; *)
		QUERY:C277(Table:C252($2)->;  & Field:C253($2; $4)->>=$vDateBeg; *)
		QUERY:C277(Table:C252($2)->;  & Field:C253($2; $4)-><=$vDateEnd)
		aReal1{$i+12}:=Rpt_SumReturn($2; $7)
		aReal1{26}:=aReal1{26}+aReal1{$i+12}
		If (Count parameters:C259>7)
			aReal2{$i+12}:=Rpt_SumReturn($2; $8)
			aReal2{26}:=aReal2{26}+aReal2{$i+12}
			If (Count parameters:C259>8)
				aReal3{$i+12}:=Rpt_SumReturn($2; $9)
				aReal3{26}:=aReal3{26}+aReal3{$i+12}
				If (Count parameters:C259>9)
					aReal4{$i+12}:=Rpt_SumReturn($2; $10)
					aReal4{26}:=aReal4{26}+aReal4{$i+12}
				End if 
			End if 
		End if 
	End for 
End if 