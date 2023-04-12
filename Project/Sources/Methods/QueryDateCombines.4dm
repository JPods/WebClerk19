//%attributes = {"publishedWeb":true}
//Method: QueryDateCombine (->field;strDatebeg;strDateEnd;testCnt;DateType)
C_POINTER:C301($1)
C_TEXT:C284($2; $3)
C_DATE:C307($begDate; $endDate)
C_LONGINT:C283($4; $0)
C_TEXT:C284(qqq)
$0:=0
If (($2#"") & ($3#""))
	If ($2="")  //$begDateStr
		$begDate:=Current date:C33-2
	Else 
		$begDate:=Date_GoFigure($2)
	End if 
	If ($3="")  //$endDateStr
		$endDate:=Current date:C33+5
	Else 
		$endDate:=Date_GoFigure($3)
	End if 
	C_LONGINT:C283($dtBegin; $dtEnd)
	If ($4=0)
		$dtBegin:=DateTime_DTTo($begDate; ?00:00:00?)
		$dtEnd:=DateTime_DTTo($endDate; ?23:59:59?)
		qqq:=""
		//If ($3=0)
		//QUERY((Table(Field($1))->;$1->)<=$dtBegin;*)
		//QUERY((Table(Field($1))->;&$1->)>=$dtEnd;*)
		//$0:=1
		//Else 
		//QUERY((Table(Field($1))->;&$1->)<=$dtBegin;*)
		//QUERY((Table(Field($1))->;&$1->)>=$dtEnd;*)
		//End if 
	Else 
		qqq:=""
		//If ($3=0)
		//QUERY((Table(Field($1))->;$1->)<=$begDate;*)
		//QUERY((Table(Field($1))->;&$1->)>=$endDate;*)
		//$0:=1
		//Else 
		//QUERY((Table(Field($1))->;&$1->)<=$begDate;*)
		//QUERY((Table(Field($1))->;&$1->)>=$endDate;*)
		//End if 
	End if 
End if 