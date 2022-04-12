//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method:Method: PKDunnage
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
ARRAY TEXT:C222(aDunItemNum; 0)
ARRAY TEXT:C222($aDunItemDescription; 0)
ARRAY LONGINT:C221(aDunItemRec; 0)
QUERY:C277([Item:4]; [Item:4]typeid:26="dunnage")
If (Records in selection:C76([Item:4])>0)
	SELECTION TO ARRAY:C260([Item:4]itemNum:1; aDunItemNum; [Item:4]description:7; $aDunItemDescription; [Item:4]; aDunItemRec)
	SORT ARRAY:C229(aDunItemNum; $aDunItemDescription; aDunItemRec)
	UNLOAD RECORD:C212([Item:4])
	$k:=Size of array:C274(aDunItemRec)
	ARRAY TEXT:C222(aDunList; $k)
	For ($i; 1; $k)
		aDunList{$i}:=aDunItemNum{$i}+": "+$aDunItemDescription{$i}
	End for 
Else 
	ARRAY TEXT:C222(aDunList; 0)
End if 
INSERT IN ARRAY:C227(aDunItemRec; 1; 1)
INSERT IN ARRAY:C227(aDunList; 1; 1)
INSERT IN ARRAY:C227(aDunItemNum; 1; 1)
aDunList{1}:="Dunnage@"
aDunItemRec{1}:=-1
aDunItemNum{1}:="zzzNotAnItem"