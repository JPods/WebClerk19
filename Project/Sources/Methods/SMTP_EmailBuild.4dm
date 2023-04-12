//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/13/10, 09:51:30
// ----------------------------------------------------
// Method: SMTP_EmailBuild
// Description
// Modified 02/19/2010 James W. Medlen 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20140911_0943 added vtEmailReplyTo reply to address to email

C_POINTER:C301($1; $ptCurTable)
C_BOOLEAN:C305($2; $byPassInitializing)
$byPassInitializing:=False:C215
If (Count parameters:C259>=1)
	$ptCurTable:=$1
	If (Count parameters:C259>=2)
		$byPassInitializing:=$2
	End if 
Else 
	$ptCurTable:=ptCurTable
End if 

C_TEXT:C284($sender1; $sender2; $sender3)
C_TEXT:C284(vtEmailReceiver; vtEmailSender; vtEmailSenderID; vtEmailReplyTo)  //###_jwm_### 20100219 added vtEmailSenderID
C_TEXT:C284($string255)  //### jwm ### 20130221_1530

//If ($byPassInitializing=False)
//vtEmailSender:=""
//vtEmailReceiver:=""
//vtEmailReplyTo:=""  // ### jwm ### 20140911_0943 initialize vtEmailReplyTo
//vtEmailReceiver_Tag:=""
//End if 

$optOut:=""
C_LONGINT:C283($doCustomer; $doContact; $doVendor; $doLead; $doRep)
$doCustomer:=0
$doContact:=0
$doVendor:=0
$doLead:=0
$doRep:=0

vtEmailReport:=""

If (<>viDeBugMode>0)
	ConsoleLog("Document sending email"+"\r")
