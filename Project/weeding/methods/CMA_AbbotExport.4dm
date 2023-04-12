//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/17/11, 05:36:19
// ----------------------------------------------------
// Method: CMA_AbbotExport
// Description
// 

// Parameters
// ----------------------------------------------------
//vText9 can be used to just create documents without emailing them
//QUERY([Order];[Order]Profile6="testAbbott")

//vdate2:=Current date+(19*7)

If (allowAlerts_boo)
	CONFIRM:C162("Export Abbot Orders?: "+String:C10(Records in selection:C76([Order:3])))
Else 
	OK:=1
End if 
If (OK=1)
	C_TEXT:C284($orderDocName; $lineDocName)
	iLoText3:=Time string:C180(Current time:C178)
	iloText4:=String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33); 2)+String:C10(Day of:C23(Current date:C33))+Substring:C12(iLoText3; 1; 2)+Substring:C12(iLoText3; 4; 2)+Substring:C12(iLoText3; 7; 2)+".tab"  //yyyymmddhhmmss.tab
	$orderDocName:=Storage:C1525.folder.jitF+"MfrAbbott"+Folder separator:K24:12+"orders_"+iloText4
	$lineDocName:=Storage:C1525.folder.jitF+"MfrAbbott"+Folder separator:K24:12+"lines_"+iloText4
	vi9:=Test path name:C476(Storage:C1525.folder.jitF+"MfrAbbott")
	
	If (vi9#0)  //0 if folder exists, 1 if document exists, -1 if nothing
		CREATE FOLDER:C475(Storage:C1525.folder.jitF+"MfrAbbott")
	End if 
	myDoc:=Create document:C266($orderDocName)
	If (OK=1)
		sumDoc:=Create document:C266($lineDocName)
		vi2:=Records in selection:C76([Order:3])
		FIRST RECORD:C50([Order:3])
		For (vi1; 1; vi2)
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
			vi4:=Records in selection:C76([OrderLine:49])
			FIRST RECORD:C50([OrderLine:49])
			For (vi3; 1; vi4)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=[OrderLine:49]itemNum:4)
				//
				SEND PACKET:C103(sumDoc; "OSA"+"\t")  //"OSA"
				SEND PACKET:C103(sumDoc; String:C10([OrderLine:49]qty:6)+"\t")  //[OrderLine]QtyOrdered
				SEND PACKET:C103(sumDoc; String:C10([OrderLine:49]unitPrice:9)+"\t")  //[OrderLine]UnitPrice
				SEND PACKET:C103(sumDoc; "0"+"\t")  //SRP
				SEND PACKET:C103(sumDoc; String:C10([OrderLine:49]unitPrice:9)+"\t")  //[OrderLine]UnitPrice
				SEND PACKET:C103(sumDoc; String:C10([OrderLine:49]idNum:50)+"\t")  //[OrderLine]LineNum
				SEND PACKET:C103(sumDoc; Date_strYyyymmdd([Order:3]dateDocument:4)+"\t")  //[Order]DateOrdered
				SEND PACKET:C103(sumDoc; Date_strYyyymmdd([Order:3]dateDocument:4)+Replace string:C233(Time string:C180([Order:3]timeOrdered:58); ":"; "")+"\t")  //[Order]TimeOrdered
				SEND PACKET:C103(sumDoc; String:C10([Item:4]qtyBundleSell:79)+"\t")  //[Item]QtyBundleSell
				SEND PACKET:C103(sumDoc; String:C10([Item:4]qtyBundleSell:79)+"\t")  //[Item]QtyBundleSell
				SEND PACKET:C103(sumDoc; "0"+"\t")  //????
				SEND PACKET:C103(sumDoc; "0"+"\t")  //TIL
				SEND PACKET:C103(sumDoc; "0"+"\t")  //PIL
				SEND PACKET:C103(sumDoc; "0"+"\t")  //QOH1
				SEND PACKET:C103(sumDoc; "0"+"\t")  //QOH2
				SEND PACKET:C103(sumDoc; "0"+"\t")  //UnitsSold
				SEND PACKET:C103(sumDoc; String:C10([OrderLine:49]idNumOrder:1)+"\t")  //[OrderLine]OrderNum
				SEND PACKET:C103(sumDoc; [OrderLine:49]altItem:31+"\t")  //[OrderLine]AltItem
				SEND PACKET:C103(sumDoc; [Item:4]barCode:34+"\t")  //[Item]Barcode
				SEND PACKET:C103(sumDoc; [OrderLine:49]description:5+"\t")  //[OrderLine]Description+[OrderLine]LiComment
				SEND PACKET:C103(sumDoc; [OrderLine:49]unitofMeasure:19+"\t")  //[OrderLine]UnitofMeasure
				SEND PACKET:C103(sumDoc; ""+"\t")  //[OrderLine]mfrID
				SEND PACKET:C103(sumDoc; [Order:3]shipInstruct:46+"\t")  //[Order]ShipInstruct
				
				
				SEND PACKET:C103(sumDoc; ""+"\t")
				SEND PACKET:C103(sumDoc; ""+"\t")
				SEND PACKET:C103(sumDoc; ""+"\t")
				SEND PACKET:C103(sumDoc; ""+"\t")
				SEND PACKET:C103(sumDoc; ""+"\t")
				SEND PACKET:C103(sumDoc; ""+"\t")
				//
				SEND PACKET:C103(sumDoc; ""+Storage:C1525.char.crlf)
				//
				NEXT RECORD:C51([OrderLine:49])
			End for 
			
			
			SEND PACKET:C103(myDoc; "OSA"+"\t")  //OSA
			
			SEND PACKET:C103(myDoc; Date_strYyyymmdd([Order:3]dateDocument:4)+"\t")  //[Order]DateOrdered
			SEND PACKET:C103(myDoc; Date_strYyyymmdd([Order:3]dateNeeded:5)+"\t")  //[Order]DateNeeded
			SEND PACKET:C103(myDoc; Date_strYyyymmdd([Order:3]dateCancel:53)+"\t")  //CancelDate
			SEND PACKET:C103(myDoc; "0"+"\t")  //LastVisitDate
			SEND PACKET:C103(myDoc; "0"+"\t")  //NextVisitDate
			SEND PACKET:C103(myDoc; "0"+"\t")  //OrderOpen
			SEND PACKET:C103(myDoc; "0"+"\t")  //NewCustomer
			SEND PACKET:C103(myDoc; "0"+"\t")  //NewAccount
			SEND PACKET:C103(myDoc; "0"+"\t")  //OnHold
			SEND PACKET:C103(myDoc; String:C10(vi4)+"\t")  //count of order lines
			SEND PACKET:C103(myDoc; "1"+"\t")  //[Order]TypeSale
			SEND PACKET:C103(myDoc; String:C10([Order:3]idNum:2)+"\t")  //[Order]OrderNum
			QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]customerID:2=[Order:3]customerID:1; *)
			QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]mfrID:3="Abbott")
			SEND PACKET:C103(myDoc; [MfrCustomerXRef:110]mfrAccountNum:37+"\t")  //[Order]customerID
			//
			SEND PACKET:C103(myDoc; [Order:3]billToCompany:76+"\t")  //[Order]Company
			SEND PACKET:C103(myDoc; [Order:3]billToAddress1:95+"\t")  //[Order]Address1
			SEND PACKET:C103(myDoc; [Order:3]billToAddress2:96+"\t")  //[Order]Address2
			SEND PACKET:C103(myDoc; [Order:3]billToCity:97+"\t")  //[Order]City
			SEND PACKET:C103(myDoc; [Order:3]billToState:98+"\t")  //[Order]State
			SEND PACKET:C103(myDoc; [Order:3]billToZip:99+"\t")  //[Order]Zip
			If (([Order:3]billToCountry:100="US@") | ([Order:3]billToCountry:100="United Stat@"))
				SEND PACKET:C103(myDoc; ""+"\t")  //[Order]Country
			Else 
				SEND PACKET:C103(myDoc; [Order:3]billToCountry:100+"\t")  //[Order]Country
			End if 
			SEND PACKET:C103(myDoc; [Order:3]billToPhone:93+"\t")  //[Order]Phone
			If (False:C215)
				SEND PACKET:C103(myDoc; [Order:3]company:15+"\t")  //[Order]Company
				SEND PACKET:C103(myDoc; [Order:3]address1:16+"\t")  //[Order]Address1
				SEND PACKET:C103(myDoc; [Order:3]address2:17+"\t")  //[Order]Address2
				SEND PACKET:C103(myDoc; [Order:3]city:18+"\t")  //[Order]City
				SEND PACKET:C103(myDoc; [Order:3]state:19+"\t")  //[Order]State
				SEND PACKET:C103(myDoc; [Order:3]zip:20+"\t")  //[Order]Zip
				If (([Order:3]billToCountry:100="US@") | ([Order:3]billToCountry:100="United Stat@"))
					SEND PACKET:C103(myDoc; ""+"\t")  //[Order]Country
				Else 
					SEND PACKET:C103(myDoc; [Order:3]country:21+"\t")  //[Order]Country
				End if 
				SEND PACKET:C103(myDoc; [Order:3]phone:67+"\t")  //[Order]Phone
			End if 
			
			SEND PACKET:C103(myDoc; [Order:3]attention:44+"\t")  //Available, Do you Want it
			SEND PACKET:C103(myDoc; ""+"\t")  //SalesRep
			SEND PACKET:C103(myDoc; ""+"\t")  //LocationCode
			QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]customerID:2=[Order:3]customerID:1; *)
			QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]mfrID:3="Abbot")
			SEND PACKET:C103(myDoc; [MfrCustomerXRef:110]mfrAccountNum:37+"\t")  //CompanyCode
			SEND PACKET:C103(myDoc; ""+"\t")  //UnitID
			SEND PACKET:C103(myDoc; [Order:3]customerPO:3+"\t")  //u.      Field 28  PO  Customer Purchase Order number or leave blank
			SEND PACKET:C103(myDoc; ""+"\t")  //[Order]Terms   #29  .v
			SEND PACKET:C103(myDoc; ""+"\t")  //GlobalDiscount
			SEND PACKET:C103(myDoc; [Order:3]salesNameID:10+"\t")  //PDA Rep
			SEND PACKET:C103(myDoc; ""+"\t")  //[Order]SalesName
			SEND PACKET:C103(myDoc; ""+"\t")  //Available as New or Reorder
			SEND PACKET:C103(myDoc; ""+"\t")  //Ask Bill
			SEND PACKET:C103(myDoc; ""+"\t")  //[Order]mfrID  y.      Field 35  MfgCode  Leave blank, same as first test file
			SEND PACKET:C103(myDoc; ""+"\t")  //x.      Field 34  LastUpdateTime  Same as first test file
			If ([Order:3]address1:16#[Order:3]billToAddress1:95)
				SEND PACKET:C103(myDoc; "manual"+"\t")  //ShipToNumber
				SEND PACKET:C103(myDoc; [Order:3]company:15+"\t")  //[Order]Company
				SEND PACKET:C103(myDoc; [Order:3]address1:16+"\t")  //[Order]Address1
				SEND PACKET:C103(myDoc; [Order:3]address2:17+"\t")  //[Order]Address2
				SEND PACKET:C103(myDoc; [Order:3]city:18+"\t")  //[Order]City
				SEND PACKET:C103(myDoc; [Order:3]state:19+"\t")  //[Order]State
				SEND PACKET:C103(myDoc; [Order:3]zip:20+"\t")  //[Order]Zip
				SEND PACKET:C103(myDoc; [Order:3]country:21+"\t")  //[Order]Country
				SEND PACKET:C103(myDoc; [Order:3]phone:67+"\t")  //[Order]Phone
			Else 
				SEND PACKET:C103(myDoc; ""+"\t")  //ShipToNumber
				SEND PACKET:C103(myDoc; ""+"\t")  //ShipToName
				SEND PACKET:C103(myDoc; ""+"\t")  //ShipToAddress1
				SEND PACKET:C103(myDoc; ""+"\t")  //ShipToAddress2
				SEND PACKET:C103(myDoc; ""+"\t")  //ShipToCity
				SEND PACKET:C103(myDoc; ""+"\t")  //ShipToState/Province
				SEND PACKET:C103(myDoc; ""+"\t")  //ShipToZip/Postal
				SEND PACKET:C103(myDoc; ""+"\t")  //ShipToCountry
				SEND PACKET:C103(myDoc; ""+"\t")  //ShipToPhone
			End if 
			For (vi5; 1; 12)
				SEND PACKET:C103(myDoc; String:C10(vi5+46)+"\t")  //blank
			End for 
			SEND PACKET:C103(myDoc; ""+Storage:C1525.char.crlf)  //ShipToPhone
			NEXT RECORD:C51([Order:3])
		End for 
		CLOSE DOCUMENT:C267(myDoc)
		CLOSE DOCUMENT:C267(sumDoc)
	End if 
	
	
	If (vText9="blockEmail")
		iLoText3:=$orderDocName
		iloText4:=$lineDocName
	Else 
		vtEmailSenderOverRide:="admin"
		SMTP_EmailBuild(->[RemoteUser:57])
		ARRAY TEXT:C222(atEmailAttachments; 2)
		atEmailAttachments{1}:=$orderDocName
		atEmailAttachments{2}:=$lineDocName
		SMTP_SendMsg4D(False:C215)
		
		If ((vtEmailStatusMessage="sent") | (vtEmailStatusMessage="verified"))
			vDate1:=Current date:C33
		Else 
			vDate1:=!2001-01-01!
		End if 
		
		CREATE RECORD:C68([CallReport:34])
		
		[CallReport:34]email:38:=vtEmailReceiver
		[CallReport:34]dateDocument:17:=Current date:C33
		[CallReport:34]company:42:=[RemoteUser:57]company:16
		[CallReport:34]customerID:1:=[RemoteUser:57]customerID:10
		[CallReport:34]tableNum:2:=[RemoteUser:57]tableNum:9
		[CallReport:34]attention:18:=[RemoteUser:57]userName:2
		[CallReport:34]action:15:="Email Orders and OrderLines"
		[CallReport:34]subject:14:="Orders and OrderLines"
		//
		[CallReport:34]comment:16:=vText11
		[CallReport:34]emailVerified:46:=vDate1
		If (vtEmailStatusMessage="Sent")
			[CallReport:34]emailStatus:45:="Verified"
		Else 
			[CallReport:34]emailStatus:45:=vtEmailStatusMessage
		End if 
		//
		[CallReport:34]body:47:=Document to text:C1236(document)
		
		SAVE RECORD:C53([CallReport:34])
		//DELETE DOCUMENT(document)
	End if 
End if 

