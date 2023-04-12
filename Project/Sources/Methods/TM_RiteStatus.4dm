//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/29/12, 13:09:35
// ----------------------------------------------------
// Method: TM_RiteStatus
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($dtOrd; $dtNeed; $k; $i)
C_TEXT:C284(<>tcStatPath; $vStatPath)
C_DATE:C307($1)
C_TIME:C306($2)
READ ONLY:C145([Order:3])
If ((OptKey=1) | (vlStatTime=0))
	QUERY:C277([Order:3]; [Order:3]dateInvoiceComp:6=!00-00-00!; *)
	QUERY:C277([Order:3];  | [Order:3]dateInvoiceComp:6=!1901-01-01!)
	$i:=1
	Repeat 
		$vStatPath:=<>tcStatPath+String:C10($i)
		If (HFS_Exists($vStatPath)=1)
			$err:=HFS_Delete($vStatPath)
		End if 
		$i:=$i+1
	Until ($i>100)
Else 
	QUERY:C277([Order:3]; [Order:3]lng:34>vlStatTime)
End if 
vlStatTime:=DateTime_DTTo
$k:=Records in selection:C76([Order:3])
If ($k>0)
	$i:=1
	$vStatPath:=<>tcStatPath+String:C10($i)
	While (HFS_Exists($vStatPath)#0)
		$i:=$i+1
		$vStatPath:=<>tcStatPath+String:C10($i)
	End while 
	myDoc:=Create document:C266($vStatPath)
	FIRST RECORD:C50([Order:3])
	MESSAGE:C88("Processing Order Status")
	For ($i; 1; $k)
		$dtOrd:=DateTime_DTTo([Order:3]dateDocument:4; [Order:3]timeOrdered:58)
		$dtNeed:=DateTime_DTTo([Order:3]dateNeeded:5; [Order:3]actionTime:37)
		SEND PACKET:C103(myDoc; [Order:3]customerID:1+"\t"+[Order:3]company:15+"\t"+[Order:3]customerPO:3+"\t"+String:C10([Order:3]idNum:2; "0000-0000")+"\t"+String:C10($dtOrd)+"\t"+String:C10($dtNeed)+"\t"+[Order:3]status:59+"\t"+[Order:3]takenBy:36+"\t"+[Order:3]actionBy:55+"\r")
		NEXT RECORD:C51([Order:3])
	End for 
	CLOSE DOCUMENT:C267(myDoc)
End if 
READ WRITE:C146([Order:3])
REDRAW WINDOW:C456