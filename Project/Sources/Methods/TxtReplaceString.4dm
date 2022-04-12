//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: TxtReplaceString 
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 


C_POINTER:C301($1; $ptField; $ptTable)
C_TEXT:C284($2; $3; $findValue; $replaceValue)
If (Count parameters:C259=3)
	$ptTable:=Table:C252(Table:C252($1))
	$ptField:=$1
	$findValue:=$2
	$replaceValue:=$3
Else 
	$ptTable:=(->[Item:4])
	$findValue:=Request:C163("Find Value?")
	$replaceValue:=Request:C163("Replace Value?")
End if 

If ((Type:C295($ptField->)=Is alpha field:K8:1) | (Type:C295($ptField->)=Is text:K8:3))  //|(Type($ptField->)=Is String Var))
	If (($findValue#"") & ($replaceValue#""))
		C_LONGINT:C283($i; $k)
		$k:=Records in selection:C76($ptTable->)
		FIRST RECORD:C50($ptTable->)
		For ($i; 1; $k)
			//MESSAGE(String($i))
			$ptField->:=Replace string:C233($ptField->; $findValue; $replaceValue)
			SAVE RECORD:C53($ptTable->)
			NEXT RECORD:C51($ptTable->)
		End for 
	End if 
End if 