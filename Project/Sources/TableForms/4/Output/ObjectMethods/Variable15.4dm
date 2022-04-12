// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/11/10, 13:58:44
// ----------------------------------------------------
// Method: Object Method: alo001
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
		ARRAY TEXT:C222(alo001; 0)
		
		
		APPEND TO ARRAY:C911(alo001; "Make Words")
		APPEND TO ARRAY:C911(alo001; "Add Words")
		APPEND TO ARRAY:C911(alo001; "Subtract Words")
		//APPEND TO ARRAY(alo001;"Import 2 Selected")
		//APPEND TO ARRAY(alo001;"Import by ItemNum")
		APPEND TO ARRAY:C911(alo001; "Export XRef")
		//  APPEND TO ARRAY(alo001;"Import XRef")
		APPEND TO ARRAY:C911(alo001; "Matrix to Clipboard")
		// APPEND TO ARRAY(alo001;"Item 2 [Keyword]")
		APPEND TO ARRAY:C911(alo001; "Item Image Path")
		// append to array(alo001;"Images in Folder")
		
		// ### bj ### 20200613_1157 Make Words in the first item
		//   : (alo001=1)
		//
	: (alo001{alo001}="Make Words")  //Make
		CONFIRM:C162("Create Keywords for selected items")
		If (OK=1)
			CONFIRM:C162("This will delete all existing keywords, would you like to proceed?")
			If (OK=1)
				C_TEXT:C284($strLen)
				C_LONGINT:C283($maxLen)
				$maxLen:=80
				
				KeyWordMakeSelection(->[Item:4])
				
			End if 
		End if 
		ARRAY TEXT:C222(aBadWords; 0)
	: (alo001{alo001}="Add Words")  //Add    
		//
		srKeyword:=Request:C163("Enter Keyword(s , separated) to add."; srKeyword)
		If ((OK=1) & (srKeyword#""))
			Key_AddWord(->[Item:4]; "selection"; srKeyword)
		End if 
		
	: (alo001{alo001}="Subtract Words")  //Subtract
		//
		srKeyword:=Request:C163("Enter Keyword(s , separated) to subtract."; srKeyword)
		Key_SubtractWord(->[Item:4]; "selection"; srKeyword)
		
	: (alo001{alo001}="Import 2 Selected")  //rework
		CONFIRM:C162("Import Keywords to Selected Records?")
		If (OK=1)
			myDocName:=""
			$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Open File to Import"; ""; Storage:C1525.folder.jitF)
			If ($myOK=1)
				RECEIVE PACKET:C104(myDoc; $workText)
				If (OK=1)
					Key_BadWords("Item")
					$k:=Records in selection:C76([Item:4])
					FIRST RECORD:C50([Item:4])
					//ThermoInitExit ("Processing Items";$k;True)
					$viProgressID:=Progress New
					For ($i; 1; $k)
						//Thermo_Update ($i)
						ProgressUpdate($viProgressID; $i; $k; "Processing Items")
						If (thermoAbort)
							$i:=$k
						End if 
						
						SAVE RECORD:C53([Item:4])
						KeyWordsMake(->[Item:4])
						NEXT RECORD:C51([Item:4])
					End for 
					//Thermo_Close 
					Progress QUIT($viProgressID)
					CLOSE DOCUMENT:C267(myDoc)
				End if 
			End if 
		End if 
	: (alo001{alo001}="Import by item")  //rework
		// ### bj ### 20200518_2055
		// rework
		// currently not in array
		
		CONFIRM:C162("Import Keywords to by ItemNum?")
		If (OK=1)
			CONFIRM:C162("ItemNum must be the first column")
			If (OK=1)
				CLOSE DOCUMENT:C267(mydoc)
				
				
				myDocName:=""
				$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Open File to Import"; ""; Storage:C1525.folder.jitF)
				If ($myOK=1)
					$maxLen:=Num:C11(Request:C163("Max length keyword"; "Any length"))
					If (OK=1)
						Key_BadWords("Item")
						C_LONGINT:C283($theCount)
						$theCount:=0
						TRACE:C157
						Repeat 
							$theCount:=$theCount+1
							MESSAGE:C88(String:C10($theCount))
							RECEIVE PACKET:C104(myDoc; $workItem; "\t")
							RECEIVE PACKET:C104(myDoc; $workText; "\r")
							If (OK=1)
								$workItem:=Replace string:C233($workItem; Char:C90(10); "")
								QUERY:C277([Item:4]; [Item:4]itemNum:1=$workItem)
								If (Records in selection:C76([Item:4])=1)
									$workText:=Replace string:C233($workText; "; "; ", ")
									$workText:=Replace string:C233($workText; "\t"; ", ")
									Item_GetSpec
									If (Record number:C243([ItemSpec:31])=-1)
										Item_MakeSpec
									End if 
									[ItemSpec:31]keyTags:35:=Replace string:C233($workText; Char:C90(34); "")
									SAVE RECORD:C53([ItemSpec:31])
								End if 
								SAVE RECORD:C53([Item:4])
								KeyWordsMake(->[Item:4])
							End if 
						Until (OK=0)
					End if 
					CLOSE DOCUMENT:C267(mydoc)
				End if 
			End if 
		End if 
	: (alo001{alo001}="Export XRef")  //Export XRef
		XRefRecordsOut
	: (alo001{alo001}="Import XRef")  //rework
		// ### bj ### 20200518_2055
		// rework
		// currently not in array
		XRefRecordsIn
	: (alo001{alo001}="Matrix to Clipboard")
		MxItemSetup  //("NudeX";->[Item]PriceA;2;"Nude X Paddling Jacket";5))
		
	: (alo001{alo001}="Item 2 [Keyword]")  //rework
		// ### bj ### 20200518_2055
		// rework
		// currently not in array
		KwItems2Bubbles(""; 1)
	: (alo001{alo001}="Images in Folder")  //rework
		// ### bj ### 20200518_2055
		// rework
		// currently not in array
	: (alo001{alo001}="Item Image Path")  //image paths by item
		ImagePathCheck
		
End case 
alo001:=1
REDRAW WINDOW:C456

