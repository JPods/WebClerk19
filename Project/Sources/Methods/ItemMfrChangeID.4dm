//%attributes = {}
C_LONGINT:C283(vi1; vi2)  //this is the better one
C_BOOLEAN:C305($doChange; $doDelete)
If (False:C215)
	//Method  ItemMfrChangeID
	Version_0508
	//Date: 12/28/05
	//Who: Bill
	//Description: 
End if 
TRACE:C157
vi7:=EI_OpenDoc(->myDocName; ->sumDoc; "Select Mfr Change File"; ""; Storage:C1525.folder.jitExportsF)  //;jitQRsF
If (vi7=1)
	vi1:=0
	vi2:=Num:C11(Request:C163("Enter the approximate number of Item Mfrs to be changed."))
	//ThermoInitExit ("Changing Items";vi2;True)
	$viProgressID:=Progress New
	
	Repeat 
		vi1:=vi1+1
		RECEIVE PACKET:C104(sumDoc; vText8; "\t")  //old item number
		vText8:=TxtStripLineFeed(vText8)
		RECEIVE PACKET:C104(sumDoc; vText9; "\r")  //new item number
		If (<>ThermoAbort)
			OK:=0
		End if 
		If (OK=1)
			If ((vText8#vText9) & (vText8#""))
				QUERY:C277([Item:4]; [Item:4]mfrID:53=vText8)
				vi4:=Records in selection:C76([Item:4])
				FIRST RECORD:C50([Item:4])
				For (vi3; 1; vi4)
					pPartNum:=[Item:4]itemNum:1
					[Item:4]menu:108:=Replace string:C233([Item:4]itemNum:1; "-"+[Item:4]mfrID:53; "")
					srItemNum:=[Item:4]menu:108+"-"+vText9
					[Item:4]profile4:38:=vText8
					[Item:4]mfrID:53:=vText9
					[Item:4]indicator1:95:=4
					// 
					iLoBoolean1:=ConsolidateRecs(->[Item:4]; ->pPartNum; ->srItemNum; False:C215)
					SAVE RECORD:C53([Item:4])
				End for 
			End if 
		End if 
		//Thermo_Update (vi1)
		ProgressUpdate($viProgressID; $i; $k; "Changing Items")
	Until (OK=0)
	//Thermo_Close 
	Progress QUIT($viProgressID)
	UNLOAD RECORD:C212([Item:4])
	CLOSE DOCUMENT:C267(sumDoc)
End if 