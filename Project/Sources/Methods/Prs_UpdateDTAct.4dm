//%attributes = {"publishedWeb":true}
//Procedure: Prs_UpdateDTAct

C_LONGINT:C283($fia)
$fia:=Find in array:C230(<>aPrsNum; Current process:C322)
If ($fia>0)
	<>aPrsDTActiv{$fia}:=DateTime_DTTo
End if 