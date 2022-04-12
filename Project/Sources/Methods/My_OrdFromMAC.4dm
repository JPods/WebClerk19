//%attributes = {"publishedWeb":true}
//Orders File
C_TEXT:C284($ActCode; $PartNum; $QtyOrdered; $dtOrd; $Status; $terminator)
C_TEXT:C284($UnitPrice; $invNum; $QtyBackOrd; $ready; $po; $dtRequrd; $source; $dtCancel; $vendOrd)
C_TEXT:C284($quote; $space)
//

//C_TEXT($arDocPath)
//vDiaCom:="  Open AR file for importing from MAC."
//jGetFileDiaMess (vDiaCom)//Add title and open window
//myDoc:=Open document("")
//CLOSE WINDOW//close window
//$arDocPath:=document

//CLOSE DOCUMENT(myDoc)
C_LONGINT:C283($myOK)
//
TRACE:C157
$quote:=Char:C90(34)
REDUCE SELECTION:C351([Order:3]; 0)
$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "After Cust/Contact Open OrdLns"; ""; Storage:C1525.folder.jitExportsF)  //;jitQRsF
If ($myOK=1)
	$myAcct:="zzzxxxjys"  //some junk
	$myPO:="zzzxxxjys"  //some junk
	While (OK=1)
		RECEIVE PACKET:C104(myDoc; $ActCode; "\t")
		RECEIVE PACKET:C104(myDoc; $PartNum; "\t")  //$quote, changed Tuesday, December 29, 1998
		RECEIVE PACKET:C104(myDoc; $QtyOrdered; "\t")
		RECEIVE PACKET:C104(myDoc; $dtOrd; "\t")
		RECEIVE PACKET:C104(myDoc; $Status; "\t")
		//
		RECEIVE PACKET:C104(myDoc; $UnitPrice; "\t")
		RECEIVE PACKET:C104(myDoc; $invNum; "\t")
		RECEIVE PACKET:C104(myDoc; $QtyBackOrd; "\t")
		//
		RECEIVE PACKET:C104(myDoc; $ready; "\t")
		RECEIVE PACKET:C104(myDoc; $po; "\t")
		RECEIVE PACKET:C104(myDoc; $dtRequrd; "\t")
		RECEIVE PACKET:C104(myDoc; $source; "\t")
		RECEIVE PACKET:C104(myDoc; $dtCancel; "\t")
		RECEIVE PACKET:C104(myDoc; $vendOrd; "\t")
		RECEIVE PACKET:C104(myDoc; $terminator; "\r")
		
		If (OK=1)
			If (Character code:C91($ActCode)=10)
				$ActCode:=Substring:C12($ActCode; 2)
			End if 
			If (($myAcct#$ActCode) | ($myPO#$po))
				[Order:3]customerID:1:=$myAcct
				[Order:3]customerPO:3:=$myPO
				$myAcct:=$ActCode
				$myPO:=$po
				[Order:3]amount:24:=Sum:C1([OrderLine:49]extendedPrice:11)
				[Order:3]total:27:=[Order:3]amount:24
				[Order:3]amountBackLog:54:=Sum:C1([OrderLine:49]backOrdAmount:26)
				If ([Order:3]amountBackLog:54=0)
					[Order:3]status:59:="Completed"
					[Order:3]dateInvoiceComp:6:=Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33)))
					[Order:3]complete:83:=2
				End if 
				SAVE RECORD:C53([Order:3])
				CREATE RECORD:C68([Order:3])
				//
				QUERY:C277([Contact:13]; [Contact:13]profile1:18=$ActCode)  //$actCode is from MAC's ship to
				If (Records in selection:C76([Contact:13])=0)  //ship to is the bill to
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=$ActCode)  //go find customer record
				Else 
					FIRST RECORD:C50([Contact:13])  //go to contact record
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)  //get customer
				End if 
				If (Records in selection:C76([Customer:2])=1)
					LoadCustOrder
				Else 
					[Customer:2]customerID:1:=$ActCode
					[Customer:2]company:2:="missing"
				End if 
				viOrdLnCnt:=0
				[Order:3]orderNum:2:=CounterNew(->[Order:3])
				[Order:3]status:59:=$Status
				[Order:3]profile1:61:=$vendOrd
				[Order:3]profile2:62:=$invNum
				[Order:3]profile3:63:=$Status
				[Order:3]dateOrdered:4:=Date_CvrtYyMmDd($dtOrd)
				If ($dtCancel#"999999")
					[Order:3]dateNeeded:5:=Date_CvrtYyMmDd($dtRequrd)
				End if 
				If ($dtCancel#"999999")
					[Order:3]dateCancel:53:=Date_CvrtYyMmDd($dtCancel)
				End if 
				[Order:3]repID:8:=$Source
			End if 
			CREATE RECORD:C68([OrderLine:49])
			
			[OrderLine:49]itemNum:4:=$PartNum
			[OrderLine:49]altItem:31:=$ready+" -- "+$invNum
			//SEARCH([Item];[Item]ItemNum=$PartNum)
			//[Orderline]Description:=[Item]Description
			[OrderLine:49]qty:6:=Num:C11($QtyOrdered)
			viOrdLnCnt:=viOrdLnCnt+1
			[OrderLine:49]lineNum:3:=viOrdLnCnt
			[OrderLine:49]seq:30:=viOrdLnCnt
			[OrderLine:49]unitPrice:9:=Num:C11($UnitPrice)
			If (($ready="F") & ($Status#"deleted"))
				[OrderLine:49]qtyBackLogged:8:=[OrderLine:49]qty:6
				[OrderLine:49]qtyShipped:7:=0
			Else 
				[OrderLine:49]qtyBackLogged:8:=0
				[OrderLine:49]qtyShipped:7:=[OrderLine:49]qty:6
			End if 
			[OrderLine:49]extendedPrice:11:=Round:C94([OrderLine:49]qty:6*[OrderLine:49]unitPrice:9; 2)
			[OrderLine:49]backOrdAmount:26:=Round:C94([OrderLine:49]qtyBackLogged:8*[OrderLine:49]unitPrice:9; 2)
			[OrderLine:49]typeSale:28:="W"
			SAVE RECORD:C53([OrderLine:49])
			
			
		End if 
	End while 
	[Order:3]amount:24:=Sum:C1([OrderLine:49]extendedPrice:11)
	[Order:3]total:27:=[Order:3]amount:24
	[Order:3]amountBackLog:54:=Sum:C1([OrderLine:49]backOrdAmount:26)
	If ([Order:3]amountBackLog:54=0)
		[Order:3]status:59:="Completed"
		[Order:3]dateInvoiceComp:6:=!1995-01-01!
		[Order:3]complete:83:=2
	End if 
	SAVE RECORD:C53([Order:3])
	CLOSE DOCUMENT:C267(myDoc)
End if 
