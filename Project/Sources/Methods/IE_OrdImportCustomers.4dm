//%attributes = {"publishedWeb":true}
If (False:C215)
	//PM:  IE_OrdImportCustomers
	//Desc.:  
	//NB:      
	//CB:      
	//New:    04/17/2000.nds   
End if 
//
tCustomerImportText:=Get_FileName("Select the Customer text file..."; "TEXT")
//
If (tCustomerImportText#"")
	hCustomerImportDoc:=Open document:C264(tCustomerImportText; "TEXT")
	//
	If (OK=1)  //file open successfully
		//
		C_BOOLEAN:C305($oContinue)
		C_LONGINT:C283($lLoopNumber)
		C_TEXT:C284($tClipText)
		$oContinue:=False:C215
		//
		C_TEXT:C284(vtImportUniqueTag)
		vtImportUniqueTag:="IE_Ord"+String:C10(Current date:C33; System date short:K1:1)+"-"+String:C10(hCustomerImportDoc; 1)  //This will be used for [EventLog]Group if needed
		//
		$lLoopNumber:=1
		//
		ARRAY TEXT:C222(asSpecialNames; 0)
		ARRAY POINTER:C280(aptSpecialVars; 0)
		C_TEXT:C284($HeaderRow)
		RECEIVE PACKET:C104(hCustomerImportDoc; $HeaderRow; Char:C90(Carriage return:K15:38))  //import label row (CR ends record)
		ARRAY POINTER:C280(aptCustomerFieldPointers; 0)
		C_BOOLEAN:C305($FieldsValid)
		$FieldsValid:=IE_OrdVerifyImportFields($HeaderRow; Table:C252(->[Customer:2]); ->aptCustomerFieldPointers; ->asSpecialNames; ->aptSpecialVars)
		If ($FieldsValid)
			ARRAY POINTER:C280(aptMandatoryFields; 1)
			aptMandatoryFields{1}:=(->[Customer:2]customerID:1)
			$FieldsValid:=IE_OrdVerifyMandatoryFields(->aptCustomerFieldPointers; ->aptMandatoryFields)
			If ($FieldsValid)
				ARRAY POINTER:C280(aptMandatoryFields; 1)
				aptMandatoryFields{1}:=(->[Customer:2]company:2)
				$FieldsValid:=IE_OrdVerifyMandatoryFields(->aptCustomerFieldPointers; ->aptMandatoryFields)
				If (Not:C34($FieldsValid))
					ARRAY POINTER:C280(aptMandatoryFields; 2)
					aptMandatoryFields{1}:=(->[Customer:2]nameFirst:73)
					aptMandatoryFields{2}:=(->[Customer:2]nameLast:23)
					$FieldsValid:=IE_OrdVerifyMandatoryFields(->aptCustomerFieldPointers; ->aptMandatoryFields)
				End if 
			End if 
			If ($FieldsValid)
				C_LONGINT:C283($iImportFieldCount)
				$iImportFieldCount:=Size of array:C274(aptCustomerFieldPointers)
				ARRAY TEXT:C222(atCustomerImport; 0; $iImportFieldCount)
				While (tCustomerImportText#"")  //Each loop represents the import of one Customer record  
					
					MESSAGE:C88("Importing Customer "+String:C10($lLoopNumber))
					
					RECEIVE PACKET:C104(hCustomerImportDoc; tCustomerImportText; Char:C90(Carriage return:K15:38))  //import one record at a time (CR ends record)          
					$tClipText:=tCustomerImportText
					If (Length:C16($tClipText)>0)
						//!!!!!!!! find out if there are line feeds after the <CR> and strip out !!!!!!!!!
						If ($tClipText[[1]]="\n")
							$tClipText:=Substring:C12($tClipText; 2)  //strip out leading LineFeeds, these are part of windows record delimeters
						End if 
					End if 
					//$tClipText:=Txt_ClearLastTab ($tClipText)//insure we don't have
					// a trailing tab for each row
					
					If ($tClipText#"")
						
						$oContinue:=Txt_GetCharacterCount($tClipText; Char:C90(9))=($iImportFieldCount-1)  //count the tabs in this chunk of text
						
						If ($oContinue)  //count the tabs in this chunk of text
							
							INSERT IN ARRAY:C227(atCustomerImport; $lLoopNumber)
							
							For ($i; 1; $iImportFieldCount)
								
								If ($i=$iImportFieldCount)
									atCustomerImport{$lLoopNumber}{$i}:=$tClipText
								Else 
									atCustomerImport{$lLoopNumber}{$i}:=Substring:C12($tClipText; 1; Position:C15(Char:C90(Tab:K15:37); $tClipText)-1)
								End if 
								
								$tClipText:=Substring:C12($tClipText; Position:C15(Char:C90(Tab:K15:37); $tClipText)+1)  //delete section from full text                    
								
							End for 
							
						End if   //$oContinue = false: correct number of tabs found  
						
						$lLoopNumber:=$lLoopNumber+1
						
					End if 
					
				End while 
				
				CLOSE DOCUMENT:C267(hCustomerImportDoc)
				
				If ($oContinue)  //we can continue with Order import
					//IE_OrdImportOrders
				Else 
					ELog_NewRecMsg(0; vtImportUniqueTag; "Unexpected number of tabs encountered. Please examine Customer import document.")
					ALERT:C41("Import aborted. Please review Event Log.")
				End if 
			Else 
				CLOSE DOCUMENT:C267(hCustomerImportDoc)
				ELog_NewRecMsg(0; vtImportUniqueTag; "There are mandatory fields that are missing from the customer import file.")
			End if 
		Else 
			CLOSE DOCUMENT:C267(hCustomerImportDoc)
			ELog_NewRecMsg(0; vtImportUniqueTag; "Invalid Field Name(s) in header row of the customer file.")
		End if 
	End if   //doc was opened from disk
	
End if   //user selected doc from disk

//End of routine
REDRAW WINDOW:C456
