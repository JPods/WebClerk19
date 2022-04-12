//%attributes = {"publishedWeb":true}
C_LONGINT:C283($0; $1)  //count, line num
C_REAL:C285($5)
C_LONGINT:C283($curSrRec; $0; $cntSrl)
C_POINTER:C301($2; $3; $4)
C_TEXT:C284($seperator)
C_PICTURE:C286($origSrl)
C_BOOLEAN:C305($doPos)
//viRecordsInSelection:=0  //set to the number of order lines to convert to invoice lines
//viRecordsInTable:=$3
If ((aPOQtyRcvd{aPOLineAction}<0) | (pQtyShip<0))
	$doPos:=False:C215
Else 
	$doPos:=True:C214
End if 

If ($doPos)  //increasing + shipping (aiQtyShip{$1}>=0)&(aiQtyShip{$1}
	QUERY:C277([ItemSerial:47]; [ItemSerial:47]itemNum:1=aPoItemNum{$1}; *)
	QUERY:C277([ItemSerial:47];  & [ItemSerial:47]status:8="Vo"; *)
	QUERY:C277([ItemSerial:47];  | [ItemSerial:47]poLnRefid:7=aPoSerialRc{$1})
Else 
	QUERY:C277([ItemSerial:47]; [ItemSerial:47]itemNum:1=aPoItemNum{$1}; *)
	QUERY:C277([ItemSerial:47];  & [ItemSerial:47]status:8="AV"; *)
	QUERY:C277([ItemSerial:47];  | [ItemSerial:47]poLnRefid:7=aPoSerialRc{$1})
End if 
Srl_FillRay(Records in selection:C76([ItemSerial:47]))
vDiaCom:="Serial # for "+$2->
vsnItmAlpha:=$2->
jCenterWindow(560; 440; 1)
DIALOG:C40([ItemSerial:47]; "diaSerialSet")
CLOSE WINDOW:C154
vDiaCom:=""
TRACE:C157
If (myOK#2)
	$cntSrl:=aPOQtyRcvd{$1}
Else 
	$4->:=""
	$seperator:=""
	READ WRITE:C146([ItemSerial:47])
	$cntSrl:=0
	$k:=Size of array:C274(aSrAvail)
	For ($i; 1; $k)
		$seperator:="; "*Num:C11($4->#"")
		$w:=Find in array:C230(aSrRecSel; $i)
		Case of 
			: (($w>-1) & (aSrPoID{$i}=$3->))  //currently on this Po and selected
				$4->:=$4->+$seperator+aSrNum{$i}
				If ($doPos)
					$cntSrl:=$cntSrl+1
				Else 
					$cntSrl:=$cntSrl-1
				End if 
				//
			: (($w=-1) & (aSrPoID{$i}=$3->))  //was on Po but not selected
				GOTO RECORD:C242([ItemSerial:47]; aSrRecNum{$i})
				If (Locked:C147([ItemSerial:47]))
					$bProcessed:=False:C215
				Else 
					$bProcessed:=True:C214
				End if 
				[ItemSerial:47]poLnRefid:7:=0  //mark to this line            
				If ($doPos)  //not RTVed
					[ItemSerial:47]status:8:="Vo"
					Srl_Transaction(Table:C252(ptCurTable); $3->; $bProcessed; "Voided from PO")
					[ItemSerial:47]dateReceived:12:=!00-00-00!
					[ItemSerial:47]poLnRefid:7:=0
					[ItemSerial:47]poNum:6:=0
					[ItemSerial:47]vendorid:5:=""
					[ItemSerial:47]invoiceNum:10:=0
				Else 
					[ItemSerial:47]status:8:="AV"
					Srl_Transaction(Table:C252(ptCurTable); $3->; $bProcessed; "Remove from RTV")
				End if 
				SAVE RECORD:C53([ItemSerial:47])
				
			: ($w>-1)  //Selected serial num item not on this line
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
					[ItemSerial:47]vendorid:5:=[Vendor:38]vendorid:1
					[ItemSerial:47]customerid:9:=[PO:39]refCustomer:47
				Else 
					GOTO RECORD:C242([ItemSerial:47]; aSrRecNum{$i})
					If (Locked:C147([ItemSerial:47]))
						$bProcessed:=False:C215
					Else 
						$bProcessed:=True:C214
					End if 
				End if 
				[ItemSerial:47]poLnRefid:7:=$3->  //mark to this line    
				[ItemSerial:47]poNum:6:=[PO:39]poNum:5
				$4->:=$4->+$seperator+[ItemSerial:47]serialNum:4
				If ($doPos)
					[ItemSerial:47]poNum:6:=[PO:39]poNum:5
					[ItemSerial:47]status:8:="AV"
					[ItemSerial:47]cost:24:=Round:C94(DiscountApply(pUnitCost; pDiscnt; 10); <>tcDecimalUC)
					Srl_Transaction(Table:C252(ptCurTable); $3->; $bProcessed; "available")
					$cntSrl:=$cntSrl+1
				Else 
					[ItemSerial:47]poNum:6:=-3
					[ItemSerial:47]status:8:="RTV"
					Srl_Transaction(Table:C252(ptCurTable); $3->; $bProcessed; "Return to vendor")
					$cntSrl:=$cntSrl-1
				End if 
				SAVE RECORD:C53([ItemSerial:47])
		End case 
	End for 
	READ ONLY:C145([ItemSerial:47])
End if 
UNLOAD RECORD:C212([ItemSerial:47])
$0:=$cntSrl