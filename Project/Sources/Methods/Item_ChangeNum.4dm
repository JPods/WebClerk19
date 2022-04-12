//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/07/09, 16:43:41
// ----------------------------------------------------
// Method: Item_ChangeNum
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($i; $k)  //this is the better one
C_BOOLEAN:C305($doChange; $doDelete)
$myOK:=EI_OpenDoc(->myDocName; ->sumDoc; "Select Item Change File"; ""; Storage:C1525.folder.jitExportsF)  //;jitQRsF
If ($myOK=1)
	$i:=0
	$k:=Num:C11(Request:C163("Enter the approximate number of Items to be changed."))
	//ThermoInitExit ("Changing Items";$k;True)
	$viProgressID:=Progress New
	
	TRACE:C157
	Repeat 
		$i:=$i+1
		RECEIVE PACKET:C104(sumDoc; pPartNum; "\t")  //old item number
		pPartNum:=TxtStripLineFeed(pPartNum)
		RECEIVE PACKET:C104(sumDoc; srItemNum; "\r")  //new item number
		If (<>ThermoAbort)
			If (OK=1)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=srItemNum)
				$doDelete:=(Records in selection:C76([Item:4])=1)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
				If (Records in selection:C76([Item:4])=1)
					//Thermo_Update ($i)
					ProgressUpdate($viProgressID; $i; $k; "Changing Items")
					
					$doChange:=ConsolidateRecs(->[Item:4]; ->pPartNum; ->srItemNum; False:C215)
					If ($doDelete)
						DELETE RECORD:C58([Item:4])  //Delete the old partnum record
					Else 
						[Item:4]itemNum:1:=srItemNum
						SAVE RECORD:C53([Item:4])
					End if 
				End if 
			End if 
		End if 
	Until (OK=0)
	//Thermo_Close 
	Progress QUIT($viProgressID)
	UNLOAD RECORD:C212([Item:4])
	CLOSE DOCUMENT:C267(sumDoc)
End if 