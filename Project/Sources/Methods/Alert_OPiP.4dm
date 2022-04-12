//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/14/18, 15:50:35
// ----------------------------------------------------
// Method: Alert_OPiP
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ### jwm ### 20190918_1407 add default parameter to toggle this

C_LONGINT:C283($viOnlyMessage)
C_LONGINT:C283(viAlertTimes; <>viAlertMax)
C_BOOLEAN:C305($vbAlert)
If (<>viAlertMax=0)
	DefaultSetupsCreate("<>viAlertMax"; "3"; "Is longint"; "Alerts"; ""; "Sets the maximum number of times an customer/vendor alert message will be repeated in a process.")
	<>viAlertMax:=3
End if 

$vbAlert:=False:C215
$vtMessage:=""
$vtLine:="_"*80

// method 3 simple alert
Case of 
	: (ptCurTable=->[Order:3])
		$vtMessage:=[Order:3]alertMessage:80
		
	: (ptCurTable=->[Invoice:26])
		$vtMessage:=[Invoice:26]alertMessage:74
		
	: (ptCurTable=->[Proposal:42])
		$vtMessage:=[Proposal:42]alertMessage:65
		
	: (ptCurTable=->[PO:39])
		$vtMessage:=[PO:39]alertMessage:62
		
	: (ptCurTable=->[Customer:2])
		$vtMessage:=[Customer:2]alertMessage:79
		
	: (ptCurTable=->[Contact:13])
		$vtMessage:=[Contact:13]alertMessage:66
		
	: (ptCurTable=->[Vendor:38])
		$vtMessage:=[Vendor:38]alertMessage:70
		
End case 

