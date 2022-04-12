//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
$c:=$1
$suffix:=""
$doThis:=0
vResponse:="No records submitted"
TRACE:C157
//zttp_UserGet 
$doPage:=WC_DoPage("Error.html"; "")
$jitpageone:=WCapi_GetParameter("jitpageone"; "")
zzz:=1  //should this be jitPageList??
$doc2Print:=WCapi_GetParameter("Doc2Print"; "")
//
$custID:=WCapi_GetParameter("customerID"; "")
$jobNum:=WCapi_GetParameter("JobNum"; "")
If ($jitpageone="")
	$jitpageone:="OrderLinesList.html"
End if 
//
C_LONGINT:C283($jobLong)
$jobLong:=Num:C11($jobNum)
If ($jobLong#0)
	QUERY:C277([Order:3]; [Order:3]projectNum:50=$jobLong; *)
	If ($strDateOrdered#"")
		QUERY:C277([Order:3];  & [Order:3]dateOrdered:4=Date:C102($strDateOrdered); *)
	End if 
	QUERY:C277([Order:3];  & [Order:3]customerID:1=$custID; *)
	Case of 
		: ([Customer:2]customerID:1=$custID)
			QUERY:C277([Order:3])
		: (vWccTableNum=Table:C252(->[Rep:8]))
			QUERY:C277([Order:3];  & [Order:3]repID:8=[Rep:8]repID:1)
		: (vWccTableNum=Table:C252(->[Employee:19]))
			//GOTO RECORD([Employee];vWccPrimeRec)
			QUERY:C277([Order:3];  & [Order:3]salesNameID:10=[Employee:19]nameid:1)
		Else 
			QUERY:C277([Order:3]; [Order:3]repID:8="23f326fsrt5redf////~1~67343ajkljjl.,>")
	End case 
End if 

If (Records in selection:C76([Order:3])>0)
	FIRST RECORD:C50([Order:3])
	QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
	ORDER BY:C49([OrderLine:49]; [OrderLine:49]orderNum:1; [OrderLine:49]itemNum:4)
	$doPage:=WC_DoPage($jitpageone; "")
	
	If ($doc2Print#"")
		QUERY:C277([UserReport:46]; [UserReport:46]name:2=$doc2Print; *)
		QUERY:C277([UserReport:46];  & [UserReport:46]authorityLevel:24<=vWccSecurity; *)
		QUERY:C277([UserReport:46];  & [UserReport:46]tableNum:3=Table:C252(->[Order:3]))
		If (Records in selection:C76([UserReport:46])=1)
			ptCurTable:=(->[Order:3])
			vHere:=1
			Print_Auto(->[Order:3])
			vHere:=0
			vResponse:="Orders sent to printer form: "+$doc2Print
		Else 
			vResponse:="No document found at your authority: "+$doc2Print
		End if 
	End if 
Else 
	vResponse:="No matching records at this authority level"
	$doPage:="error.html"
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
vInAsCustomer:=""
vResponse:=""
vcustomerID:=""