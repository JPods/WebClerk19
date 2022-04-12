//%attributes = {}
//Cust_CMAExportOrder
TRACE:C157


myDoc:=Create document:C266("")
// 
If (OK=1)
	vi2:=Records in selection:C76([Order:3])
	FIRST RECORD:C50([Order:3])
	
	// 
	//Write the header line to the top of the export file: 
	SEND PACKET:C103(myDoc; "CUSTOMER #/HTSNO"+"\t"+"P/O #/HTCPO"+"\t"+"SALESMAN #/HTSLM1"+"\t"+"ORDER #"+"\t"+"SHIP TO ADDR1"+"\t"+"SHIP TO ADDR 2"+"\t")
	SEND PACKET:C103(myDoc; "SHIP TO ADDR 3"+"\t"+"SHIP TO ADDR 4"+"\t"+"SHIP TO ADDR 5"+"\t"+"SHIP TO ADDR 6"+"\t"+"SHIP TO ZIP"+"\t"+"STORE #"+"\t")
	SEND PACKET:C103(myDoc; "DUE DATE"+"\t"+"COMMENTS"+"\t"+"SHIP DATE"+"\t"+"BACK ORDER (Y/N)"+"\t"+"ITEM/UPC #"+"\t"+"QUANTITY"+"\t")
	SEND PACKET:C103(myDoc; "BACKCOUNTER ORDER (Y/N)"+"\t"+"SUBSTITUTE ITEM (Y/N)"+"\t"+"PROGRAM ORDER (Y/N)"+"\t"+"UNIT OF MEAS"+"\t"+"PAYMENT TERMS"+"\t"+"LINE DISCOUNT %"+"\t")
	SEND PACKET:C103(myDoc; "SALES TYPE/HTSLTP"+"\t"+"CUST CON#/CS21CT/CS33SN"+"\t")
	SEND PACKET:C103(myDoc; "REL DATE"+"\t"+"OVR PRICE/HTLUPR"+"\t"+"PRICE EXT CODE"+"\t"+"COMMENT/CHTLFL"+"\t"+"SHIP INST/HTSPIN"+"\t"+"ORDER NOTE/ORDNOTE"+"\t")
	SEND PACKET:C103(myDoc; "HOLD ORDER"+"\t"+"PRICE LVL"+"\t"+"LINE TYPE"+"\t"+"SHIP WH"+"\t"+"ITEM DESC"+"\t"+"PO DATE"+"\t")
	SEND PACKET:C103(myDoc; "FUTURE DATE"+"\t"+"SHIP DATE"+"\t"+"CANCEL DATE"+"\t"+"PREPAID/COLLECT"+"\t"+"B/O SALES CODE"+"\t"+"TRANS. SET ID"+"\t")
	SEND PACKET:C103(myDoc; "ORIGINAL ORDER#"+"\t"+"BILLTO CUSTOMER#"+"\t"+"BILL TO NAME"+"\t"+"BILL TO ADDR 1"+"\t"+"BILL TO CITY"+"\t"+"BILL TO STATE"+"\t"+"BILL TO ZIP")
	// Insert a Carriage Return: 
	SEND PACKET:C103(myDoc; "\r")
	// 
	For (vi1; 1; vi2)
		// 
		//Since we'll need some data from the corresponding Customer record, 
		//pull it into memory with this Query: 
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
		// 
		// These have been selected and ordered per the Excel spreadsheet that 
		// matches up the database fields 
		// with the corresponding Vietri fields that are required. 
		// 
		// There are actually two types of lines that have to be written out, 
		// the first one for each order only has Customer information in it; 
		// it does not have line item information 
		// in it. So you'll see a lot more blank tabs. 
		// The second line will be printed for each individual order line. 
		// Evidently it's OK to have Customer data 
		// in the second line as well, but there must not be OrderLines information in the
		// 
		// === Line Type #1: Order / Customer Information 
		//   =====================================
		// 
		// Insert Vietri's customer ID for this CMA customer in the
		//  "[Order]UPSReceiverAcct" field, which is at the bottom of the Customer Ship
		// Just inserting "CMA" into the first column does not cut it.
		// 
		SEND PACKET:C103(myDoc; [Order:3]upsReceiverAcct:90+"\t"+[Order:3]customerPO:3+"\t"+"41"+"\t"+String:C10([Order:3]orderNum:2)+"\t"+[Order:3]company:15+"\t")
		// 
		// Here's all the Address information: 
		
		SEND PACKET:C103(myDoc; [Order:3]address1:16+"\t"+[Order:3]address2:17+"\t"+[Order:3]city:18+"\t"+[Order:3]state:19+"\t"+"\t"+[Order:3]zip:20+"\t"+"\t"+"\t")
		
		// Insert 3 Tabs: 
		SEND PACKET:C103(myDoc; "\t"+"\t"+"\t")
		// 
		// Change this next line for the OrdLines loops: 
		SEND PACKET:C103(myDoc; "\t"+"\t"+"\t"+"\t"+"\t"+"\t"+"\t"+"\t")
		// 
		// Insert 5 Tabs: 
		SEND PACKET:C103(myDoc; "\t"+"\t"+"\t"+"\t"+"\t")
		
		SEND PACKET:C103(myDoc; "\t"+"\t"+"\t"+"\t"+"\t"+"\t")
		// 
		// Change this next line for the OrderLines loops: 
		SEND PACKET:C103(myDoc; "\t"+"\t")
		// 
		// Insert 9 Tabs: 
		SEND PACKET:C103(myDoc; "\t"+"\t"+"\t"+"\t"+"\t"+"\t"+"\t"+"\t"+"\t")
		// 
		SEND PACKET:C103(myDoc; "\t"+"\t"+"\t"+"\t")
		// 
		// Insert a Carriage Return: 
		SEND PACKET:C103(myDoc; "\r")
		// 
		// ================== 
		// Now check the individual order lines (OrderLines): 
		QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
		// 
		vi4:=Records in selection:C76([OrderLine:49])
		FIRST RECORD:C50([OrderLine:49])
		// 
		For (vi3; 1; vi4)
			//
			// === Line Type #2: Individual Order Line (OrderLines) Information 
			//  =====================================
			SEND PACKET:C103(myDoc; "\t"+"\t"+"41"+"\t"+String:C10([Order:3]orderNum:2)+"\t"+[Order:3]company:15+"\t")
			// 
			// Here's all the Address information: 
			iLo20String1:=Date_StrMMddYY([Order:3]dateNeeded:5)
			iLo20String5:=Date_StrMMddYY([Order:3]dateCancel:53)  //zzzCancelDate
			//   iLo20String1:=Replace string(iLo20String1;"/";"")
			SEND PACKET:C103(myDoc; [Order:3]address1:16+"\t"+[Order:3]address2:17+"\t"+[Order:3]city:18+"\t"+[Order:3]state:19+"\t"+"\t"+[Order:3]zip:20+"\t"+"\t"+iLo20String1+"\t")
			// 
			// Here's a bunch of blank columns in the spreadsheet, but it still needs the 3 Ta
			SEND PACKET:C103(myDoc; "\t"+"\t"+"\t")
			// 
			// Changed this next line for the OrderLines loops: 
			// Note: using [OrderLine]AltItem did *not* provide me with a manufacturer's item
			// Trying [OrderLine]ItemNum: 
			SEND PACKET:C103(myDoc; [OrderLine:49]altItem:31+"\t"+String:C10([OrderLine:49]qty:6)+"\t"+"\t"+"N"+"\t"+"N"+"\t"+[OrderLine:49]unitofMeasure:19+"\t"+[Order:3]terms:23+"\t"+"0"+"\t")
			// 
			// Here's a bunch of blank columns in the spreadsheet, but it still needs only 5 T
			SEND PACKET:C103(myDoc; "\t"+"\t"+"\t"+"\t"+"\t")
			iLoText1:=Replace string:C233([Order:3]shipInstruct:46; "\r"; " ")
			iLoText2:=Replace string:C233([Order:3]comment:33; "\r"; " ")
			SEND PACKET:C103(myDoc; "\t"+iLoText1+"\t"+iLoText2+"\t"+"\t"+"\t"+"\t")
			// 
			// Changed this next line for the OrderLines loops: 
			SEND PACKET:C103(myDoc; "\t"+[OrderLine:49]description:5+"\t")
			// 
			// 9 Tabs: 
			iLo20String2:=Date_StrMMddYY([Order:3]dateOrdered:4)  //zzzPODate
			iLo20String3:=Date_StrMMddYY([Order:3]dateNeeded:5)  //zzzFutureDate
			iLo20String4:=Date_StrMMddYY([Order:3]dateNeeded:5)  //zzzShipDate
			iLo20String5:=Date_StrMMddYY([Order:3]dateCancel:53)  //zzzCancelDate
			
			SEND PACKET:C103(myDoc; iLo20String2+"\t"+iLo20String3+"\t"+iLo20String4+"\t"+iLo20String5+"\t"+"\t"+"\t"+"\t"+"\t"+"\t")
			// 
			SEND PACKET:C103(myDoc; [Order:3]company:15+"\t"+[Order:3]billToAddress1:95+"\t"+[Order:3]billToCity:97+"\t"+[Order:3]billToState:98+"\t"+[Order:3]billToZip:99)
			// 
			// Insert a Carriage Return: 
			SEND PACKET:C103(myDoc; "\r")
			
			// 
			// ================== 
			// 
			NEXT RECORD:C51([OrderLine:49])
			// 
			//    End the FOR loop that grinds through the OrdLines: 
		End for 
		// 
		// Here's where we change the Orders record to Status = Exported: 
		[Order:3]status:59:="Exported"
		// 
		//Don't forget to update the record by saving it. 
		SAVE RECORD:C53([Order:3])
		// 
		NEXT RECORD:C51([Order:3])
		// 
		// End the FOR loop that grinds through the Orders 
	End for 
	// 
	CLOSE DOCUMENT:C267(myDoc)
	
End if 


