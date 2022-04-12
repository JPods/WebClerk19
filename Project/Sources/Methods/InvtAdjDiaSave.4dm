//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 03/19/13, 13:28:35
// ----------------------------------------------------
// Method: InvtAdjDiaSave
// Description
// File: InvtAdjDiaSave.txt
// Parameters
// ----------------------------------------------------
//### jwm ### 20130319_1332 changed <>tcsiteID to vsiteID


C_LONGINT:C283($i; $k; $m)
C_TEXT:C284($curUser; $curUser)
$curUser:=Substring:C12(Current user:C182; 1; 10)
$k:=Size of array:C274(aLsItemNum)
$m:=Find in array:C230(aLsItemNum; v1)

// only change inventory for the selected Item
If ($m>0)
	Invt_dRecCreate("AJ"; 0; -2; $curUser; 0; aLsReason{$m}; 1; 0; aLsItemNum{$m}; aLsQtySO{$m}; aLsQtySO{$m}; aLsCost{$m}; ""; vsiteID; 0)  // ### jwm ### 20160119_1037
	aLsQtyOH{$m}:=aLsQtyOH{$m}+aLSQtySO{$m}  //NO CHANGE  +- match
End if 

// clear all open amounts
If (False:C215)
	For ($i; 1; $k)
		If (aLsQtySO{$i}#0)
			//reason; itemNum; dQty OH; dQty On SO; Cost
			//Invt_dRecCreate ("AJ";0;-2;$curUser;0;aLsReason{$i};1;0;aLsItemNum{$i};aLsQtySO{$i};aLsQtySO{$i};aLsCost{$i};"";vsiteID;0)  //### jwm ### 20130319_1332
			//aLsQtyOH{$i}:=aLsQtyOH{$i}+aLSQtySO{$i}  //NO CHANGE  +- match
			//aLSQtySO{$i}:=0
		End if 
	End for 
End if 

CREATE SET:C116([Item:4]; "Tally")

INVT_dInvtApply

TallyInventory
USE SET:C118("Tally")
CLEAR SET:C117("Tally")
booMod:=False:C215

