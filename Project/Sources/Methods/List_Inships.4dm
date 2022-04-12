//%attributes = {"publishedWeb":true}
//  List_Inships (eItemOrd;aOItemNum{aoLineAction})//Last 5 inship
//November 19, 1995  3:12 PM
MESSAGES OFF:C175
C_LONGINT:C283($1)
C_POINTER:C301($2)
QUERY:C277([InventoryStack:29]; [InventoryStack:29]itemNum:2=$2->)
If (Records in selection:C76([InventoryStack:29])=0)
	jAlertMessage(9201)
Else 
	ORDER BY:C49([InventoryStack:29]dateEntered:3; <)
	If (cmdKey=0)
		REDUCE SELECTION:C351([InventoryStack:29]; 5)
	End if 
	
	
	READ ONLY:C145([Item:4])
	If ([Item:4]itemNum:1#$2->)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$2->)
	End if 
	$k:=Records in selection:C76([InventoryStack:29])
	List_RaySize($k)
	FIRST RECORD:C50([InventoryStack:29])
	For ($i; 1; $k)
		aLsDocType{$i}:="is"
		aLsItemNum{$i}:=[InventoryStack:29]itemNum:2
		aLsItemDesc{$i}:=[Item:4]description:7
		aLsQtyOH{$i}:=[InventoryStack:29]qtyOnHand:9
		aLsQtySO{$i}:=[InventoryStack:29]unitCost:11
		aLsQtyPO{$i}:=0
		aLsPrice{$i}:=0
		aLsCost{$i}:=0
		aLsMargin{$i}:=0
		aLsDate{$i}:=[InventoryStack:29]dateEntered:3
		If (aLsDate{$i}=!00-00-00!)
			aLsDate{$i}:=!1901-01-01!
		End if 
		aLsLeadTime{$i}:=Current date:C33-aLsDate{$i}
		aLsText1{$i}:=[InventoryStack:29]vendorID:10
		aLsText2{$i}:=String:C10([InventoryStack:29]docid:5; "0000-0000")
		aLsSrRec{$i}:=-1  //Record number([Item])
		aLsDiscount{$i}:=0
		aLsDiscountPrice{$i}:=0
		NEXT RECORD:C51([InventoryStack:29])
	End for 
	UNLOAD RECORD:C212([InventoryStack:29])
	UNLOAD RECORD:C212([Item:4])
	// -- AL_SetHeaders($1; 1; 8; "T"; "Item Number"; "PO Description"; "Qty"; "Unit Cost"; ""; "Days"; "")
	// -- AL_SetHeaders($1; 9; 8; ""; ""; ""; ""; "Date"; "Vendor"; ""; "")
	// -- AL_SetWidths($1; 1; 8; 3; <>wAlAcctNum; 122; 48; 48; 3; 3; 3)
	// -- AL_SetWidths($1; 9; 8; 3; 3; 3; 3; <>wAlDate; 200; 200; 30)
	If (Size of array:C274(aLsSrRec)>1)
		// -- AL_SetSort($1; -11)
	End if 
	// -- AL_SetColOpts($1; 1; 0; 1; 0; 0)  //$columnCnt;0)
	//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
	//// -- AL_SetRowColor ($1;0;"Black";0;"white";0)
	//  --  CHOPPED  AL_UpdateArrays($1; -2)
End if 
READ WRITE:C146([Item:4])
MESSAGES ON:C181