If ($vtMessage#"")
	If (allowAlerts_boo)
		ALERT:C41($vtMessage)
	Else 
		ConsoleMessage($vtMessage)
	End if 
End if 

If (<>viDebugMode>410)
	ConsoleMessage("Alert: "+$vtMessage)
End if 
$vtMessage:=""


If (False:C215)  // method 2 complex alert
	Case of 
		: (ptCurTable=->[Order:3])
			
			$vtHeader:=$vtLine+"\r"+"ORDER: "+String:C10([Order:3]orderNum:2; "0000-0000")+"\r\r"+$vtLine+"\r"
			
			If ([Order:3]alertMessage:80#"")
				$vbAlert:=True:C214
				$vtMessage:=$vtMessage+"ORDERS ALERT:\r\r"
				$vtMessage:=$vtMessage+[Order:3]alertMessage:80+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Customer:2]alertMessage:79#"")
				$vtMessage:=$vtMessage+"CUSTOMERS ALERT:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]alertMessage:79+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Order:3]shipInstruct:46#"")
				$vtMessage:=$vtMessage+"ORDERS SHIPPING INSTRUCTIONS:\r\r"
				$vtMessage:=$vtMessage+[Order:3]shipInstruct:46+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Customer:2]shipInstruct:24#"")
				$vtMessage:=$vtMessage+"CUSTOMERS SHIPPING INSTRUCTIONS:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]shipInstruct:24+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Order:3]commentProcess:12#"")
				$vtMessage:=$vtMessage+"ORDERS COMMENT PROCESS:\r\r"
				$vtMessage:=$vtMessage+[Order:3]commentProcess:12+"\r\r"+$vtLine+"\r"
			End if 
			
		: (ptCurTable=->[Invoice:26])
			
			$vtHeader:=$vtLine+"\r"+"INVOICE: "+String:C10([Invoice:26]invoiceNum:2; "0000-0000")+"\r\r"+$vtLine+"\r"
			
			If ([Invoice:26]alertMessage:74#"")
				$vbAlert:=True:C214
				$vtMessage:=$vtMessage+"INVOICES ALERT:\r\r"
				$vtMessage:=$vtMessage+[Invoice:26]alertMessage:74+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Customer:2]alertMessage:79#"")
				$vtMessage:=$vtMessage+"CUSTOMERS ALERT:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]alertMessage:79+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Invoice:26]shipInstruct:40#"")
				$vtMessage:=$vtMessage+"INVOICES SHIPPING INSTRUCTIONS:\r\r"
				$vtMessage:=$vtMessage+[Invoice:26]shipInstruct:40+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Customer:2]shipInstruct:24#"")
				$vtMessage:=$vtMessage+"CUSTOMERS SHIPPING INSTRUCTIONS:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]shipInstruct:24+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Invoice:26]commentProcess:73#"")
				$vtMessage:=$vtMessage+"INVOICES COMMENT PROCESS:\r\r"
				$vtMessage:=$vtMessage+[Invoice:26]commentProcess:73+"\r\r"+$vtLine+"\r"
			End if 
			
		: (ptCurTable=->[Proposal:42])
			
			$vtHeader:=$vtLine+"\r"+"PROPOSALS: "+String:C10([Proposal:42]proposalNum:5; "0000-0000")+"\r\r"+$vtLine+"\r"
			
			
			If ([Proposal:42]alertMessage:65#"")
				$vbAlert:=True:C214
				$vtMessage:=$vtMessage+"PROPOSALS ALERT:\r\r"
				$vtMessage:=$vtMessage+[Proposal:42]alertMessage:65+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Customer:2]alertMessage:79#"")
				$vtMessage:=$vtMessage+"CUSTOMERS ALERT:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]alertMessage:79+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Proposal:42]shipInstruct:35#"")
				$vtMessage:=$vtMessage+"PROPOSALS SHIPPING INSTRUCTIONS:\r\r"
				$vtMessage:=$vtMessage+[Proposal:42]shipInstruct:35+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Customer:2]shipInstruct:24#"")
				$vtMessage:=$vtMessage+"CUSTOMERS SHIPPING INSTRUCTIONS:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]shipInstruct:24+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Proposal:42]commentProcess:64#"")
				$vtMessage:=$vtMessage+"PROPOSALS COMMENT PROCESS:\r\r"
				$vtMessage:=$vtMessage+[Proposal:42]commentProcess:64+"\r\r"+$vtLine+"\r"
			End if 
			
		: (ptCurTable=->[PO:39])
			
			$vtHeader:=$vtLine+"\r"+"PO: "+String:C10([PO:39]poNum:5; "0000-0000")+"\r\r"+$vtLine+"\r"
			
			If ([PO:39]alertMessage:62#"")
				$vbAlert:=True:C214
				$vtMessage:=$vtMessage+"POs ALERT:\r\r"
				$vtMessage:=$vtMessage+[PO:39]alertMessage:62+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Customer:2]alertMessage:79#"")
				$vtMessage:=$vtMessage+"CUSTOMERS ALERT:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]alertMessage:79+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([PO:39]shipInstruct:31#"")
				$vtMessage:=$vtMessage+"POs SHIPPING INSTRUCTIONS:\r\r"
				$vtMessage:=$vtMessage+[PO:39]shipInstruct:31+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Customer:2]shipInstruct:24#"")
				$vtMessage:=$vtMessage+"CUSTOMERS SHIPPING INSTRUCTIONS:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]shipInstruct:24+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([PO:39]commentProcess:63#"")
				$vtMessage:=$vtMessage+"POs COMMENT PROCESS:\r\r"
				$vtMessage:=$vtMessage+[PO:39]commentProcess:63+"\r\r"+$vtLine+"\r"
			End if 
			
		: (ptCurTable=->[Customer:2])
			
			$vtHeader:=$vtLine+"\r"+"CUSTOMER:"+"\t"+"ID: "+[Customer:2]customerID:1+"\t"+[Customer:2]company:2+"\r\r"+$vtLine+"\r"
			
			If ([Customer:2]alertMessage:79#"")
				$vbAlert:=True:C214
				$vtMessage:=$vtMessage+"CUSTOMERS ALERT:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]alertMessage:79+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Customer:2]shipInstruct:24#"")
				$vtMessage:=$vtMessage+"CUSTOMERS SHIPPING INSTRUCTIONS:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]shipInstruct:24+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Customer:2]comment:15#"")
				$vtMessage:=$vtMessage+"CUSTOMERS COMMENT:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]shipInstruct:24+"\r\r"+$vtLine+"\r"
			End if 
			
		: (ptCurTable=->[Contact:13])
			$vbAlert:=True:C214
			$vtHeader:=$vtLine+"\r"+"Contact:\t"+"ID: "+String:C10([Contact:13]idNum:28)+"\t"+[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4+"\r\r"+$vtLine+"\r"
			
			If ([Customer:2]alertMessage:79#"")
				$vtMessage:=$vtMessage+"CUSTOMERS ALERT:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]alertMessage:79+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Contact:13]alertMessage:66#"")
				$vtMessage:=$vtMessage+"CONTACTS ALERT MESSAGE:\r\r"
				$vtMessage:=$vtMessage+[Contact:13]alertMessage:66+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Customer:2]shipInstruct:24#"")
				$vtMessage:=$vtMessage+"CUSTOMERS SHIPPING INSTRUCTIONS:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]shipInstruct:24+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Contact:13]comment:29#"")
				$vtMessage:=$vtMessage+"CONTACTS COMMENT:\r\r"
				$vtMessage:=$vtMessage+[PO:39]commentProcess:63+"\r\r"+$vtLine+"\r"
			End if 
			
		: (ptCurTable=->[Vendor:38])
			
			$vtHeader:=$vtLine+"\r"+"Vendor:\t"+"ID: "+[Vendor:38]vendorID:1+"\t"+[Vendor:38]company:2+"\r\r"+$vtLine+"\r"
			
			If ([Vendor:38]alertMessage:70#"")
				$vbAlert:=True:C214
				$vtMessage:=$vtMessage+"VENDORS ALERT:\r\r"
				$vtMessage:=$vtMessage+[Vendor:38]alertMessage:70+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Vendor:38]shipInstruct:64#"")
				$vtMessage:=$vtMessage+"VENDORS SHIPPING INSTRUCTIONS:\r\r"
				$vtMessage:=$vtMessage+[Customer:2]shipInstruct:24+"\r\r"+$vtLine+"\r"
			End if 
			
			If ([Vendor:38]comment:54#"")
				$vtMessage:=$vtMessage+"VENDORS COMMENT:\r\r"
				$vtMessage:=$vtMessage+[Vendor:38]shipInstruct:64+"\r\r"+$vtLine+"\r"
			End if 
			
	End case 
	
	If (($vtMessage#"") & ($vbAlert=True:C214))
		
		// add header
		$vtMessage:=$vtHeader+$vtMessage
		
		If (allowAlerts_boo)
			ConsoleMessage($vtMessage)
		Else 
			ConsoleMessage($vtMessage)
		End if 
	End if 
	If (<>viDebugMode>410)
		ConsoleMessage("Alert_OPiP: "+$vtMessage)
	End if 
	$vtMessage:=""
	
	
	//WindowComment ("Alerts & Shipping Instructions";$vtMessage)
	
	//Else 
	
End if 

If (False:C215)  // method 1 original alert
	
	// Modified by: Bill James (2018-06-08T00:00:00)cleanup 
	$vtMessage:=""
	If ([Customer:2]alertMessage:79#"")  //&((ptCurFile=([Control]))|(ptCurFile=([Customer]))))"
		If (<>aLastRecNum{2}#Record number:C243([Customer:2]))
			viAlertTimes:=1
		Else 
			viAlertTimes:=viAlertTimes+1
		End if 
		If (viAlertTimes<=<>viAlertMax)
			$vtMessage:=[Customer:2]alertMessage:79
		End if 
	End if 
	If (([Vendor:38]alertMessage:70#"") & ((ptCurTable=(->[PO:39])) | (ptCurTable=(->[Vendor:38]))))
		If (<>aLastRecNum{Table:C252(->[Vendor:38])}#Record number:C243([Vendor:38]))
			viAlertTimes:=1
		Else 
			viAlertTimes:=viAlertTimes+1
		End if 
		If (viAlertTimes<=<>viAlertMax)
			$vtMessage:=[Vendor:38]alertMessage:70
		End if 
	End if 
	If ([Order:3]alertMessage:80#"")
		If ((ptCurTable=(->[Control:1])) | (ptCurTable=(->[Order:3])))
			If (viAlertTimes<=<>viAlertMax)
				viAlertTimes:=viAlertTimes+1
				$vtMessage:=$vtMessage+(Num:C11($vtMessage#"")*("\r"+"\r"+"#########"+"\r"+"\r"))+"Order: "+[Order:3]alertMessage:80
			End if 
		End if 
	End if 
	If (([Invoice:26]alertMessage:74#"") & (ptCurTable=(->[Invoice:26])))
		$vtMessage:=$vtMessage+(Num:C11($vtMessage#"")*("\r"+"\r"+"#########"+"\r"+"\r"))+"Invoice: "+[Invoice:26]alertMessage:74
	End if 
	If (([Proposal:42]alertMessage:65#"") & (ptCurTable=(->[Proposal:42])))
		$vtMessage:=$vtMessage+(Num:C11($vtMessage#"")*("\r"+"\r"+"#########"+"\r"+"\r"))+"Proposal: "+[Proposal:42]alertMessage:65
	End if 
	If (([PO:39]alertMessage:62#"") & (ptCurTable=(->[PO:39])))
		$vtMessage:=$vtMessage+(Num:C11($vtMessage#"")*("\r"+"\r"+"#########"+"\r"+"\r"))+"PO: "+[PO:39]alertMessage:62
		
	End if 
	
	ALERT:C41($vtMessage)
	
End if 
