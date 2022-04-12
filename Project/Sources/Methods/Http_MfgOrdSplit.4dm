//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
$c:=$1
$suffix:=""
$doThis:=0
vResponse:=""
//zttp_UserGet 
$doPage:=WC_DoPage("Error.html"; "")
$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
$jitpageone:=WCapi_GetParameter("jitpageone"; "")
// /Sales_MfrOrder?recordID=_jit_3_2jj&jitpageone=OrdersSplitList.html&Doc2Print=UserReportNametoPrintEmptyIfNoPrint

$doc2Print:=WCapi_GetParameter("Doc2Print"; "")

If ($recordID>-1)
	QUERY:C277([Order:3]; [Order:3]orderNum:2=$recordID)
	If ((Records in selection:C76([Order:3])=1) & (([Order:3]customerid:1=[Customer:2]customerID:1) | (vWccSecurity>0)))
		If ([Order:3]customerid:1#[Customer:2]customerID:1)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerid:1)
		End if 
		//If ([Order]JobID=0) in Ord2MfgOrd
		[Order:3]projectNum:50:=[Order:3]orderNum:2
		If ([Order:3]orderNum:2>0)
			SAVE RECORD:C53([Order:3])
		Else 
			[EventLog:75]areYouHuman:36:="zeroOrder"
			EventLogsMessage("Trying to save a zero Order Http_MfrOrdSplit.")
		End if 
		//End if 
		booAccept:=True:C214
		OrdLnFillRays
		Ord2MfgOrd
		FIRST RECORD:C50([Order:3])
		//TRACE
		If ($doc2Print#"")
			QUERY:C277([UserReport:46]; [UserReport:46]name:2=$doc2Print)
			If (Records in selection:C76([UserReport:46])#1)
				vResponse:="To print, there must be one and only one UserReport: "+$doc2Print
			Else 
				CREATE SET:C116([Order:3]; "P_Current")
				Prnt_ReportOpts
				USE SET:C118("P_Current")
				CLEAR SET:C117("P_Current")
			End if 
		End if 
		//QUERY([Customer];[Customer]customerID=[Order]customerID)
		
		$doPage:=WC_DoPage("OrdersSplitList.html"; $jitPageOne)
	End if 
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
vResponse:=""
vcustomerID:=""