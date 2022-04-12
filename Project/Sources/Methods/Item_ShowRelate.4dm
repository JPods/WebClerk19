//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 06/03/10, 11:09:58
// ----------------------------------------------------
// Method: Item_ShowRelate
// Description
// File: Item_ShowRelate.txt
//
// Parameters
// ----------------------------------------------------

If ((ptCurTable=(->[Item:4])) & (vHere=1))
	ARRAY TEXT:C222(a1Text; 19)
	ARRAY TEXT:C222(aText2; 19)  //###_jwm_### 20100603 4D v11 Crashes if not defined and same size
	//### jwm ### 20120521 reduced size of arrays from 20 to 19 and renumbered list below (a1Text{1} was missing)
	a1Text{1}:="ItemSpec"
	a1Text{2}:="BOM"
	a1Text{3}:="ItemXRef"
	a1Text{4}:="InventoryStack"
	a1Text{5}:="dInventory"
	a1Text{6}:="ItemSerial"
	a1Text{7}:="ItemSerialAction"
	a1Text{8}:="WorkOrder"
	a1Text{9}:="WOdraw"
	a1Text{10}:="OrderLine"
	a1Text{11}:="InvoiceLine"
	a1Text{12}:="POLine"
	a1Text{13}:="ProposalLine"
	a1Text{14}:="ItemDiscount"
	a1Text{15}:="Reservation"
	a1Text{16}:="TallyMaster"
	a1Text{17}:="TallySummary"
	a1Text{18}:="TallyResult"
	a1Text{19}:="Usage"
	SORT ARRAY:C229(a1Text)
	vModPop:=False:C215
	vDiaCom:="Tables"
	doSearch:=0
	a1Text:=0
	changePop:=0
	DialogListChoices
	If ((myOK>0) & (a1Text>0))
		C_LONGINT:C283($w; $i; $k; $fileCnt; $fileInc)
		$w:=Find in array:C230(<>aTableNames; a1Text{a1Text})
		If ($w>0)
			$doSet:=True:C214
			Case of 
				: (Table:C252(<>aTableNums{$w})=(->[BOM:21]))
					RELATE MANY SELECTION:C340([BOM:21]itemNum:1)
				: (Table:C252(<>aTableNums{$w})=(->[DInventory:36]))
					RELATE MANY SELECTION:C340([DInventory:36]itemNum:1)
				: (Table:C252(<>aTableNums{$w})=(->[Usage:5]))
					RELATE MANY SELECTION:C340([Usage:5]itemNum:1)
				: (Table:C252(<>aTableNums{$w})=(->[ItemXRef:22]))
					RELATE MANY SELECTION:C340([ItemXRef:22]itemNumMaster:1)
				: (Table:C252(<>aTableNums{$w})=(->[ItemSerial:47]))
					RELATE MANY SELECTION:C340([ItemSerial:47]itemNum:1)
				: (Table:C252(<>aTableNums{$w})=(->[InventoryStack:29]))
					RELATE MANY SELECTION:C340([InventoryStack:29]itemNum:2)
				: (Table:C252(<>aTableNums{$w})=(->[Reservation:79]))
					RELATE MANY SELECTION:C340([Reservation:79]itemNum:1)
				: (Table:C252(<>aTableNums{$w})=(->[ItemSpec:31]))
					//### jwm ### 20131017_1456 incredibly faster
					ARRAY TEXT:C222($atItemNum; 0)
					SELECTION TO ARRAY:C260([Item:4]itemNum:1; $atItemNum)
					QUERY WITH ARRAY:C644([ItemSpec:31]itemNum:1; $atItemNum)
					ARRAY TEXT:C222($atItemNum; 0)
					If (False:C215)
						$doSet:=False:C215
						CREATE EMPTY SET:C140([ItemSpec:31]; "<>curSelSet")
						$k:=Records in selection:C76([Item:4])
						FIRST RECORD:C50([Item:4])
						For ($i; 1; $k)
							If ([Item:4]specification:42)
								If ([Item:4]specid:62="")
									QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]itemNum:1)
								Else 
									QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]specid:62)
								End if 
							Else 
								REDUCE SELECTION:C351([ItemSpec:31]; 0)
							End if 
							CREATE SET:C116([ItemSpec:31]; "Current")
							UNION:C120("Current"; "<>curSelSet"; "<>curSelSet")
							CLEAR SET:C117("Current")
							NEXT RECORD:C51([Item:4])
						End for 
					End if 
				Else 
					C_POINTER:C301($ptFile; $ptFld)
					$doSet:=False:C215
					Case of 
						: (Table:C252(<>aTableNums{$w})=(->[ItemSerialAction:64]))
							$ptFld:=(->[ItemSerialAction:64]itemNum:8)
							$ptFile:=Table:C252(<>aTableNums{$w})
						: (Table:C252(<>aTableNums{$w})=(->[WorkOrder:66]))
							$ptFld:=(->[WorkOrder:66]itemNum:12)
							$ptFile:=Table:C252(<>aTableNums{$w})
						: (Table:C252(<>aTableNums{$w})=(->[WOdraw:68]))
							$ptFld:=(->[WOdraw:68]itemNum:2)
							$ptFile:=Table:C252(<>aTableNums{$w})
						: (Table:C252(<>aTableNums{$w})=(->[OrderLine:49]))
							$ptFld:=(->[OrderLine:49]itemNum:4)
							$ptFile:=Table:C252(<>aTableNums{$w})
						: (Table:C252(<>aTableNums{$w})=(->[InvoiceLine:54]))
							$ptFld:=(->[InvoiceLine:54]itemNum:4)
							$ptFile:=Table:C252(<>aTableNums{$w})
						: (Table:C252(<>aTableNums{$w})=(->[POLine:40]))
							$ptFld:=(->[POLine:40]itemNum:2)
							$ptFile:=Table:C252(<>aTableNums{$w})
						: (Table:C252(<>aTableNums{$w})=(->[ProposalLine:43]))
							$ptFld:=(->[ProposalLine:43]itemNum:2)
							$ptFile:=Table:C252(<>aTableNums{$w})
						: (Table:C252(<>aTableNums{$w})=(->[ItemDiscount:45]))
							$ptFld:=(->[ItemDiscount:45]itemNum:2)
							$ptFile:=Table:C252(<>aTableNums{$w})
						: (Table:C252(<>aTableNums{$w})=(->[TallySummary:77]))
							$ptFld:=(->[TallySummary:77]itemNum:15)
							$ptFile:=Table:C252(<>aTableNums{$w})
						: (Table:C252(<>aTableNums{$w})=(->[TallyResult:73]))
							$ptFld:=(->[TallyResult:73]itemNum:34)
							$ptFile:=Table:C252(<>aTableNums{$w})
						: (Table:C252(<>aTableNums{$w})=(->[TallyMaster:60]))
							$ptFld:=(->[TallyMaster:60]alphaKey:26)
							$ptFile:=Table:C252(<>aTableNums{$w})
					End case 
					CREATE EMPTY SET:C140($ptFile->; "<>curSelSet")
					$k:=Records in selection:C76([Item:4])
					FIRST RECORD:C50([Item:4])
					For ($i; 1; $k)
						QUERY:C277($ptFile->; $ptFld->=[Item:4]itemNum:1)
						CREATE SET:C116($ptFile->; "Current")
						UNION:C120("Current"; "<>curSelSet"; "<>curSelSet")
						CLEAR SET:C117("Current")
						NEXT RECORD:C51([Item:4])
					End for 
			End case 
			If ($doSet)
				CREATE SET:C116(Table:C252(<>aTableNums{$w})->; "<>curSelSet")
			End if 
			REDUCE SELECTION:C351(Table:C252(<>aTableNums{$w})->; 0)
			<>ptCurTable:=Table:C252(<>aTableNums{$w})
			DB_ShowCurrentSelection(<>ptCurTable; ""; 4; "")  //<>curSelSet is already created
		End if 
	End if 
Else 
	ALERT:C41("Only works from Items File")
End if 
ARRAY TEXT:C222(a1Text; 0)
ARRAY TEXT:C222(aText2; 0)