End if 
Case of 
	: (vtEmailReceiver#"")
		
		vtEmailReport:="Table Service"+"\r"+"Service Record email"
		
	: ($ptCurTable=(->[Service:6]))
		REDUCE SELECTION:C351([Contact:13]; 0)
		REDUCE SELECTION:C351([Order:3]; 0)
		REDUCE SELECTION:C351([Invoice:26]; 0)
		REDUCE SELECTION:C351([Proposal:42]; 0)
		REDUCE SELECTION:C351([OrderLine:49]; 0)
		REDUCE SELECTION:C351([InvoiceLine:54]; 0)
		REDUCE SELECTION:C351([ProposalLine:43]; 0)
		$doCustomer:=2
		$custVendID:=[Service:6]customerID:1
		If ([Service:6]contactID:52#0)
			$doContact:=2
			$contactID:=[Service:6]contactID:52
		End if 
		If ([Service:6]idNumOrder:22#0)
			QUERY:C277([Order:3]; [Order:3]idNum:2=[Service:6]idNumOrder:22)
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Service:6]idNumOrder:22)
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNumOrder:29=[Service:6]idNumOrder:22)
		End if 
		If ([Service:6]idNumInvoice:23#0)
			QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=[Service:6]idNumInvoice:23)
			QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNumInvoice:1=[Service:6]idNumInvoice:23)
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNumInvoice:19=[Service:6]idNumInvoice:23)
		End if 
		If ([Service:6]idNumProposal:27#0)
			QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=[Service:6]idNumProposal:27)
			QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Service:6]idNumProposal:27)
		End if 
		If ([Service:6]email:64#"")
			vtEmailReceiver:=[Service:6]email:64
			vtEmailReport:="Table Service"+"\r"+"Service Record email"
		Else 
			vtEmailReceiver:=[Customer:2]email:81
			vtEmailReport:="Table Service"+"\r"+"Customers email"+"\r"
		End if 
		vtEmailReceiver_Tag:=[Service:6]attention:30+" <"+vtEmailReceiver+">"
		If (vtEmailSubject="")
			vtEmailSubject:=[Service:6]action:20
		End if 
		If ([Service:6]docReference:32#"")
			iLoText1:=""
			vtEmailReport:=vtEmailReport+"Execute TallyMasters "+[Service:6]docReference:32+"\r"
			Execute_TallyMaster([Service:6]docReference:32; "EmailService"; Storage:C1525.user.securityLevel; ->iLoText1)
			If (iLoText1#"")
				vtEmailBody:=iLoText1
			Else 
				vtEmailBody:=[Service:6]comment:11
			End if 
			REDUCE SELECTION:C351([TallyMaster:60]; 0)
		Else 
			vtEmailBody:=[Service:6]comment:11
		End if 
		SMTP_SentBy([Service:6]actionBy:12; [Customer:2]salesNameID:59)
		
	: ($ptCurTable=(->[RemoteUser:57]))
		vtEmailReceiver:=[RemoteUser:57]email:14
		$custVendID:=[RemoteUser:57]customerID:10
		vtEmailReport:="Table [RemoteUser]"+"\r"
		Case of 
			: ([RemoteUser:57]tableNum:9=Table:C252(->[Contact:13]))
				$doContact:=2
				$contactID:=[RemoteUser:57]contactID:11
			: ([RemoteUser:57]tableNum:9=Table:C252(->[Customer:2]))
				$doCustomer:=2
			: ([RemoteUser:57]tableNum:9=Table:C252(->[Vendor:38]))
				$doVendor:=2
			: ([RemoteUser:57]tableNum:9=Table:C252(->[Rep:8]))
				$doRep:=2
		End case 
	: ($ptCurTable=(->[CallReport:34]))
		vtEmailReport:="Table [CallReport]"+"\r"
		Case of 
			: (Position:C15(Char:C90(64); [CallReport:34]email:38)>2)
				vtEmailReceiver:=[CallReport:34]email:38
				vtEmailReceiver_Tag:=[CallReport:34]attention:18+" <"+vtEmailReceiver+">"
			: (Position:C15("&~"; [CallReport:34]email:38)>2)
				vtEmailReceiver:=[CallReport:34]email:38
				vtEmailReceiver_Tag:=[CallReport:34]attention:18+" <"+vtEmailReceiver+">"
			Else 
				vtEmailReceiver:=""
				vtEmailReceiver_Tag:=""
		End case 
		$custVendID:=[CallReport:34]customerID:1
		Case of 
			: ([CallReport:34]tableNum:2=Table:C252(->[Contact:13]))  //contacts
				$doContact:=2
			: ([CallReport:34]tableNum:2=Table:C252(->[Customer:2]))
				$doCustomer:=2
			: ([RemoteUser:57]tableNum:9=Table:C252(->[Vendor:38]))
				$doVendor:=2
			: ([RemoteUser:57]tableNum:9=Table:C252(->[Rep:8]))
				$doRep:=2
		End case 
		SMTP_SentBy([CallReport:34]actionBy:3; $sender2)
		vtEmailSubject:=[CallReport:34]subject:14
		//
		
		If (False:C215)  //([CallReport]KeyText#"")
			
		Else 
			If ([CallReport:34]emailMessage:10)
				vtEmailBody:=[CallReport:34]comment:16
			End if 
		End if 
	Else 
		Case of 
			: ((vtEmailReceiver#"") & (vtEmailSenderID#""))  // ### jwm ### 20190705_2316
				SMTP_SentBy(vtEmailSenderID)
				//
			: (($ptCurTable=(->[Order:3])) & ((Position:C15("&~"; [Order:3]email:82)>0) | (Position:C15(Char:C90(64); [Order:3]email:82)>0)))  //test first
				vtEmailReceiver:=[Order:3]email:82
				vtEmailReceiver_Tag:=[Order:3]attention:44+"<"+vtEmailReceiver+">"
				SMTP_SentBy([Order:3]salesNameID:10; [Order:3]takenBy:36; [Customer:2]salesNameID:59)
				vtEmailPath:=[Order:3]docReference:65
				$doCustomer:=2
				$custVendID:=[Order:3]customerID:1
				vtEmailReport:="Table [[Order]]"+"\r"
			: (($ptCurTable=(->[Invoice:26])) & ((Position:C15("&~"; [Invoice:26]email:76)>0) | (Position:C15(Char:C90(64); [Invoice:26]email:76)>0)))  //test first
				vtEmailReceiver:=[Invoice:26]email:76
				vtEmailReceiver_Tag:=[Invoice:26]attention:38+"<"+vtEmailReceiver+">"
				SMTP_SentBy([Invoice:26]salesNameID:23; [Invoice:26]producedBy:65; [Customer:2]salesNameID:59)
				$doCustomer:=2
				$custVendID:=[Invoice:26]customerID:3
				vtEmailReport:="Table [Invoice]"+"\r"
			: (($ptCurTable=(->[Proposal:42])) & ((Position:C15("&~"; [Proposal:42]email:68)>0) | (Position:C15(Char:C90(64); [Proposal:42]email:68)>0)))  //test first
				vtEmailReceiver:=[Proposal:42]email:68
				vtEmailReceiver_Tag:=[Proposal:42]attention:37+"<"+vtEmailReceiver+">"
				SMTP_SentBy([Proposal:42]salesNameID:9; [Customer:2]salesNameID:59)
				$doCustomer:=2
				$custVendID:=[Proposal:42]customerID:1
				vtEmailReport:="Table [Proposal]"+"\r"
			: (($ptCurTable=(->[PO:39])) & (Position:C15("&~"; [PO:39]email:64)>0))  //test first
				vtEmailReceiver:=[PO:39]email:64
				vtEmailReceiver_Tag:=[PO:39]attention:26+"<"+vtEmailReceiver+">"
				SMTP_SentBy([PO:39]buyer:7; [Vendor:38]buyer:56; [PO:39]salesNameID:35)
				$custVendID:=[PO:39]vendorID:1
				$doVendor:=2
				$custVendID:=[PO:39]vendorID:1
				vtEmailReport:="Table [PO]"+"\r"
			: (($ptCurTable=(->[Customer:2])) | ($ptCurTable=(->[Order:3])) | ($ptCurTable=(->[Proposal:42])) | ($ptCurTable=(->[Invoice:26])))  //test second
				$doCustomer:=1
				vtEmailReport:="Table [Customer]"+"\r"
			: ($ptCurTable=(->[Contact:13]))
				$doContact:=1
				vtEmailReport:="Table [Contact]"+"\r"
			: (($ptCurTable=(->[Vendor:38])) | ($ptCurTable=(->[PO:39])) | ($ptCurTable=(->[POLine:40])))
				$doVendor:=1
			: ($ptCurTable=(->[Rep:8]))
				vtEmailReport:="Table [Rep]"+"\r"
				$doRepr:=1
			: ($ptCurTable=(->[RepContact:10]))
				$custVendID:=[RepContact:10]repID:1
				vtEmailReport:="Table [RepContact]"+"\r"
				$doRep:=2
		End case 
End case 

If ($doContact>0)
	If ($doContact>1)
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=$contactID)
	End if 
	If ((vHere<2) & ([Contact:13]optOut:51#""))
		$optOut:="Out"
	End if 
	If (vtEmailReceiver="")
		vtEmailReceiver:=[Contact:13]email:35
		vtEmailReceiver_Tag:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4+" <"+vtEmailReceiver+">"
	End if 
	If (vtEmailSenderID="")
		SMTP_SentBy([Contact:13]salesNameID:39; "email")
	End if 
	$custVendID:=[Contact:13]customerID:1
	$doCustomer:=2
End if 
If ($doCustomer>0)
	If ($doCustomer>1)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=$custVendID)
	End if 
	If ((vHere<2) & ([Customer:2]optOut:98#""))
		$optOut:="Out"
	End if 
	If (vtEmailReceiver="")
		vtEmailReceiver:=[Customer:2]email:81
		vtEmailReceiver_Tag:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23+" <"+vtEmailReceiver+">"
	End if 
	If (vtEmailSender="")
		SMTP_SentBy([Customer:2]salesNameID:59; "email")
	End if 
End if 

If ($doVendor>0)
	If ($doVendor>1)
		QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=$custVendID)
	End if 
	If ((vHere<2) & ([Vendor:38]optOut:81#""))
		$optOut:="Out"
	End if 
	If (vtEmailReceiver="")
		vtEmailReceiver:=[Vendor:38]email:59
		vtEmailReceiver_Tag:=[Vendor:38]nameFirst:85+" "+[Vendor:38]nameLast:86+" <"+vtEmailReceiver+">"
	End if 
	If (vtEmailSender="")
		SMTP_SentBy([Vendor:38]buyer:56; "email")
	End if 
End if 
If ($doRep>0)
	If ($doRep>1)
		QUERY:C277([Rep:8]; [Rep:8]repID:1=$custVendID)
	End if 
	If ((vHere<2) & ([Rep:8]active:21=False:C215))
		$optOut:="Out"
	End if 
	If (vtEmailReceiver="")
		vtEmailReceiver:=[Rep:8]email:22
		vtEmailReceiver_Tag:=[Rep:8]nameFirst:25+" "+[Rep:8]nameLast:27+" <"+vtEmailReceiver+">"
	End if 
End if 

If (<>viDeBugMode>0)
	ConsoleLog("vtEmailReceiver: "+vtEmailReceiver+", Tag: "+vtEmailReceiver_Tag)
End if 

If (vtEmailSender="")
	SMTP_SentBy(Current user:C182; "email")
End if 
If (<>viDeBugMode>0)
	ConsoleLog("vtEmailSender: "+vtEmailSender)
End if 

C_TEXT:C284(vtEmailBody; vtEmailSubject; vtEmailPath; vtEmailSubject)
If (Record number:C243([UserReport:46])>-1)  //Print Defined Report
	If (vtEmailBody="")
		vtEmailBody:=[UserReport:46]template:7
		If (<>viDeBugMode>0)
			ConsoleLog("[UserReport]DocumentLoc_20: "+Substring:C12(vtEmailBody; 1; 20))
		End if 
	End if 
	If (vtEmailSubject="")
		vtEmailSubject:=[UserReport:46]name:2
		If (<>viDeBugMode>0)
			ConsoleLog("[UserReport]Name: "+vtEmailSubject)
		End if 
	End if 
	If (vtEmailPath="")
		vtEmailPath:=""
	End if 
	If ([UserReport:46]scriptLoop:34#"")
		doAlert:=False:C215
		vResponse:=""
		If (<>viDeBugMode>0)
			ConsoleLog("[UserReport]ScriptLoop_20: "+Substring:C12([UserReport:46]scriptLoop:34; 1; 20))
		End if 
		ExecuteText(0; [UserReport:46]scriptLoop:34)
		If (<>viDeBugMode>0)
			ConsoleLog("vResponse: "+vResponse)
		End if 
		doAlert:=False:C215
	End if 
End if 

If (<>viDeBugMode>0)
	ConsoleLog(vtEmailReport+"\r")
End if 
vtEmailReport:=""

C_TEXT:C284(vtEmailSenderOverRide_Tag; vtEmailSenderOverRide; vtEmailSenderID)
//should already be accomplished in SMTP_SentBy above
If (vtEmailSenderOverRide#"")
	vtEmailSender:=vtEmailSenderOverRide
	eSender_Tag:=vtEmailSenderOverRide_Tag
	$string255:=Substring:C12(vtEmailSenderOverRide; 1; 255)  //### jwm ### 20130221_1533
	SMTP_SentBy($string255; "email")  //### jwm ### 20120118_0520 test to eliminate range checking error
	If (<>viDeBugMode>0)
		ConsoleLog("vtEmailSenderOverRide: "+vtEmailSenderOverRide)
	End if 
End if 

//###_jwm_### 20100219 this allows you to designate the sender account
If (vtEmailSenderID#"")
	SMTP_SentBy(vtEmailSenderID; "email")
End if 

//ARRAY TEXT(aBoundaryData;0)
//ARRAY TEXT(aBoundaryType;0)
iLoText1:=""
If ($optOut="")
	SET BLOB SIZE:C606(blobPageOut; 0)  //must be initialized or it will accumulate to output
	vtEmailSubject:=TagsToText(vtEmailSubject)
	If (BLOB size:C605(blobPageOut)>0)
		vtEmailSubject:=BLOB to text:C555(blobPageOut; UTF8 text without length:K22:17)  //  -> Subject
	End if 
	SET BLOB SIZE:C606(blobPageOut; 0)  //must be initialized
	vtEmailBody:=TagsToText(vtEmailBody)
	//SET BLOB SIZE(blobPageOut;0)//must be initialized 
	If (BLOB size:C605(blobPageOut)>0)
		vtEmailBody:=BLOB to text:C555(blobPageOut; UTF8 text without length:K22:17)  //  -> vtEmailBody
	End if 
	SET BLOB SIZE:C606(blobPageOut; 0)
	// >vtEmailPath:=TagsToText (>vtEmailPath)
	If ((vtEmailSubject="") | (vtEmailSubject="email"))
		vtEmailSubject:=[UserReport:46]name:2
	End if 
Else 
	vtEmailReceiver:=""
End if 

