//%attributes = {"publishedWeb":true}
QUERY:C277([POLine:40]; [POLine:40]itemNum:2=pPartNum)
ORDER BY:C49([POLine:40]; [POLine:40]dateReceived:17; <)
List_RaySize(0)
If (CmdKey=0)
	REDUCE SELECTION:C351([POLine:40]; 5)
End if 
SELECTION TO ARRAY:C260([POLine:40]itemNum:2; aLsItemNum; [POLine:40]description:6; aLsItemDesc; [POLine:40]qtyOrdered:3; aLsQtyOH; [POLine:40]unitCost:7; aLsQtySO; [POLine:40]discount:8; aLsQtyPO; [POLine:40]dateExpected:15; aLsDate)
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aLsItemNum)
List_RaySize($k)
For ($i; 1; $k)
	aLsSrRec{$i}:=-1  //Record number([Item])        
	aLsDocType{$i}:="pl"
	aLsLeadTime{$i}:=Current date:C33-aLsDate{$i}
End for 
// -- AL_SetHeaders(eItemPo; 1; 13; "T"; "Item Number"; "Past PO Ln Description"; "Qty"; "Unit Price"; "Discnt"; "Days"; ""; ""; ""; "Date"; ""; "")
// -- AL_SetWidths(eItemPo; 1; 13; 3; 54; 128; 29; 39; 27; 3; 3; 3; 3; 61; 120; 120)
//  --  CHOPPED  AL_UpdateArrays(eItemPo; -2)