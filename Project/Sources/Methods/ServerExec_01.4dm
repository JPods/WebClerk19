//%attributes = {}
// Script Bad Freight On Server 20170118
// FOB changed to Prepaid
// v14 verified

//<declarations>
//==================================
// Type variables
//==================================

// CommentProcess;ProducedBy;Profile4;TimesPrinted
C_BOOLEAN:C305(allowAlerts_boo)
C_LONGINT:C283(vi1; vi2; viReady; vlMyProcess; vlProcessID; vlTestID)
C_TEXT:C284(vtComment; vtCR; vtGroupID; vtMyDate; vtMyInvoices; vtMyName; vtMyText; vtMyTime)
C_TEXT:C284(vtStatus)

//==================================
// Initialize variables
//==================================

//allowAlerts_boo:=False
vi1:=0
vi2:=0
viReady:=0
vlMyProcess:=0
vlProcessID:=0
vlTestID:=0
vtComment:=""
vtCR:=""
vtGroupID:=""
vtMyDate:=""
vtMyInvoices:=""
vtMyName:=""
vtMyText:=""
vtMyTime:=""
vtStatus:=""
//</declarations>

ARRAY LONGINT:C221(alRecords; 0)

vlMyProcess:=Current process:C322
viReady:=0
vtStatus:=""

Open window:C153(100; 200; 500; 300; 5; "Status")
ERASE WINDOW:C160
GOTO XY:C161(3; 3)

MESSAGE:C88("Searching for Freight Errors...")

vlProcessID:=Execute on server:C373("ExecuteText"; 64*1024; String:C10(Count user processes:C343)+"-OnServer"; 0; [TallyMaster:60]build:6; *)
vlTestID:=Abs:C99(vlProcessID)
DELAY PROCESS:C323(Current process:C322; 15)  // delay for server startup

Repeat 
	DELAY PROCESS:C323(Current process:C322; 300)
	GET PROCESS VARIABLE:C371($spProcessID; spErrCode; spErrCode)
	If (Undefined:C82(spErrCode))
		// Note: if the stored procedure has not initialized its own instance
		// of the variable spErrCode, we may be returned an undefined variable
		spErrCode:=1
	End if 
Until (spErrCode<=0)


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
SET PROCESS VARIABLE:C370(-vlTestID; vlMyProcess; vlMyProcess)

ERASE WINDOW:C160
GOTO XY:C161(3; 3)
MESSAGE:C88("Search Complete")
CLOSE WINDOW:C154

vi2:=Records in selection:C76([Invoice:26])
If (allowAlerts_boo)
	ALERT:C41("Records In Selection "+String:C10(vi2))
End if 
If (vi2=0)
	If (allowAlerts_boo)
		ALERT:C41("No Invoices Found With Bad Freight")
	End if 
	vtMyInvoices:="No Invoices Found With Bad Freight"+vtCR
	vtGroupID:="FRSQ"
Else 
	vtMyInvoices:="Bad Freight Invoices"+vtCR
	vtGroupID:="FRSQ Error"
	FIRST RECORD:C50([Invoice:26])
	For (vi1; 1; vi2)
		If ([Invoice:26]profile4:83#"@ERR@")
			[Invoice:26]profile4:83:=[Invoice:26]profile4:83+"ERR "
		End if 
		[Invoice:26]timesPrinted:51:=[Invoice:26]timesPrinted:51+10
		[Invoice:26]producedBy:65:="Bad Freight"
		vtMyInvoices:=vtMyInvoices+String:C10([Invoice:26]invoiceNum:2)+vtCR
		
		vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
		vtMyDate:=String:C10(Current date:C33; 4)
		vtMyText:="Invoice "+String:C10([Invoice:26]invoiceNum:2)+" Had Bad Freight "
		vtMyName:=(Current user:C182)
		vtComment:=vtMyDate+": "+vtMyTime+"; "+vtMyText+vtMyName+Char:C90(13)
		[Invoice:26]commentProcess:73:=Insert string:C231([Invoice:26]commentProcess:73; vtComment; 0)
		
		SAVE RECORD:C53([Invoice:26])
		NEXT RECORD:C51([Invoice:26])
	End for 
End if 

vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
vtMyDate:=String:C10(Current date:C33; 4)
vtMyText:=" Bad Freight Executed By "
vtMyName:=(Current user:C182)
vtComment:=vtMyText+vtMyName+" - "+vtMyDate+": "+vtMyTime+vtCR+vtCR+vtMyInvoices
ELog_NewRecord(0; vtGroupID; vtComment)
If (allowAlerts_boo)
	If (Records in selection:C76([Invoice:26])>0)
		ProcessTableOpen(Table:C252(->[Invoice:26]))
	Else 
		ALERT:C41("No Freight Errors Found")
	End if 
End if 

// ==============================================
// ##############################################
// ==============================================

//<declarations>
//==================================
// Type variables
//==================================

C_LONGINT:C283(vi2; vi3; vi4; viReady; vlMyProcess)
C_TEXT:C284(vtCR; vtStatus)

//==================================
// Initialize variables
//==================================

vi2:=0
vi3:=0
vi4:=0
viReady:=0
vlMyProcess:=0
vtCR:=""
vtStatus:=""
//</declarations>

//Script Bad Freight 20150520
ARRAY LONGINT:C221(alRecords; 0)
viReady:=0
vlMyProcess:=0
vtStatus:=""
vtCR:=Char:C90(13)

QUERY:C277([Invoice:26]; [Invoice:26]dateInvoiced:35>=(Current date:C33-30); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]dateInvoiced:35<=(Current date:C33-1); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]upsBillingOption:81="Bill@"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]shipTotal:20>0; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]profile4:83#"@ERR@"; *)
QUERY:C277([Invoice:26])

