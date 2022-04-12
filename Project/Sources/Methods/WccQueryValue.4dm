//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WccQueryValue
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($1; $2; $3; $4)
C_POINTER:C301($5)
$deleteSelection:=False:C215
$tableNum:=STR_GetTableNumber($1)
$fieldNum:=STR_GetFieldNumber($1; $2)
C_LONGINT:C283($theType; $tableNum; $fieldNum; $recCount)
If (($tableNum>0) & ($fieldNum>0))
	$theType:=Type:C295(Field:C253($tableNum; $fieldNum)->)  //Type(Field($tableNum;$fieldNum)->)
	Case of 
		: (($theType=0) | ($theType=2) | ($theType=24))
			QUERY:C277(Table:C252($tableNum)->; Field:C253($tableNum; $fieldNum)->=$3)
		: ($theType=4)
			QUERY:C277(Table:C252($tableNum)->; Field:C253($tableNum; $fieldNum)->=Date:C102($3))
		: (($theType=1) | ($theType=8) | ($theType=9))
			QUERY:C277(Table:C252($tableNum)->; Field:C253($tableNum; $fieldNum)->=Num:C11($3))
	End case 
End if 
If (Count parameters:C259>3)
	$deleteSelection:=True:C214
	$fieldNum:=STR_GetFieldNumber($1; $4)
	If ($fieldNum>0)
		If (Field:C253($tableNum; $fieldNum)->=$5->)
			$deleteSelection:=False:C215
		End if 
	End if 
	TRACE:C157
	If ($deleteSelection)
		REDUCE SELECTION:C351(Table:C252($tableNum)->; 0)
	Else 
		theText:="RelatedTables=RelateAll"
		WccRelateRecords(Table:C252($tableNum); ->theText)
		theText:=""
	End if 
End if 