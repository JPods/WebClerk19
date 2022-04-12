//%attributes = {"publishedWeb":true}
//List_CustBuy (eItemOrd)   //last 5 invoices 
//November 19, 1995  3:11 PM
C_LONGINT:C283($1)
C_BOOLEAN:C305($doThis)
$doThis:=False:C215
MESSAGES OFF:C175
KeyModifierCurrent
If (ptCurTable=(->[PO:39]))
	C_LONGINT:C283($i; $k; $subInc; $subCnt; $w)
	QUERY:C277([POLine:40]; [POLine:40]vendorID:24=[Vendor:38]vendorID:1)
	List_RaySize(0)
	$k:=Records in selection:C76([POLine:40])
	
	SELECTION TO ARRAY:C260([POLine:40]itemNum:2; aLsItemNum; [POLine:40]description:6; aLsItemDesc; [POLine:40]qtyOrdered:3; aLsQtyOH; [POLine:40]unitCost:7; aLsQtySO; [POLine:40]discount:8; aLsQtyPO; [POLine:40]refCustomer:22; aLsText1; [POLine:40]refVendor:23; aLsText2; [POLine:40]dateExpected:15; aLsDate)
	
	If (Records in selection:C76([POLine:40])>0)
		If ($1#0)
			// -- AL_SetHeaders($1; 1; 8; "T"; "Item Number"; "PO Description"; "Qty"; "Unit Cost"; "Discnt"; "Days"; "")
			// -- AL_SetHeaders($1; 9; 8; ""; ""; ""; ""; "Date"; "Customer"; "Vendor"; "")
			//  --  CHOPPED  AL_UpdateArrays($1; -2)
		End if 
		
		$doThis:=True:C214
		$k:=Size of array:C274(aLsItemNum)
		// List_RaySize ($k)
		ARRAY TEXT:C222(aLsDocType; $k)
		ARRAY LONGINT:C221(aLsLeadTime; $k)  //Lead time
		ARRAY REAL:C219(aLsPrice; $k)  //Price
		ARRAY REAL:C219(aLsCost; $k)  //cost
		ARRAY REAL:C219(aLsMargin; $k)  //margin    
		ARRAY LONGINT:C221(aLsSrRec; $k)  //Item record number
		ARRAY REAL:C219(aLsDiscount; $k)  //Discount
		ARRAY REAL:C219(aLsDiscountPrice; $k)  //Discounted Price
		For ($i; 1; $k)
			aLsSrRec{$i}:=-1  //Record number([Item])
			aLsMargin{$i}:=0
			aLsPrice{$i}:=0
			aLsDocType{$i}:="il"
			aLsCost{$i}:=0
			aLsLeadTime{$i}:=Current date:C33-aLsDate{$i}
			aLsDiscount{$i}:=0
			aLsDiscountPrice{$i}:=0
		End for 
	End if 
	QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
	
Else 
	//  List_RaySize (0)  to call this is an error; bizzare array cannot be dimensione
	QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]customerID:2=[Customer:2]customerID:1)
	If (Records in selection:C76([InvoiceLine:54])=0)
		BEEP:C151
	End if 
	$doThis:=True:C214
	If (($1#0) & ($doThis))
		// -- AL_SetHeaders($1; 1; 8; "T"; "Item Number"; "Description"; "Qty"; "Unit Price"; "Discnt"; "Days"; "")
		// -- AL_SetHeaders($1; 9; 8; ""; ""; ""; ""; "Date"; "Inv"; "Customer"; "Rec")
	End if 
	
	List_FillinvLns
	
End if 
If (($1#0) & ($doThis))
	//// -- AL_SetRowColor ($1;0;"Black";0;"white";0)
	// -- AL_SetWidths($1; 1; 8; 10; 50; 54; 48; 48; 20; <>wAlDate; 3)
	// -- AL_SetWidths($1; 9; 8; 3; 3; 3; 3; <>wAlDate; 58; 200; 30)
	//  --  CHOPPED  AL_UpdateArrays($1; -2)
End if 
MESSAGES ON:C181