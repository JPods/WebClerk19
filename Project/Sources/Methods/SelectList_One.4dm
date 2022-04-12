//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/11/21, 21:50:46
// ----------------------------------------------------
// Method: SelectList_One
// Description
// 
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1)
C_TEXT:C284($tableName; $vtSelectList; $vtChoices)
$tableName:="PopUp"
C_OBJECT:C1216($obSel; $obSelChoices; $obRecChoices; $obOutPut; $obRec)
C_COLLECTION:C1488($0; $cSelChoices; $cDistinct)
var $ptArray : Pointer
$vtSelectList:=$1
$obRec:=ds:C1482.PopUp.query("arrayName = :1"; "<>"+$vtSelectList).first()
If ($obRec=Null:C1517)
	Response:="Error: No Popup selectList named: "+$vtSelectList
Else 
	$ptArray:=Get pointer:C304($obRec.arrayName)
	If (Not:C34(Is nil pointer:C315($ptArray)))  // valid declared array
		C_TEXT:C284($vtName)
		C_POINTER:C301($ptLableName)
		$vtName:=Substring:C12($obRec.arrayName; 4)
		$ptLableName:=Get pointer:C304("<>v"+Substring:C12($obRec.arrayName; 4))
		If (Not:C34(Is nil pointer:C315($ptLableName)))
			$ptLableName->:=$obRec.listName
			$obSelChoices:=ds:C1482.PopupChoice.query("arrayName = :1"; $obRec.arrayName).orderBy("seq")
			$cSelChoices:=New collection:C1472
			For each ($obRecChoices; $obSelChoices)
				APPEND TO ARRAY:C911($ptArray->; $obRecChoices.choice)
			End for each 
			
			$cDistinct:=$cSelChoices.distinct()  // allow users to have empty or duplicates
			// ### bj ### 20210513_1019  
			// Should use seq, but dale does not have those setup.
			SORT ARRAY:C229($ptArray->)
			INSERT IN ARRAY:C227($ptArray->; 1; 1)
			$ptArray->{1}:=$obRec.listName
		End if 
	End if 
End if 
