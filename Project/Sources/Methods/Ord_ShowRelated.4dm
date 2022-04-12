//%attributes = {"publishedWeb":true}
//Ord_ShowRelated
If ((ptCurTable=(->[Order:3])) & (vHere=1))
	ARRAY TEXT:C222(a1Text; 9)
	a1Text{1}:="Service"
	a1Text{2}:="Invoice"
	a1Text{3}:="Payment"
	a1Text{4}:="Proposal"
	a1Text{5}:="OrdLines"
	a1Text{6}:="WorkOrder"
	a1Text{7}:="Requisitions"
	a1Text{8}:="Matched Payments"
	// ### bj ### 20190903_1213
	a1Text{9}:="PO"
	
	
	//
	SORT ARRAY:C229(a1Text)
	vModPop:=False:C215
	vDiaCom:="Tables"
	doSearch:=0
	a1Text:=0
	changePop:=0
	DialogListChoices
	If ((myOK>0) & (a1Text>0))
		C_LONGINT:C283($w; $i; $k; $fileCnt; $fileInc; $fileID)
		$w:=Find in array:C230(<>aTableNames; a1Text{a1Text})
		If ($w>0)
			$doSet:=True:C214
			Case of 
				: (Table:C252(<>aTableNums{$w})=(->[OrderLine:49]))
					RELATE MANY SELECTION:C340([OrderLine:49]orderNum:1)
				Else 
					C_POINTER:C301($ptFile; $ptFld)
					$doSet:=False:C215
					$fileID:=3
					$ptFile:=Table:C252(<>aTableNums{$w})
					Case of 
						: (Table:C252(<>aTableNums{$w})=(->[Service:6]))
							$ptFld:=(->[Service:6]orderNum:22)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[Invoice:26]))
							$ptFld:=(->[Invoice:26]orderNum:1)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[Payment:28]))
							$ptFld:=(->[Payment:28]orderNum:2)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[Proposal:42]))
							$ptFld:=(->[Proposal:42]orderNum:60)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[OrderLine:49]))
							$ptFld:=(->[OrderLine:49]orderNum:1)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[WorkOrder:66]))
							$ptFld:=(->[WorkOrder:66]salesOrderLine:2)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[Requisition:83]))
							$ptFld:=(->[Requisition:83]orderNum:4)
							$fileID:=0
						: (Table:C252(<>aTableNums{$w})=(->[PO:39]))
							$ptFld:=(->[PO:39]orderNum:18)
							$fileID:=0
					End case 
					CREATE EMPTY SET:C140($ptFile->; "<>curSelSet")
					$k:=Records in selection:C76([Order:3])
					FIRST RECORD:C50([Order:3])
					For ($i; 1; $k)
						QUERY:C277($ptFile->; $ptFld->=[Order:3]orderNum:2; *)
						If ($fileID#0)
							QUERY:C277($ptFile->; $ptFldFileID->=2; *)
						End if 
						QUERY:C277($ptFile->)
						CREATE SET:C116($ptFile->; "Current")
						UNION:C120("Current"; "<>curSelSet"; "<>curSelSet")
						CLEAR SET:C117("Current")
						NEXT RECORD:C51([Order:3])
					End for 
			End case 
			If ($doSet)
				CREATE SET:C116(Table:C252(<>aTableNums{$w})->; "<>curSelSet")
			End if 
			REDUCE SELECTION:C351(Table:C252(<>aTableNums{$w})->; 0)
			<>ptCurTable:=Table:C252(<>aTableNums{$w})
			<>prcControl:=0
			C_TEXT:C284($theName)
			$theName:=String:C10(Count user processes:C343)+Table name:C256(<>ptCurTable)
			DB_ShowCurrentSelection(<>ptCurTable; ""; 4; "")
		Else 
			If (a1Text=8)
				vi2:=Records in selection:C76([Order:3])
				FIRST RECORD:C50([Order:3])
				CREATE EMPTY SET:C140([Order:3]; "Current")
				For (vi1; 1; vi2)
					QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Order:3]orderNum:2)
					FIRST RECORD:C50([Payment:28])
					//Alert(string([Order]Total)+"; "+string([Payment]Amount))
					If ([Order:3]total:27#[Payment:28]amount:1)
						If (allowAlerts_boo)
							MESSAGE:C88(String:C10(vi1)+": "+String:C10([Order:3]total:27)+"; "+String:C10([Payment:28]amount:1))
						End if 
						ADD TO SET:C119([Order:3]; "Current")
					End if 
					NEXT RECORD:C51([Order:3])
				End for 
				USE SET:C118("Current")
				CLEAR SET:C117("Current")
				
			End if 
		End if 
	End if 
	ARRAY TEXT:C222(a1Text; 0)
Else 
	If (allowAlerts_boo)
		ALERT:C41("Only works from Items File")
	End if 
End if 

REDRAW WINDOW:C456