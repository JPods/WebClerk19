//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 10/08/09, 11:24:11
// ----------------------------------------------------
// Method: IVC_ShippingSpl
// Description
// Structure: 2004wh_01
//// Modified by: williamjames (10/18/09)  Fixed:  myOK:=0  //clear flag to send selection to new process

// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i; $k; $p; $w)
vDiaCom:="Multiple Shipping Costs"
//TRACE
QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=[Invoice:26]invoiceNum:2)
PKArrayManage(Records in selection:C76([LoadTag:88]))
jCenterWindow(720; 430; 5; "Load Tags")
DIALOG:C40([Invoice:26]; "LoadTag")
CLOSE WINDOW:C154
//TRACE

If (OK=1)
	vModLoadTags:=True:C214
	$k:=Size of array:C274(aPKUniqueID)
	For ($i; 1; $k)
		aPKdocumentID{$i}:=[Invoice:26]orderNum:1
		aPKInvoiceNum{$i}:=[Invoice:26]invoiceNum:2
		PKArrayManage(-4; $i; 1)
	End for 
	[Invoice:26]labelCount:25:=$k
	vMod:=True:C214
	If (Is new record:C668([Invoice:26]))
		acceptInvoice
	End if 
	vMod:=calcInvoice(vMod)
	If (myOK=6)
		myOK:=0  //clear flag to send selection to new process
		QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=[Invoice:26]invoiceNum:2)
		ProcessTableOpen(Table:C252(->[LoadTag:88])*-1)
	End if 
End if 
$k:=0
//Ship_FillArray (0)