CREATE SET:C116([Invoice:26]; "BadFreight")

//Srch_SetBefore ("Union")
QUERY:C277([Invoice:26]; [Invoice:26]dateInvoiced:35>=(Current date:C33-30); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]dateInvoiced:35<=(Current date:C33-1); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]upsBillingOption:81="Bill@UPS"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]shipVia:5#"UPS@"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]terms:24#"VOID@"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]profile4:83#"@ERR@"; *)
QUERY:C277([Invoice:26])
//Srch_SetEnd ("Union")

CREATE SET:C116([Invoice:26]; "temp")
UNION:C120("BadFreight"; "temp"; "BadFreight")
CLEAR SET:C117("temp")

//Srch_SetBefore ("Union")
QUERY:C277([Invoice:26]; [Invoice:26]dateInvoiced:35>=(Current date:C33-30); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]dateInvoiced:35<=(Current date:C33-1); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]upsBillingOption:81="Bill@DHL"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]shipVia:5#"DHL@"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]terms:24#"VOID@"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]profile4:83#"@ERR@"; *)
QUERY:C277([Invoice:26])
//Srch_SetEnd ("Union")

CREATE SET:C116([Invoice:26]; "temp")
UNION:C120("BadFreight"; "temp"; "BadFreight")
CLEAR SET:C117("temp")

//Srch_SetBefore ("Union")
QUERY:C277([Invoice:26]; [Invoice:26]dateInvoiced:35>=(Current date:C33-30); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]dateInvoiced:35<=(Current date:C33-1); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]upsBillingOption:81="Prepaid"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]shipTotal:20#0; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]terms:24#"VOID@"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]profile4:83#"@ERR@"; *)
QUERY:C277([Invoice:26])
//Srch_SetEnd ("Union")

CREATE SET:C116([Invoice:26]; "temp")
UNION:C120("BadFreight"; "temp"; "BadFreight")
CLEAR SET:C117("temp")

QUERY:C277([Invoice:26]; [Invoice:26]dateInvoiced:35>=(Current date:C33-30); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]dateInvoiced:35<=(Current date:C33-1); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]upsBillingOption:81="Prepaid & Add"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]shipTotal:20<=0; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]shipVia:5#"Pick Up@"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]shipVia:5#"Manual@"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]customerID:3#"8202"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]customerID:3#"FD100048"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]amount:14>=0; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]total:18>=0; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]terms:24#"VOID@"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]profile4:83#"@ERR@"; *)
QUERY:C277([Invoice:26])
// Check InvoiceLines for Item Freight
QUERY SELECTION BY FORMULA:C207([Invoice:26]; (([InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2) & ([InvoiceLine:54]itemNum:4#"Freight")))

CREATE SET:C116([Invoice:26]; "temp")
UNION:C120("BadFreight"; "temp"; "BadFreight")
CLEAR SET:C117("temp")

//Srch_SetBefore ("Union")
// Prepaid Invoice No Freight Calculation
QUERY:C277([Invoice:26]; [Invoice:26]dateInvoiced:35>=(Current date:C33-30); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]dateInvoiced:35<=(Current date:C33-1); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]upsBillingOption:81="Prepaid"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]shipTotal:20=0; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]shipFreightCost:15=0; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]shipAdjustments:17=0; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]shipMiscCosts:16=0; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]terms:24#"VOID@"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]profile4:83#"@ERR@"; *)
QUERY:C277([Invoice:26])
//Srch_SetEnd ("Union")

CREATE SET:C116([Invoice:26]; "temp")
UNION:C120("BadFreight"; "temp"; "BadFreight")
CLEAR SET:C117("temp")

//Srch_SetBefore ("Union")
CREATE EMPTY SET:C140([Invoice:26]; "MyInvoices")

QUERY:C277([Invoice:26]; [Invoice:26]dateInvoiced:35>=(Current date:C33-30); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]dateInvoiced:35<=(Current date:C33-1); *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]shipVia:5="ups world ease@"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]terms:24#"VOID@"; *)
QUERY:C277([Invoice:26];  & ; [Invoice:26]profile4:83#"@ERR@"; *)
QUERY:C277([Invoice:26])

vi4:=Records in selection:C76([Invoice:26])
FIRST RECORD:C50([Invoice:26])

For (vi3; 1; vi4)
	QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]itemNum:4="Brokerage"; *)
	QUERY:C277([InvoiceLine:54];  | ; [InvoiceLine:54]itemNum:4="GST"; *)
	QUERY:C277([InvoiceLine:54];  & ; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2; *)
	QUERY:C277([InvoiceLine:54])
	
	If (Records in selection:C76([InvoiceLine:54])=0)
		ADD TO SET:C119([Invoice:26]; "MyInvoices")
	End if 
	
	NEXT RECORD:C51([Invoice:26])
End for 
USE SET:C118("MyInvoices")

//Create Set([Invoice];"temp")
UNION:C120("BadFreight"; "MyInvoices"; "BadFreight")
CLEAR SET:C117("MyInvoices")

USE SET:C118("BadFreight")
CLEAR SET:C117("BadFreight")

//Srch_SetEnd ("Union")

//Modify Selection([Invoice])

SELECTION TO ARRAY:C260([Invoice:26]; alRecords)
viReady:=1
vi2:=0
While ((vlMyProcess=0) & (vi2<1800))  //timeout = 1/2 hour
	vi2:=vi2+1
	DELAY PROCESS:C323(Current process:C322; 60)
End while 
