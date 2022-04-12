Case of 
	: (Form event code:C388=On Load:K2:1)
		curTableNum:=Table:C252(->[Order:3])
		viRecordsInSelection:=Records in selection:C76(Table:C252(curTableNum)->)
		viRecordsInTable:=Records in table:C83(Table:C252(curTableNum)->)
	: (Outside call:C328)
		Prs_OutsideCall
	Else 
		Case of 
			: (b20=1)
				b21:=0
				b22:=0
				b23:=0
				curTableNum:=Table:C252(->[Order:3])
			: (b21=1)
				b20:=0
				b22:=0
				b23:=0
				curTableNum:=Table:C252(->[Invoice:26])
			: (b22=1)
				b21:=0
				b20:=0
				b23:=0
				curTableNum:=Table:C252(->[PO:39])
			: (b23=1)
				b21:=0
				b20:=0
				b22:=0
				curTableNum:=Table:C252(->[InventoryStack:29])
		End case 
		//    jsetDefaultFile (File(curTableNum))
		viRecordsInSelection:=Records in selection:C76(Table:C252(curTableNum)->)
		viRecordsInTable:=Records in table:C83(Table:C252(curTableNum)->)
		
		
		
End case 