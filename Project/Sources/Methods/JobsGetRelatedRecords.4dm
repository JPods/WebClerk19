//%attributes = {"publishedWeb":true}
READ ONLY:C145([Customer:2])
READ ONLY:C145([Order:3])
READ ONLY:C145([Service:6])
READ ONLY:C145([Invoice:26])
READ ONLY:C145([PO:39])
READ ONLY:C145([Order:3])
READ ONLY:C145([Order:3])
READ ONLY:C145([Order:3])

If ([Customer:2]customerID:1#[Project:24]customerID:4)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Project:24]customerID:4)
End if 
QUERY:C277([Order:3]; [Order:3]projectNum:50=[Project:24]projectNum:1)
ORDER BY:C49([Order:3]; [Order:3]orderNum:2; <)

ARRAY LONGINT:C221($ataskIDs; 0)
DISTINCT VALUES:C339([Order:3]taskid:85; $ataskIDs)

QUERY:C277([Service:6]; [Service:6]projectNum:28=[Project:24]projectNum:1)
ORDER BY:C49([Service:6]; [Service:6]dtAction:35; <)

ARRAY LONGINT:C221($aTmptaskIDs; 0)
DISTINCT VALUES:C339([Service:6]taskid:51; $aTmptaskIDs)

ArrayAddDistinct(->$ataskIDs; ->$aTmptaskIDs)

QUERY:C277([Invoice:26]; [Invoice:26]projectNum:50=[Project:24]projectNum:1)
ORDER BY:C49([Invoice:26]; [Invoice:26]invoiceNum:2; <)

ARRAY LONGINT:C221($aTmptaskIDs; 0)
DISTINCT VALUES:C339([Invoice:26]taskid:78; $aTmptaskIDs)

ArrayAddDistinct(->$ataskIDs; ->$aTmptaskIDs)

QUERY:C277([PO:39]; [PO:39]projectNum:6=[Project:24]projectNum:1)
ORDER BY:C49([PO:39]; [PO:39]poNum:5; <)

ARRAY LONGINT:C221($aTmptaskIDs; 0)
DISTINCT VALUES:C339([PO:39]taskid:69; $aTmptaskIDs)

ArrayAddDistinct(->$ataskIDs; ->$aTmptaskIDs)

QUERY:C277([Proposal:42]; [Proposal:42]projectNum:22=[Project:24]projectNum:1)
ORDER BY:C49([Proposal:42]; [Proposal:42]proposalNum:5; <)

ARRAY LONGINT:C221($aTmptaskIDs; 0)
DISTINCT VALUES:C339([Proposal:42]taskid:70; $aTmptaskIDs)

ArrayAddDistinct(->$ataskIDs; ->$aTmptaskIDs)


QUERY:C277([Objective:145]; [Objective:145]projectNum:31=[Project:24]projectNum:1)

C_LONGINT:C283($found)
$found:=Find in array:C230($ataskIDs; 0)
If ($found>0)
	DELETE FROM ARRAY:C228($ataskIDs; $found; 1)
End if 

READ ONLY:C145([WorkOrder:66])
KeyModifierCurrent
If (OptKey=1)
	QUERY WITH ARRAY:C644([WorkOrder:66]taskid:22; $ataskIDs)
Else 
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]projectNum:80=[Project:24]projectNum:1)
End if 
QUERY:C277([InventoryStack:29]; [InventoryStack:29]projectNum:4=[Project:24]projectNum:1)
ORDER BY:C49([InventoryStack:29]; [InventoryStack:29]docid:5; <; [InventoryStack:29]dateEntered:3; <)