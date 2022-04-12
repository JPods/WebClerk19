//%attributes = {}

// ----------------------------------------------------
// User name (OS): j.Medlen
// Date and time: 2016-10-10T00:00:00, 16:29:21
// ----------------------------------------------------
// Method: PriceCheck_OnServer
// Description
// Modified: 10/10/16
// 
// 
//
// Parameters
// ----------------------------------------------------
//OnServer Example


//Script PriceCheck_OnServer 20150520
// added allowAlerts_boo

C_LONGINT:C283(viReady)
C_LONGINT:C283(myProcess)
C_TEXT:C284(vtStatus)
ARRAY LONGINT:C221(alRecords; 0)

myProcess:=Current process:C322
viReady:=0
vtStatus:=""
Open window:C153(100; 200; 500; 300; 5; "Status")
ERASE WINDOW:C160
GOTO XY:C161(3; 3)

MESSAGE:C88("Searching for Pricing Errors...")

vlProcessID:=Execute on server:C373("ExecuteText"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-OnServer"; 0; [TallyMaster:60]build:6; *)
vlTestID:=Abs:C99(vlProcessID)

vi2:=0
While ((viReady=0) & (vi2<5400))  //timeout = 1/2 hour
	DELAY PROCESS:C323(Current process:C322; 20)
	vi2:=vi2+1
	GET PROCESS VARIABLE:C371(-vlTestID; viReady; viReady; vtStatus; vtStatus)
	If (vtStatus#"")
		ERASE WINDOW:C160
		GOTO XY:C161(3; 3)
		MESSAGE:C88(vtStatus)
	End if 
End while 
GET PROCESS VARIABLE:C371(-vlTestID; alRecords; alRecords)
//Alert("Size of Array alRecords = "+String(Size of Array(alRecords)))
CREATE SET FROM ARRAY:C641([Invoice:26]; alRecords; "myInvoices")
USE SET:C118("myInvoices")
SET PROCESS VARIABLE:C370(-vlTestID; myProcess; myProcess)

ERASE WINDOW:C160
GOTO XY:C161(3; 3)
MESSAGE:C88("Search Complete")
CLOSE WINDOW:C154

If (allowAlerts_boo)
	If (Records in selection:C76([Invoice:26])>0)
		ProcessTableOpen(Table:C252(->[Invoice:26]))
	Else 
		ALERT:C41("No Pricing Errors Found")
	End if 
End if 

//===============================================================
/////////////////////////////////////////////////////////////////
//===============================================================

//script  Price Check InvoiceLines 20150520

C_LONGINT:C283(viReady)
C_LONGINT:C283(myProcess)
C_TEXT:C284(vtStatus)
ARRAY LONGINT:C221(alRecords; 0)
viReady:=0
myProcess:=0
vtStatus:=""

vCR:=Char:C90(13)
vTab:=Char:C90(9)
vtMyMessage:=""
vbContinue:=True:C214

<>tcPriceLvlA:="List"
<>tcPriceLvlB:="Trade"
<>tcPriceLvlC:="Preferred"
<>tcPriceLvlD:="Distributor"

vdToday:=(Current date:C33)

viDayNum:=Day number:C114(vdToday)
If (viDayNum=2)
	vdToday:=vdToday-3
Else 
	vdToday:=vdToday-1
End if 

//vtDate:=String(vdToday;4)

//vdToday:=Date(Request ("Please Enter The Invoice Date:";vtDate))
//vtDate:=Request("Please Enter The Invoice Date:";vtDate)

vtDate:=String:C10(Current date:C33)

If (vtDate="")
	//Alert("Invalid Date")
	vbContinue:=False:C215
End if 
vdCheck:=Date:C102(vtDate)
If (vdCheck=!00-00-00!)
	//Alert("Invalid Date")
	vbContinue:=False:C215
End if 

If (vbContinue)
	viReady:=2
	CREATE EMPTY SET:C140([InvoiceLine:54]; "MySet")
	
	//myDoc:=create document("")
	vtHeader:="InvoiceLine"+vTab+"InvoiceLine"+vTab+"Invoice"+vTab+"InvoiceLine"+vTab+"Invoice"+vTab+"InvoiceLine"+vTab+"InvoiceLine"+vTab+"InvoiceLine"+vTab+"InvoiceLine"+vTab+"InvoiceLine"+vTab+"Invoices/SpecialDiscount"+vCR
	vtHeader:=vtHeader+"idNum"+vTab+"Invoice"+vTab+"Order"+vTab+"DateShipped"+vTab+"TypeSale"+vTab+"PricePoint"+vTab+"ItemNum"+vTab+"UnitPrice"+vTab+"Discount"+vTab+"DiscountPrice"+vTab+"PriceCheck"+vCR
	//Send Packet(myDoc;vtHeader)
	
	//Open window(100;200;500;300;5;"Message")
	//ERASE WINDOW
	//GOTO XY(10;3)
	
	//MESSAGE("Starting Script Basic Loop")
	
	vdDate:=Date:C102(vtDate)
	
	//Query([InvoiceLine];[InvoiceLine]DateShipped>=(vdDate-30))
	QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]dateShipped:25>=(vdDate-7))
	
	vi2:=Records in selection:C76([InvoiceLine:54])
	FIRST RECORD:C50([InvoiceLine:54])
	For (vi1; 1; vi2)
		
		If (Caps lock down:C547)
			CONFIRM:C162("Abort Process (Caps Lock ON)")
			If (OK=1)
				vi1:=vi2
			End if 
		End if 
		
		//ERASE WINDOW
		//GOTO XY(6;3)
		//MESSAGE("Checking Pricing Record "+String(vi1)+" of "+String(vi2))
		vtStatus:="Checking Pricing Record "+String:C10(vi1)+" of "+String:C10(vi2)
		
		QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[InvoiceLine:54]invoiceNum:1)
		
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[InvoiceLine:54]itemNum:4)
		
		QUERY:C277([SpecialDiscount:44]; [SpecialDiscount:44]typeSale:1=[Invoice:26]typeSale:49)
		
		vi3:=Records in selection:C76([SpecialDiscount:44])
		If ((vi3=0) & ([Invoice:26]typeSale:49#<>tcPriceLvlA) & ([Invoice:26]typeSale:49#<>tcPriceLvlB) & ([Invoice:26]typeSale:49#<>tcPriceLvlC) & ([Invoice:26]typeSale:49#<>tcPriceLvlD))
			//Alert("Invalid Special Discount "+[Invoice]TypeSale+" In Order "+String([Invoice]InvoiceNum))
			ADD TO SET:C119([InvoiceLine:54]; "MySet")
			vrPrice:=0
		Else 
			
			QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]specialDiscountsid:1=[SpecialDiscount:44]idNum:4; *)
			QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]itemNum:2=[InvoiceLine:54]itemNum:4; *)
			QUERY:C277([ItemDiscount:45])
			
			vrPrice:=0
			
			viRecords:=Records in selection:C76([ItemDiscount:45])
			
			If (viRecords=1)
				
				vrPrice:=([ItemDiscount:45]basePrice:5-([ItemDiscount:45]basePrice:5*[ItemDiscount:45]perCentDiscount:4*0.01))
				vrPrice:=Round:C94(vrPrice; 2)
				
			Else 
				
				Case of 
					: ([SpecialDiscount:44]priceBase:8=1)
						vrPrice:=[Item:4]priceA:2
						
					: ([SpecialDiscount:44]priceBase:8=2)
						vrPrice:=[Item:4]priceB:3
						
					: ([SpecialDiscount:44]priceBase:8=3)
						vrPrice:=[Item:4]priceC:4
						
					: ([SpecialDiscount:44]priceBase:8=4)
						vrPrice:=[Item:4]priceD:5
						
					: ([SpecialDiscount:44]priceBase:8=5)
						vrPrice:=[Item:4]priceMSR:109
						
				End case 
				
			End if 
			
		End if 
		
		Case of 
			: ([Invoice:26]typeSale:49=<>tcPriceLvlA)
				vrPrice:=[Item:4]priceA:2
				
			: ([Invoice:26]typeSale:49=<>tcPriceLvlB)
				vrPrice:=[Item:4]priceB:3
				
			: ([Invoice:26]typeSale:49=<>tcPriceLvlC)
				vrPrice:=[Item:4]priceC:4
				
			: ([Invoice:26]typeSale:49=<>tcPriceLvlD)
				vrPrice:=[Item:4]priceD:5
				
		End case 
		
		vrPrice2:=([InvoiceLine:54]unitPrice:9-([InvoiceLine:54]unitPrice:9*[InvoiceLine:54]discount:10*0.01))
		vrPrice2:=Round:C94(vrPrice2; 2)
		
		//If ((vrPrice#vrPrice2) & ([InvoiceLine]Comment#"@Price Check OK@") & ([InvoiceLine]ItemNum#"9060@") & ([InvoiceLine]QtyShipped>0) & ([InvoiceLine]ItemNum#"R-@") & ([InvoiceLine]ItemNum#"Credit") & ([InvoiceLine]ItemNum#"Freight") & ([InvoiceLine]ItemNum#"Sample") & ([Item]Profile2#"LTG@") & ([InvoiceLine]ItemNum#"CLC@") & ([InvoiceLine]ItemNum#"FL101@") & ([InvoiceLine]ItemNum#"Rebate"))
		
		If ((vrPrice#vrPrice2) & ([InvoiceLine:54]comment:40#"@Price Check OK@") & ([InvoiceLine:54]itemNum:4#"9060@") & ([InvoiceLine:54]qty:7>0) & ([Item:4]profile1:35#"@repair@") & ([Item:4]profile1:35#"@books@") & ([Item:4]profile2:36#"LTG@"))
			
			ADD TO SET:C119([InvoiceLine:54]; "MySet")
			
			//QUERY([Invoice];[Invoice]InvoiceNum=[InvoiceLine]InvoiceNum)
			
			//Send Packet(myDoc;String([InvoiceLine]InvoiceNum)+vTab)
			//Send Packet(myDoc;String([Invoice]OrderNum)+vTab)
			//Send Packet(myDoc;String([InvoiceLine]DateShipped)+vTab)
			//Send Packet(myDoc;[Invoice]TypeSale+vTab)
			//Send Packet(myDoc;[InvoiceLine]TypeSale+vTab)
			//Send Packet(myDoc;[InvoiceLine]ItemNum+vTab)
			//Send Packet(myDoc;String([InvoiceLine]UnitPrice)+vTab)
			//Send Packet(myDoc;String([InvoiceLine]Discount)+vTab)
			//Send Packet(myDoc;String(vrPrice2)+vTab)
			//Send Packet(myDoc;String(vrPrice)+vCR)
			
			vtMyMessage:=vtMyMessage+String:C10([InvoiceLine:54]idNum:47)+vTab
			vtMyMessage:=vtMyMessage+String:C10([InvoiceLine:54]invoiceNum:1)+vTab
			vtMyMessage:=vtMyMessage+String:C10([Invoice:26]orderNum:1)+vTab
			vtMyMessage:=vtMyMessage+String:C10([InvoiceLine:54]dateShipped:25)+vTab
			vtMyMessage:=vtMyMessage+[Invoice:26]typeSale:49+vTab
			vtMyMessage:=vtMyMessage+[InvoiceLine:54]typeSale:27+vTab
			vtMyMessage:=vtMyMessage+[InvoiceLine:54]itemNum:4+vTab
			vtMyMessage:=vtMyMessage+String:C10([InvoiceLine:54]unitPrice:9)+vTab
			vtMyMessage:=vtMyMessage+String:C10([InvoiceLine:54]discount:10)+vTab
			vtMyMessage:=vtMyMessage+String:C10(vrPrice2)+vTab
			vtMyMessage:=vtMyMessage+String:C10(vrPrice)+vCR
			
		End if 
		
		NEXT RECORD:C51([InvoiceLine:54])
	End for 
	
	//ERASE WINDOW
	//GOTO XY(10;3)
	//MESSAGE("Ending Script Basic Loop")
	//CLOSE WINDOW
	
	//Close Document(myDoc)
	
	If (vtMyMessage="")
		vtGroupID:="FRSQ"
	Else 
		vtMyMessage:=vtHeader+vtMyMessage
		vtGroupID:="FRSQ Error"
	End if 
	
	
	vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
	vtMyDate:=String:C10(Current date:C33; 4)
	vtMyText:=" Price Check For "+vtDate+" Executed By  "
	vtMyName:=(Current user:C182)
	//vtComment:= vtMyDate + ": " + vtMyTime + "; "+ vtMyText + vtMyName + vCR + vCR + vtMyMessage
	vtComment:=vtMyText+vtMyName+" - "+vtMyDate+": "+vtMyTime+vCR+vCR+vtMyMessage
	ELog_NewRecord(0; vtGroupID; vtComment)
	
	USE SET:C118("MySet")
	CLEAR SET:C117("MySet")
	
	CREATE EMPTY SET:C140([Invoice:26]; "MySetA")
	
	vi2:=Records in selection:C76([InvoiceLine:54])
	If (vi2=0)
		//Alert("No Price Errors Found")
		vText:="No Price Errors Found"
	Else 
		//CREATE EMPTY SET([Invoice];"MySetA")
		FIRST RECORD:C50([InvoiceLine:54])
		For (vi1; 1; vi2)
			QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[InvoiceLine:54]invoiceNum:1)
			ADD TO SET:C119([Invoice:26]; "MySetA")
			[Invoice:26]timesPrinted:51:=[Invoice:26]timesPrinted:51+10
			
			If ([Invoice:26]profile4:83#"@ERR @")
				[Invoice:26]profile4:83:=[Invoice:26]profile4:83+"ERR "
			End if 
			
			vtMyMessage:=" Price Check Invoice "+String:C10([Invoice:26]invoiceNum:2)+" by "
			vtComment:=vtMyDate+": "+vtMyTime+"; "+vtMyMessage+vtMyName+Char:C90(13)
			[Invoice:26]commentProcess:73:=Insert string:C231([Invoice:26]commentProcess:73; vtComment; 0)
			SAVE RECORD:C53([Invoice:26])
			NEXT RECORD:C51([InvoiceLine:54])
		End for 
		
		//Modify Selection([InvoiceLine])
	End if 
	
	USE SET:C118("MySetA")
	CLEAR SET:C117("MySetA")
	SELECTION TO ARRAY:C260([Invoice:26]; alRecords)
	viReady:=3
	vi2:=0
	While ((myProcess=0) & (vi2<1800))  //timeout = 1/2 hour
		vi2:=vi2+1
		DELAY PROCESS:C323(Current process:C322; 60)
	End while 
	
End if   //vbContinue
