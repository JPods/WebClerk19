//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/06/11, 11:59:23
// ----------------------------------------------------
// Method: SyncOrders
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $confirmComment)
C_LONGINT:C283($i; $k)

If (Count parameters:C259=0)
	$confirmComment:="Post out Order."
Else 
	$confirmComment:=$1
End if 
$k:=Records in selection:C76([Order:3])
If ($k>0)
	If ($confirmComment#"")
		CONFIRM:C162($confirmComment)
	Else 
		OK:=1
	End if 
	If (OK=1)  // ((vHere=2)&(ptCurTable=(->[Order])))
		If (<>pathServer#"")
			iLoText9:=<>pathServer+"PostOut"+String:C10([Order:3]orderNum:2)
		Else 
			iLoText9:=Storage:C1525.folder.jitExportsF+"PostOut"+String:C10([Order:3]orderNum:2)
		End if 
		iLoInteger1:=Test path name:C476(iLoText9)
		If (iLoInteger1=0)
			DELETE FOLDER:C693(iLoText9)
		End if 
		
		CREATE FOLDER:C475(iLoText9)
		If (OK=1)
			If ([Order:3]idNumTask:85=0)
				CREATE RECORD:C68([Task:140])
				[Task:140]state:25:="MissingRecordOrder"
				[Task:140]obRelate:17:=New object:C1471
				[Task:140]obRelate:17.Order:=[Order:3]orderNum:2
				SAVE RECORD:C53([Task:140])
				[Order:3]idNumTask:85:=[Task:140]idNum:4
				SAVE RECORD:C53([Order:3])
			End if 
			QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
			QUERY:C277([QA:70]; [QA:70]idNumTask:12=[Order:3]idNumTask:85)
			QUERY:C277([Invoice:26]; [Invoice:26]orderNum:1=[Order:3]orderNum:2)
			QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]orderNum:60=[Order:3]orderNum:2)
			QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Order:3]orderNum:2)
			//QUERY([WorkOrder];[QACustomer]taskID=[Order]taskID)
			//
			If (Records in selection:C76([Order:3])>0)
				Records_Out(->[Order:3]; iLoText9+"003RecsSyncOrders.out"; 1)  //File; name of file; keep selection
			End if 
			If (Records in selection:C76([QA:70])>0)
				Records_Out(->[QA:70]; iLoText9+"070RecsSyncQA.out"; 1)  //File; name of file; keep selection
			End if 
			If (Records in selection:C76([Customer:2])>0)
				Records_Out(->[Customer:2]; iLoText9+"002RecsSyncCust.out"; 1)  //File; name of file; keep selection
			End if 
			If (Records in selection:C76([OrderLine:49])>0)
				Records_Out(->[OrderLine:49]; iLoText9+"049RecsSyncOrdLines.out"; 1)  //File; name of file; keep selection
			End if 
			If (Records in selection:C76([Invoice:26])>0)
				Records_Out(->[Invoice:26]; iLoText9+"026RecsSyncInvoices.out"; 1)  //File; name of file; keep selection
			End if 
			If (Records in selection:C76([InvoiceLine:54])>0)
				Records_Out(->[InvoiceLine:54]; iLoText9+"054RecsSyncInvLines.out"; 1)  //File; name of file; keep selection
			End if 
			If (Records in selection:C76([Payment:28])>0)
				Records_Out(->[Payment:28]; iLoText9+"028RecsSyncPay.out"; 1)  //File; name of file; keep selection
			End if 
		End if 
	End if 
End if 