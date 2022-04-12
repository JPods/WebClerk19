//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Locked_CheckBoxes
	//Date: 07/01/02
	//Who: Bill
	//Description: Check for Locked or not enterable record
End if 

C_POINTER:C301($1; $ptCheckBox)
C_LONGINT:C283($numTable)
$numTable:=Table:C252($1)
$ptCheckBox:=Get pointer:C304("vbLocked_"+String:C10($numTable; "#00"))
$ptCheckBox->:=Num:C11(Locked:C147($1->) | (Record number:C243($1->)=-1))
If ($ptCheckBox->=1)
	OBJECT SET RGB COLORS:C628($ptCheckBox->; 0x00FF0000; 0x00FF)
Else 
	OBJECT SET RGB COLORS:C628($ptCheckBox->; 0x0000; 0x00FFFFFF)
End if 
//