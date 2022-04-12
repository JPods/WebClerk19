//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/24/13, 23:46:21
// ----------------------------------------------------
// Method: SortOutputLayoutHeader
// Description
// 
//
// Parameters
// ----------------------------------------------------

KeyModifierCurrent
C_POINTER:C301($ptField; $1; $ptField2; $2; $ptField3; $3)
Case of 
	: (Count parameters:C259=1)
		$ptField:=$1
		If (OptKey=0)
			ORDER BY:C49(Table:C252(Table:C252($ptField))->; $ptField->)
		Else 
			ORDER BY:C49(Table:C252(Table:C252($ptField))->; $ptField->; <)
		End if 
	: (Count parameters:C259=2)
		$ptField:=$1
		$ptField2:=$2
		If (OptKey=0)
			ORDER BY:C49(Table:C252(Table:C252($ptField))->; $ptField->; $ptField2->)
		Else 
			ORDER BY:C49(Table:C252(Table:C252($ptField))->; $ptField->; <; $ptField2->; <)
		End if 
	: (Count parameters:C259=3)
		$ptField:=$1
		$ptField2:=$2
		$ptField3:=$3
		If (OptKey=0)
			ORDER BY:C49(Table:C252(Table:C252($ptField))->; $ptField->; $ptField2->; $ptField3->)
		Else 
			ORDER BY:C49(Table:C252(Table:C252($ptField))->; $ptField->; <; $ptField2->; <; $ptField3->; <)
		End if 
End case 