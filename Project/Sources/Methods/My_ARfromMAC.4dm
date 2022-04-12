//%attributes = {"publishedWeb":true}
C_TEXT:C284($INVC_NMBR; $DATE; $AMOUNT; $SUBTOTAL; $PO_NMBR; $PAIDinFull; $ID_NO; $BILL_ID; $TERMS)
C_TEXT:C284($FREIGHT; $TAX; $textErr; $Rep; $Rep_Waits; $Rep2; $Rep2_Wait; $TaxCode; $Margin; $terminator)
C_TEXT:C284($quote)
C_TEXT:C284($1)
//
TRACE:C157
//CLOSE DOCUMENT(myDoc)
//Load "AR" file
//
$quote:=Char:C90(34)
If (Count parameters:C259=0)
	ALERT:C41("Hold Opt Key to load ONLY ACTIVE.")
	KeyModifierCurrent
	
	vDiaCom:="  Open AR file for importing from MAC."
	jGetFileDiaMess(->vDiaCom)  //Add title and open window
	myDoc:=Open document:C264("")
	CLOSE WINDOW:C154  //close window
Else 
	myDoc:=Open document:C264($1)
End if 
//
TRACE:C157
If (OK=1)
	While (OK=1)
		RECEIVE PACKET:C104(myDoc; $INVC_NMBR; "\t")
		RECEIVE PACKET:C104(myDoc; $DATE; "\t")
		RECEIVE PACKET:C104(myDoc; $AMOUNT; "\t")
		RECEIVE PACKET:C104(myDoc; $SUBTOTAL; "\t")
		RECEIVE PACKET:C104(myDoc; $PO_NMBR; "\t")
		RECEIVE PACKET:C104(myDoc; $PAIDinFull; "\t")  //T of F
		RECEIVE PACKET:C104(myDoc; $ID_NO; "\t")
		RECEIVE PACKET:C104(myDoc; $BILL_ID; "\t")
		RECEIVE PACKET:C104(myDoc; $CODEtrans; "\t")  //i for Invoice, P for payment, c credit(+pay), a adj(-pay)
		RECEIVE PACKET:C104(myDoc; $TERMS; "\t")
		RECEIVE PACKET:C104(myDoc; $FREIGHT; "\t")
		RECEIVE PACKET:C104(myDoc; $TAX; "\t")
		RECEIVE PACKET:C104(myDoc; $Rep; "\t")
		RECEIVE PACKET:C104(myDoc; $Rep_Waits; "\t")
		RECEIVE PACKET:C104(myDoc; $Rep2; "\t")
		RECEIVE PACKET:C104(myDoc; $Rep2_Wait; "\t")
		RECEIVE PACKET:C104(myDoc; $TaxCode; "\t")
		RECEIVE PACKET:C104(myDoc; $Margin; "\t")
		RECEIVE PACKET:C104(myDoc; $terminator; "\r")  //delete this element in final version
		If (OK=1)
			If (($PAIDinFull="F@") | (optKey=0))
				If (($CODEtrans="i") | ($CODEtrans="C"))
					QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=Num:C11($INVC_NMBR))
					If (Records in selection:C76([Invoice:26])=0)
						CREATE RECORD:C68([Invoice:26])
					Else 
						[Invoice:26]profile1:53:="modified"
						[Invoice:26]comment:43:=$DATE+"    "+$AMOUNT+"    "+String:C10([Invoice:26]balanceDue:44; "000,000.00")+"\r"
					End if 
					[Invoice:26]shipInstruct:40:=$ID_NO
					[Invoice:26]customerPO:29:=$PO_NMBR
					[Invoice:26]dateShipped:4:=Date:C102($DATE)
					[Invoice:26]dateInvoiced:35:=[Invoice:26]dateShipped:4
					[Invoice:26]invoiceNum:2:=Num:C11($INVC_NMBR)
					[Invoice:26]customerID:3:=$BILL_ID
					[Invoice:26]jrnlComplete:48:=True:C214
					[Invoice:26]dateLinked:31:=Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33)))
					[Invoice:26]terms:24:=$TERMS
					If ([Customer:2]customerID:1#$ID_NO)  //ship to address
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=$ID_NO)
					End if 
					If (Record number:C243([Customer:2])>-1)
						[Invoice:26]company:7:=[Customer:2]company:2
						[Invoice:26]address1:8:=[Customer:2]address1:4
						[Invoice:26]address2:9:=[Customer:2]address2:5
						[Invoice:26]city:10:=[Customer:2]city:6
						[Invoice:26]state:11:=[Customer:2]state:7
						[Invoice:26]zip:12:=[Customer:2]zip:8
						[Invoice:26]country:13:=[Customer:2]country:9
						[Invoice:26]zone:6:=[Customer:2]zone:57
						[Invoice:26]attention:38:=[Customer:2]nameFirst:73+(" "*Num:C11([Customer:2]nameFirst:73#""))+[Customer:2]nameLast:23
						[Invoice:26]shipVia:5:=[Customer:2]shipVia:12
						[Invoice:26]taxJuris:33:=[Customer:2]taxJuris:65
						[Invoice:26]phone:54:=[Customer:2]phone:13
						
						[Invoice:26]repID:22:=[Customer:2]repID:58
						[Invoice:26]salesNameID:23:=[Customer:2]salesNameID:59
					Else 
						[Invoice:26]company:7:="Missing "+[Invoice:26]company:7
					End if 
					$sign:=Num:C11($CODEtrans="i")-Num:C11($CODEtrans="c")
					[Invoice:26]amount:14:=Num:C11($SUBTOTAL)*$sign
					[Invoice:26]total:18:=Num:C11($AMOUNT)*$sign
					[Invoice:26]salesTax:19:=Num:C11($TAX)*$sign
					[Invoice:26]shipTotal:20:=Num:C11($FREIGHT)*$sign
					[Invoice:26]shipFreightCost:15:=[Invoice:26]shipTotal:20
					If ($PAIDinFull="F")
						[Invoice:26]balanceDue:44:=[Invoice:26]total:18
					Else 
						[Invoice:26]appliedAmount:46:=[Invoice:26]total:18
					End if 
					SAVE RECORD:C53([Invoice:26])
				Else 
					CREATE RECORD:C68([Payment:28])
					[Payment:28]dateReceived:10:=Date:C102($DATE)
					[Payment:28]orderNum:2:=-1
					[Payment:28]invoiceNum:3:=Num:C11($INVC_NMBR)
					[Payment:28]customerID:4:=$BILL_ID
					[Payment:28]jrnlComplete:16:=True:C214
					[Payment:28]dateLinked:18:=!1997-01-01!
					[Payment:28]timeReceived:52:=Current time:C178
					
					[Payment:28]checkNum:12:=$PO_NMBR
					[Payment:28]nameOnAcct:11:=$ID_NO
					[Payment:28]typePayment:6:=$CODEtrans
					[Payment:28]bankFrom:9:=$PAIDinFull
					If (($CODEtrans="F") | ($CODEtrans="A"))
						[Payment:28]amount:1:=-Num:C11($AMOUNT)
					Else 
						[Payment:28]amount:1:=Num:C11($AMOUNT)
					End if 
					//          
					Case of 
						: ($PAIDinFull="T@")  //already applied
							[Payment:28]amountAvailable:19:=0
						: ($PAIDinFull="F@")  //not applied
							If ([Payment:28]invoiceNum:3=0)
								[Payment:28]amountAvailable:19:=[Payment:28]amount:1
							Else 
								QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[Payment:28]invoiceNum:3)
								If (Records in selection:C76([Invoice:26])=1)
									[Invoice:26]appliedAmount:46:=Round:C94([Invoice:26]appliedAmount:46+[Payment:28]amount:1; 2)
									[Invoice:26]balanceDue:44:=Round:C94([Invoice:26]balanceDue:44-[Payment:28]amount:1; 2)
									[Payment:28]amountAvailable:19:=0
									PaidDaysCalc
									SAVE RECORD:C53([Invoice:26])
									Ledger_InvSave
								Else 
									[Payment:28]amountAvailable:19:=[Payment:28]amount:1
								End if 
							End if 
					End case 
					SAVE RECORD:C53([Payment:28])
					Ledger_PaySave
				End if 
			End if 
		End if 
	End while 
	CLOSE DOCUMENT:C267(myDoc)
End if 