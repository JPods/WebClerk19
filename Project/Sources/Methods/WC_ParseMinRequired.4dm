//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WC_ParseMinRequired
	//Date: 03/11/03
	//Who: Bill
	//Description: Executed only on new records, saved after this step.
End if 
C_POINTER:C301($1)
C_BOOLEAN:C305($0; $doSave)
$0:=True:C214
Case of 
	: ($1=(->[Order:3]))
		If ([Order:3]idNum:2=0)
			[Order:3]idNum:2:=CounterNew(->[Order:3])
			// $0:=False
			// vResponse:="Echo of another order. Check for commands on a page."
		End if 
	: ($1=(->[Invoice:26]))
		If ([Invoice:26]idNum:2=0)
			[Invoice:26]idNum:2:=CounterNew(->[Invoice:26])
		End if 
		If ([Invoice:26]idNumOrder:1=0)
			[Order:3]idNum:2:=1
		End if 
	: ($1=(->[Customer:2]))
		If ([Customer:2]customerID:1="")
			[Customer:2]customerID:1:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Customer:2]))
		End if 
		If ([Customer:2]company:2="")
			[Customer:2]company:2:=[Customer:2]nameLast:23+", "+[Customer:2]nameFirst:73
			[Customer:2]individual:72:=True:C214
		End if 
		
	: ($1=(->[Item:4]))
		If ([Item:4]itemNum:1="")
			[Item:4]itemNum:1:=String:C10(CounterNew(->[Item:4]))
		End if 
	: ($1=(->[Rep:8]))
		If ([Rep:8]repID:1="")
			[Rep:8]repID:1:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Rep:8]))
		End if 
	: ($1=(->[Vendor:38]))
		If ([Vendor:38]vendorID:1="")
			[Vendor:38]vendorID:1:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Vendor:38]))
		End if 
	: ($1=(->[Payment:28]))
		C_REAL:C285($tendered; $payChange)
		If ([Payment:28]dateLinked:18#!00-00-00!)
			response:="Payment is linked and cannot be modified."
			$0:=False:C215
		Else 
			If ([Payment:28]status:46="")  //any payment not cleared with not journalize
				[Payment:28]status:46:="HOLD_web"
			End if 
			
			[Payment:28]dateDocument:10:=Current date:C33
			
			If (Is new record:C668([Payment:28]))
				[Payment:28]change:45:=0
				[Payment:28]amount:1:=[Payment:28]tendered:44
				[Payment:28]amountAvailable:19:=[Payment:28]tendered:44
			Else 
				[Payment:28]change:45:=[Payment:28]tendered:44-Old:C35([Payment:28]tendered:44)
				[Payment:28]amount:1:=[Payment:28]amount:1+[Payment:28]change:45
				[Payment:28]amountAvailable:19:=[Payment:28]amountAvailable:19+[Payment:28]change:45
			End if 
			//[Payment]TakeBy:=[RemoteUser]UserName
			[Payment:28]takeBy:42:=[Employee:19]nameID:1
			If (([Payment:28]amount:1=0) & ([Payment:28]tendered:44=0) & ([Payment:28]amountAvailable:19=0) & ([Payment:28]creditCardEncode:50="") & ([Payment:28]checkNum:12=""))
				$0:=False:C215
				vResponse:="You must have a Tendered, Amount, Credit Card or Check Number to save a Payment"
			Else 
				If ([Payment:28]bankFrom:9#"")
					If ([Payment:28]customerID:4#[Customer:2]customerID:1)
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerID:4)
					End if 
					[Payment:28]bankFrom:9:=CreditCardParse([Payment:28]bankFrom:9)
					// process the credit card in WccAcceptTasks after the record is saved
				End if 
			End if 
			If ([Payment:28]idNumOrder:2>9)
				If ([Order:3]idNum:2#[Payment:28]idNumOrder:2)
					QUERY:C277([Order:3]; [Order:3]idNum:2=[Payment:28]idNumOrder:2)
				End if 
				[Order:3]tendered:113:=[Order:3]tendered:113+[Payment:28]tendered:44
				[Order:3]tenderedChange:114:=[Order:3]tenderedChange:114+[Payment:28]change:45
				If ([Order:3]idNum:2>0)
					SAVE RECORD:C53([Order:3])
				Else 
					[EventLog:75]areYouHuman:36:="zeroOrder"
					EventLogsMessage("Trying to save a zero Order WC_ParseMinRequired.")
				End if 
			End if 
		End if 
	: ($1=(->[PO:39]))
		If ([PO:39]idNum:5=0)
			[PO:39]idNum:5:=CounterNew(->[PO:39])
		End if 
	: ($1=(->[Proposal:42]))
		If ([Proposal:42]idNum:5=0)
			[Proposal:42]idNum:5:=CounterNew(->[Proposal:42])
		End if 
		
	: ($1=(->[OrderLine:49]))
		If ([OrderLine:49]idNumOrder:1=0)
			$0:=False:C215
			vResponse:="You must have an existing Order to save an Order Line"
		Else 
			If (([OrderLine:49]idNum:50=0) | (Is new record:C668([OrderLine:49])))
				
				[OrderLine:49]lineNum:3:=[OrderLine:49]idNum:50  //identify that this is a new line so inventory is managed
				[OrderLine:49]seq:30:=[OrderLine:49]idNum:50
			End if 
		End if 
	: ($1=(->[InvoiceLine:54]))
		If ([InvoiceLine:54]idNumInvoice:1=0)
			$0:=False:C215
			vResponse:="You must have an existing Invoice to save an Invoice Line"
		Else 
			If (([InvoiceLine:54]idNum:47=0) | (Is new record:C668([InvoiceLine:54])))
				[InvoiceLine:54]lineNum:3:=[InvoiceLine:54]idNum:47  //identify that this is a new line so inventory is managed
				[InvoiceLine:54]seq:28:=[InvoiceLine:54]idNum:47
			End if 
		End if 
	: ($1=(->[ProposalLine:43]))
		If ([ProposalLine:43]idNumProposal:1=0)
			$0:=False:C215
			vResponse:="You must have an existing Proposal to save an Proposal Line"
		Else 
			
		End if 
		
	: ($1=(->[POLine:40]))
		If ([POLine:40]idNumPO:1=0)
			$0:=False:C215
			vResponse:="You must have an existing PO to save an PO Line"
		End if 
End case 