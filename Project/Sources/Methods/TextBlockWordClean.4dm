//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-10T00:00:00, 14:15:24
// ----------------------------------------------------
// Method: TextBlockWordClean
// Description
// Modified: 01/10/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptField; $ptTable)
C_LONGINT:C283($w; $i; $k)
$ptField:=$1
$ptTable:=Table:C252(Table:C252($1))
$ptField->:=Replace string:C233($ptField->; ", "; ",")
$ptField->:=Replace string:C233($ptField->; "; "; ",")
//[Item]KeywordsText:=Replace string([Item]KeywordsText;" ";",")
$ptField->:=Replace string:C233($ptField->; ";"; ",")
//[Item]KeywordsText:=Replace string([Item]KeywordsText;";";",")
TextToArray($ptField->; ->aText31; ",")
ARRAY TEXT:C222($aUniqueWords; 0)
$k:=Size of array:C274(aText31)
For ($i; 1; $k)
	If (aText31{$i}#"")
		$w:=Find in array:C230($aUniqueWords; aText31{$i})
		If ($w<0)
			APPEND TO ARRAY:C911($aUniqueWords; aText31{$i})
		End if 
	End if 
End for 
SORT ARRAY:C229($aUniqueWords; >)  // ### jwm ### 20170512_1454 sort keywords before writing back
$k:=Size of array:C274($aUniqueWords)
$ptField->:=""
C_TEXT:C284($delimiterBuild)
// ### bj ### 20200429_2011
// puts a , first
For ($i; 1; $k)
	If ($aUniqueWords{$i}#"")
		If ($ptField->="")
			$ptField->:=$aUniqueWords{$i}  // clear the field and enter value without delimiter
		Else 
			$ptField->:=$ptField->+","+$aUniqueWords{$i}
		End if 
	End if 
End for 
SAVE RECORD:C53($ptTable->)