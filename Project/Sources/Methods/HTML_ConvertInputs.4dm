//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: HTML_ConvertInputs
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
C_LONGINT:C283($err; $i; $k; $1; $doHtml; $kPages; $iPages)
C_TEXT:C284($fileFold; $theSite)
KeyModifierCurrent
CONFIRM:C162("Backup before this step, OK to change web pages to '_jit' tags.")
If (OK=1)
	$fileFold:=Get_FolderName("Select folder to List Files.")
	If ($fileFold#"")
		$w:=Find in array:C230(<>aPrsNameWeb; "WC_@")
		If ($w>0)
			WC_StartUpShutDownFlip
		End if 
		ARRAY TEXT:C222(aText1; 0)
		ARRAY TEXT:C222($aDocArray; 0)
		$error:=HFS_CatToArray($fileFold; "aText1")
		COPY ARRAY:C226(aText1; $aDocArray)
		$kPages:=Size of array:C274($aDocArray)
		If ($kPages>0)
			C_TEXT:C284($theBody; $testText; $thePage; $theHead)
			C_LONGINT:C283($bodyBeg; $hasSelect; $headBeg; $headEnd)
			
			For ($iPages; $kPages; 1; -1)
				MESSAGE:C88(String:C10($iPages)+" to zero")
				$bodyBeg:=Position:C15("."; $aDocArray{$iPages})
				If (($bodyBeg>0) & ($aDocArray{$iPages}#"Secure.txt"))
					myDoc:=Open document:C264($fileFold+$aDocArray{$iPages})
					If (OK=1)
						$thePage:=""
						<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
						RECEIVE PACKET:C104(myDoc; $thePage; <>vEoF)
						If (OK=1)
							CLOSE DOCUMENT:C267(myDoc)
							// TRACE              
							$thePage:=Replace string:C233($thePage; "ItemType"; "typeID")
							$thePage:=Replace string:C233($thePage; "ItemsProfile1"; "Profile1")
							$thePage:=Replace string:C233($thePage; "ItemsProfile2"; "Profile2")
							$thePage:=Replace string:C233($thePage; "ItemsProfile3"; "Profile3")
							$thePage:=Replace string:C233($thePage; "ItemsProfile4"; "Profile4")
							$thePage:=Replace string:C233($thePage; "ItemsProfile5"; "Profile5")
							// 
							$thePage:=Replace string:C233($thePage; "mfgNum"; "MfgItemNum")
							$thePage:=Replace string:C233($thePage; "itemDesc"; "Description")
							$thePage:=Replace string:C233($thePage; "itemClass"; "Class")
							$thePage:=Replace string:C233($thePage; "vendID"; "VendorID")
							$thePage:=Replace string:C233($thePage; "vendItem"; "VendorItemNum")
							//              
							$err:=HFS_Delete(document)
							myDoc:=Create document:C266(document)
							SEND PACKET:C103(myDoc; $thePage)
							CLOSE DOCUMENT:C267(myDoc)
							App_SetSuffix(".html.txt"; ".html")
						End if 
					End if 
				End if 
			End for 
			ALERT:C41("Check for 'jj_jj' incorrectly applied to '!'"+"\r"+"Single '!' conversion may affect content")
		End if 
	End if 
End if 
REDRAW WINDOW:C456