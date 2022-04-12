//%attributes = {"publishedWeb":true}
//Procedure: Srl_IssueDialog
C_LONGINT:C283($0; $1)  //count, line num
C_REAL:C285($5)
C_LONGINT:C283($curSrRec; $0; $cntSrl)
C_POINTER:C301($2; $3; $4)
C_TEXT:C284($seperator)
C_PICTURE:C286($origSrl)
//viRecordsInSelection:=0  //set to the number of order lines to convert to invoice lines
//viRecordsInTable:=$3
If ((aiQtyShip{$1}<0) | (pQtyShip<0))
	$doPos:=False:C215
Else 
	$doPos:=True:C214
End if 
If ($doPos)  //increasing + shipping (aiQtyShip{$1}>=0)&(aiQtyShip{$1}
	//SEARCH([ItemSerial];|[ItemSerial]SalesLnRefID=0;*)    
	QUERY:C277([ItemSerial:47]; [ItemSerial:47]status:8="Av"; *)
	QUERY:C277([ItemSerial:47];  & [ItemSerial:47]itemNum:1=aiItemNum{$1}; *)
	QUERY:C277([ItemSerial:47];  | [ItemSerial:47]salesLnRefid:11=aiSerialRc{$1})
Else 
	QUERY:C277([ItemSerial:47]; [ItemSerial:47]itemNum:1=aiItemNum{$1}; *)
	QUERY:C277([ItemSerial:47];  & [ItemSerial:47]customerID:9=[Invoice:26]customerID:3)
End if 
Srl_FillRay(Records in selection:C76([ItemSerial:47]))
vSnItmAlpha:=$2->
vsnItmAlpha:=$2->
myOk:=0  //flow control
jCenterWindow(560; 440; 1)
DIALOG:C40([ItemSerial:47]; "diaSerialSet")
CLOSE WINDOW:C154
vDiaCom:=""
TRACE:C157
If (myOK#2)
	$0:=aiQtyShip{$1}
Else 
	doSearch:=888
	$4->:=""
	$seperator:=""
	READ WRITE:C146([ItemSerial:47])
	$cntSrl:=0
	$k:=Size of array:C274(aSrAvail)
	For ($i; 1; $k)
		$seperator:="; "*Num:C11($4->#"")
		$w:=Find in array:C230(aSrRecSel; $i)
		Case of 
			: (($w>-1) & (aSrSaleID{$i}=$3->))  //currently on this invoice and selected
				$4->:=$4->+$seperator+aSrNum{$i}
				If ($doPos)
					$cntSrl:=$cntSrl+1
				Else 
					$cntSrl:=$cntSrl-1
				End if 
			: (($w=-1) & (aSrSaleID{$i}=$3->))  //was on invoice but not selected
				GOTO RECORD:C242([ItemSerial:47]; aSrRecNum{$i})
				If (Locked:C147([ItemSerial:47]))
					$bProcessed:=False:C215
				Else 
					$bProcessed:=True:C214
				End if 
				If ($doPos)  //a return          
					[ItemSerial:47]salesLnRefid:11:=0  //mark to this line    
					[ItemSerial:47]status:8:="Av"
					[ItemSerial:47]dateShipped:13:=!00-00-00!
					[ItemSerial:47]dateWarrantyEnd:21:=!00-00-00!
					[ItemSerial:47]invoiceNum:10:=0
					[ItemSerial:47]customerID:9:=""
					Srl_Transaction(Table:C252(ptCurTable); $3->; $bProcessed; "Removed")
				Else 
					[ItemSerial:47]salesLnRefid:11:=0  //mark to this line    
					[ItemSerial:47]status:8:="VR"
					Srl_Transaction(Table:C252(ptCurTable); $3->; $bProcessed; "Removed")
				End if 
				SAVE RECORD:C53([ItemSerial:47])
				
			: ($w>-1)  //selected for return or new listed SrlNum
				If (aSrRecNum{$i}=-3)
					CREATE RECORD:C68([ItemSerial:47])
					
					$bProcessed:=True:C214
					[ItemSerial:47]itemNum:1:=$2->
					[ItemSerial:47]serialNum:4:=aSrNum{$i}
					If ([Item:4]itemNum:1#$2->)
						QUERY:C277([Item:4]; [Item:4]itemNum:1=$2->)
					End if 
					[ItemSerial:47]description:2:=[Item:4]description:7
					[ItemSerial:47]warrantyDays:20:=[Item:4]warrantyDays:46
					[ItemSerial:47]dateReceived:12:=Current date:C33
				Else 
					GOTO RECORD:C242([ItemSerial:47]; aSrRecNum{$i})
					If (Locked:C147([ItemSerial:47]))
						$bProcessed:=False:C215
					Else 
						$bProcessed:=True:C214
					End if 
				End if 
				If ($doPos)
					[ItemSerial:47]price:26:=Round:C94(DiscountApply(pUnitPrice; pDiscnt; 10); <>tcDecimalUP)
					[ItemSerial:47]salesLnRefid:11:=$3->
					[ItemSerial:47]status:8:="Iv"
					////        [ItemSerial]DateShipped:=Current date
					[ItemSerial:47]invoiceNum:10:=[Invoice:26]invoiceNum:2
					[ItemSerial:47]customerID:9:=[Invoice:26]customerID:3
					[ItemSerial:47]dateWarrantyEnd:21:=Current date:C33+[ItemSerial:47]warrantyDays:20
					Srl_Transaction(Table:C252(ptCurTable); $3->; True:C214; "Shipped")
					$4->:=$4->+$seperator+[ItemSerial:47]serialNum:4
					$cntSrl:=$cntSrl+1
				Else 
					[ItemSerial:47]poLnRefid:7:=-$3->  //mark to this line    
					[ItemSerial:47]poNum:6:=-3
					[ItemSerial:47]salesLnRefid:11:=0
					[ItemSerial:47]status:8:="Av"
					[ItemSerial:47]dateShipped:13:=!00-00-00!
					[ItemSerial:47]dateWarrantyEnd:21:=!00-00-00!
					[ItemSerial:47]comments:23:=String:C10(Current date:C33)+":  received as neg shipment"+"\r"+[ItemSerial:47]comments:23
					[ItemSerial:47]customerID:9:=""
					$4->:=$4->+$seperator+[ItemSerial:47]serialNum:4
					$cntSrl:=$cntSrl-1
					Srl_Transaction(Table:C252(ptCurTable); $3->; $bProcessed; "Returned")
				End if 
				SAVE RECORD:C53([ItemSerial:47])
		End case 
	End for 
	READ ONLY:C145([ItemSerial:47])
End if 
UNLOAD RECORD:C212([ItemSerial:47])
$0:=$cntSrl