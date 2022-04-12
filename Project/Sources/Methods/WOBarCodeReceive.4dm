//%attributes = {}
//----------------------------------------------------
//User name(OS): williamjames
//Date and time: 11/20/12, 17:07:58
//----------------------------------------------------
//Method: WOBarCodeReceive
//Description
//
//
//Parameters
//----------------------------------------------------
// ### jwm ### 20130129_1052 added status "PendingTransfer"
// ### jwm ### 20140929_1512 added parameters 10 and 11

C_LONGINT:C283(bBarCode)
C_LONGINT:C283(bBarCodeSt)
Open window:C153(19; 165; 19; 165; 1)
DIALOG:C40([Default:15]; "diaBarCode")
CLOSE WINDOW:C154
//vsBarCdFld  is filled out in window
$errorMessage:=""
//vsBarCdFld
Case of 
	: (iLoText2="View")
		
	: ((iLoText2="Ship") | (iLoText2="Request"))
		
		C_LONGINT:C283($p)
		//ALERT("Parse qty and item num and create a WorkOrder")
		jMessageWindow("Parse qty and item num and create a WorkOrder")
		$p:=Position:C15(" "; vsBarCdFld)
		If ($p>1)
			$stringQty:=Substring:C12(vsBarCdFld; 1; $p-1)
			$stringItem:=Substring:C12(vsBarCdFld; $p+1)
		End if 
		//###jwm ###20121129_1520 Begin
		C_TEXT:C284(<>vBarCodeQtyItemDelim)
		<>vBarCodeQtyItemDelim:=" "
		$qtyBarCode:=0
		pPartNum:=vsBarCdFld
		If (<>vBarCodeQtyItemDelim#"")
			C_LONGINT:C283($p)
			$p:=Position:C15(<>vBarCodeQtyItemDelim; vsBarCdFld)
			If ($p>0)
				pPartNum:=Substring:C12(vsBarCdFld; $p+1)
				$qtyBarCode:=Num:C11(Substring:C12(vsBarCdFld; 1; $p-1))
			End if 
		End if 
		
		QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
		If (Records in selection:C76([Item:4])=1)
			//pPartNum:=vsBarCdFld
		Else 
			QUERY:C277([Item:4]; [Item:4]barCode:34=pPartNum)
			If (Records in selection:C76([Item:4])=1)
				pPartNum:=[Item:4]itemNum:1
			Else 
				QUERY:C277([Item:4]; [Item:4]mfrItemNum:39=pPartNum)
				If (Records in selection:C76([Item:4])=1)
					pPartNum:=[Item:4]itemNum:1
				Else 
					iLoText1:="ItemNum, Barcode, MfgItemNum not found"
				End if 
			End if 
		End if 
		
		//UNLOAD RECORD([Item])
		
		//###jwm ###20121129_1520 End
		
		//QUERY([Item];[Item]ItemNum=$stringItem)
		
		If (Records in selection:C76([Item:4])=1)
			If ($qtyBarCode=0)
				$stringQty:=String:C10(pQtyOrd)
			Else 
				$stringQty:=String:C10($qtyBarCode)
			End if 
			$qtyBarCode:=Num:C11($stringQty)
			//### jwm ### 20130130_1442 begin
			If ($qtyBarCode=0)
				ALERT:C41("Set Quantity")
				GOTO OBJECT:C206(pQtyOrd)
			Else 
				If (iLo80String1="")
					ALERT:C41("Set From:")
					GOTO OBJECT:C206(iLo80String1)
				Else 
					If (iLo80String2="")
						ALERT:C41("Set To:")
						GOTO OBJECT:C206(iLo80String2)
					Else 
						If (iLo80String3="")  //RequestedBy
							iLo80String3:=Current user:C182
						End if 
						If (iLo80String4="")  //ActionBy
							iLo80String4:=Current user:C182
						End if 
						
						If (vltaskID=0)
							vltaskID:=CounterNew(->[DialingInfo:81])
						End if 
						
						If (iLoDate1=!00-00-00!)
							iLoDate1:=Current date:C33
						End if 
						
						Case of 
							: (iLoText2="Ship")
								$status:="PendingTransfer"
							: (iLoText2="Request")
								$status:="RequestedTransfer"
						End case 
						
						CREATE SET:C116([WorkOrder:66]; "Current")
						//### jwm ### 20130130_1442 end
						
						//### jwm ### 20130129_1052 added status "PendingTransfer"
						// ### jwm ### 20140929_1512 added parameters 10 and 11
						WO_TransferCreate([Item:4]itemNum:1; $qtyBarCode; vltaskID; vloDate1; iLo80String1; iLo80String2; iLo80String3; $status; iLo80String4; iLo80String5; vlGroupID)
						//WO_TransferCreate ([Item]ItemNum;pQtyOrd;vltaskID;iLoDate1;iLo80String1;iLo80String2;iLo80String3;"PendingTransfer";iLo80String4)
						//WO_TransferCreate ([Item]ItemNum;$qtyBarCode;vltaskID;vloDate1;siteFrom;siteTo;ActionBy;iLo80String4)
						ADD TO SET:C119([WorkOrder:66]; "Current")
						
						USE SET:C118("Current")
						CLEAR SET:C117("Current")
						
					End if   //No To:
				End if   //No From:
			End if   //No Qty 
		Else 
			ALERT:C41("Error: No Item "+pPartNum)
		End if   //Unique Item Record
		WOTransfers_Sort(iLoText2)
		//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)
	: (iLoText2="Receive")
		C_LONGINT:C283($workOrderNum)
		//CONFIRM("Query and receive "+String([WorkOrder]WONum))
		$workOrderNum:=Num:C11(vsBarCdFld)
		READ WRITE:C146([WorkOrder:66])  //### jwm ### 20130207_1721
		CREATE SET:C116([WorkOrder:66]; "Current")
		WO_TransferReceive($workOrderNum; iLo80String2; Current user:C182; "")  //[WorkOrder]Status:="CompletedTransfer"
		ADD TO SET:C119([WorkOrder:66]; "Current")
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		ORDER BY:C49([WorkOrder:66]; [WorkOrder:66]woNum:29; <)  //### jwm ### 20130207_1727
		//  CHOPPED  AL_UpdateFields(eWorkOrders; 2)
		
End case 
