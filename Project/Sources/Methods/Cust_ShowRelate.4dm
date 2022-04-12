//%attributes = {"publishedWeb":true}
If ((ptCurTable=(->[Customer:2])) & (vHere=1))
	ARRAY TEXT:C222(a1Text; 19)
	a1Text{1}:="Order"
	a1Text{2}:="Service"
	a1Text{3}:="References"
	a1Text{4}:="Contact"
	a1Text{5}:="Invoice"
	a1Text{6}:="Payment"
	a1Text{7}:="Ledger"
	a1Text{8}:="CallReport"
	a1Text{9}:="Proposal"
	a1Text{10}:="PrpLines"
	a1Text{11}:="ItemSerial"
	a1Text{12}:="OrdLines"
	a1Text{13}:="InvLines"
	a1Text{14}:="RemoteUser"
	a1Text{15}:="TransActs"
	a1Text{16}:="WorkOrder"
	a1Text{17}:="QACust"
	a1Text{18}:="TallyResult"
	a1Text{19}:="Requisitions"
	//
	SORT ARRAY:C229(a1Text)
	vModPop:=False:C215
	vDiaCom:="Tables"
	doSearch:=0
	a1Text:=0
	changePop:=0
	DialogListChoices
	
	
	// MustFixQQQZZZ: Bill James (2021-12-10T06:00:00Z)
	
	//  This is not working properly. Change to ORDA
	
	
	If ((myOK>0) & (a1Text>0))
		C_LONGINT:C283($w; $i; $k; $fileCnt; $fileInc; $fileID)
		$w:=Find in array:C230(<>aTableNames; a1Text{a1Text})
		If ($w>0)
			$doSet:=True:C214
			Case of 
				: (Table:C252(<>aTableNums{$w})=(->[Order:3]))
					RELATE MANY SELECTION:C340([Order:3]customerID:1)
				: (Table:C252(<>aTableNums{$w})=(->[Service:6]))
					RELATE MANY SELECTION:C340([Service:6]customerID:1)
				: (Table:C252(<>aTableNums{$w})=(->[Reference:7]))
					RELATE MANY SELECTION:C340([Reference:7]customerID:1)
				: (Table:C252(<>aTableNums{$w})=(->[Payment:28]))
					RELATE MANY SELECTION:C340([Payment:28]customerID:4)
				: (Table:C252(<>aTableNums{$w})=(->[Proposal:42]))
					RELATE MANY SELECTION:C340([Proposal:42]customerID:1)
				: (Table:C252(<>aTableNums{$w})=(->[DCash:62]))
					Trans_Relate(->[Customer:2]; "<>curSelSet")
				Else 
					C_POINTER:C301($ptFile; $ptFld)
					$doSet:=False:C215
					$fileID:=2
					$ptFile:=Table:C252(<>aTableNums{$w})
					Case of 
						: (Table:C252(<>aTableNums{$w})=(->[Contact:13]))
							$ptFld:=(->[Contact:13]customerID:1)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[CallReport:34]))
							$ptFld:=(->[CallReport:34]customerID:1)
							$ptFldFileID:=(->[CallReport:34]tableNum:2)
						: (Table:C252(<>aTableNums{$w})=(->[ProposalLine:43]))
							$ptFld:=(->[ProposalLine:43]customerID:42)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[ItemSerial:47]))
							$ptFld:=(->[ItemSerial:47]customerID:9)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[OrderLine:49]))
							$ptFld:=(->[OrderLine:49]customerID:2)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[InvoiceLine:54]))
							$ptFld:=(->[InvoiceLine:54]customerID:2)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[RemoteUser:57]))
							$ptFld:=(->[RemoteUser:57]customerID:10)
							$ptFldFileID:=(->[RemoteUser:57]tableNum:9)
						: (Table:C252(<>aTableNums{$w})=(->[WorkOrder:66]))
							$ptFld:=(->[WorkOrder:66]customerID:28)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[QA:70]))
							$ptFld:=(->[QA:70]customerID:1)
							$ptFldFileID:=(->[QA:70]tableNum:11)
						: (Table:C252(<>aTableNums{$w})=(->[TallyResult:73]))
							$ptFld:=(->[TallyResult:73]customerID:30)
							$ptFldFileID:=(->[TallyResult:73]tableNum:3)
						: (Table:C252(<>aTableNums{$w})=(->[Requisition:83]))
							$ptFld:=(->[Requisition:83]customerID:32)
							$fileID:=0
							
						: (Table:C252(<>aTableNums{$w})=(->[Ledger:30]))
							$ptFld:=(->[Ledger:30]customerID:1)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[Invoice:26]))
							$ptFld:=(->[Invoice:26]customerID:3)
							$fileID:=0
					End case 
					CREATE EMPTY SET:C140($ptFile->; "<>curSelSet")
					$k:=Records in selection:C76([Customer:2])
					FIRST RECORD:C50([Customer:2])
					For ($i; 1; $k)
						QUERY:C277($ptFile->; $ptFld->=[Customer:2]customerID:1; *)
						If ($fileID#0)
							QUERY:C277($ptFile->; $ptFldFileID->=2; *)
						End if 
						QUERY:C277($ptFile->)
						CREATE SET:C116($ptFile->; "Current")
						UNION:C120("Current"; "<>curSelSet"; "<>curSelSet")
						CLEAR SET:C117("Current")
						NEXT RECORD:C51([Customer:2])
					End for 
			End case 
			If ($doSet)
				CREATE SET:C116(Table:C252(<>aTableNums{$w})->; "<>curSelSet")
			End if 
			REDUCE SELECTION:C351(Table:C252(<>aTableNums{$w})->; 0)
			<>ptCurTable:=Table:C252(<>aTableNums{$w})
			DB_ShowCurrentSelection(<>ptCurTable; ""; 1; "")
		End if 
	End if 
	ARRAY TEXT:C222(a1Text; 0)
Else 
	ALERT:C41("Only works from  File")
End if 