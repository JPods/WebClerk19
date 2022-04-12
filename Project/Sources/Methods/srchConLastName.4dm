//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/21/09, 10:22:38
// ----------------------------------------------------
// Method: srchConLastName
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($doJoin)
$doJoin:=True:C214
C_LONGINT:C283($fileNum; vHere)
$fileNum:=0
Case of 
	: (vHere=0)
		//Repeat 
		jSrchResponse(->[Contact:13]; ->[Contact:13]nameLast:4; "A")
		//Until ((Records in selection([Contact])#0)|(OK=0))
	: (vHere=1)
		$doProject:=True:C214
		Case of 
			: (ptCurTable=(->[Customer:2]))
			: (ptCurTable=(->[Order:3]))
				RELATE ONE SELECTION:C349([Order:3]; [Customer:2])
			: (ptCurTable=(->[Invoice:26]))
				RELATE ONE SELECTION:C349([Invoice:26]; [Customer:2])
			: (ptCurTable=(->[Service:6]))
				RELATE ONE SELECTION:C349([Service:6]; [Customer:2])
			: (ptCurTable=(->[Reference:7]))
				RELATE ONE SELECTION:C349([Reference:7]; [Customer:2])
			: (ptCurTable=(->[Payment:28]))
				RELATE ONE SELECTION:C349([Payment:28]; [Customer:2])
			: (ptCurTable=(->[Proposal:42]))
				RELATE ONE SELECTION:C349([Proposal:42]; [Customer:2])
			: (ptCurTable=(->[OrderLine:49]))
				RELATE ONE SELECTION:C349([OrderLine:49]; [Customer:2])
			: (ptCurTable=(->[InvoiceLine:54]))
				RELATE ONE SELECTION:C349([InvoiceLine:54]; [Customer:2])
			: (ptCurTable=(->[QA:70]))
				RelateByFileNum(Table:C252(->[Contact:13]); ->[QA:70]; ->[QA:70]tableNum:11; ->[QA:70]customerID:1)
				$doJoin:=False:C215
			: (ptCurTable=(->[CallReport:34]))
				RelateByFileNum(Table:C252(->[CallReport:34]); ->[CallReport:34]; ->[CallReport:34]tableNum:2; ->[CallReport:34]customerID:1)
				$doJoin:=False:C215
			Else 
				DB_ShowByTableName("Contact")
				$doJoin:=False:C215
		End case 
		$fileNum:=Table:C252(->[Contact:13])*Num:C11(Records in selection:C76([Customer:2])>0)
		Case of 
			: (($fileNum>0) & ($doJoin))
				RELATE MANY SELECTION:C340([Contact:13]customerID:1)
				UNLOAD RECORD:C212(ptCurTable->)
				curTableNum:=Table:C252(->[Contact:13])
				ProcessTableOpen
				
				
			: (Records in selection:C76([Contact:13])>0)
				UNLOAD RECORD:C212(ptCurTable->)
				curTableNum:=Table:C252(->[Contact:13])
				ProcessTableOpen
				
				
		End case 
	Else 
		jAlertMessage(10100)
End case 