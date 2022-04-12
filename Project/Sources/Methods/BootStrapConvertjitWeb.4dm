//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/24/18, 18:29:33
// ----------------------------------------------------
// Method: BootStrapConvertjitWeb
// Description
// gkgkgk
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($tempFold; $pageIn; $pageBegin; $pageEnd)
C_TIME:C306($myDoc)
$tempFold:=Get_FolderName("Select folder to apply BootStrap.")
If ($tempFold#"")
	QUERY:C277([Map:84]; [Map:84]purpose:5="BootStrap"; *)
	QUERY:C277([Map:84];  & [Map:84]name:6="PageBegin")
	$pageBegin:=[Map:84]script:4
	QUERY:C277([Map:84]; [Map:84]purpose:5="BootStrap"; *)
	QUERY:C277([Map:84];  & [Map:84]name:6="PageEnd")
	$pageEnd:=[Map:84]script:4
	REDUCE SELECTION:C351([Map:84]; 0)
	
	If (($pageBegin#"") & ($pageEnd#""))
		
		DOCUMENT LIST:C474($tempFold; aText1)  //get a list of all the documents
		C_LONGINT:C283($inc; $cnt; $lenPath; $docLength; $p)
		$cnt:=Size of array:C274(aText1)
		For ($inc; 1; $cnt)
			$lenPath:=Length:C16(aText1{$inc})
			If (Substring:C12(aText1{$inc}; $lenPath-4)=".html")  // html page
				
				// If (Position("List";aText1{$inc})=0)   // not a list page
				$myDoc:=Open document:C264($tempFold+aText1{$inc})
				If (OK=1)
					$docLength:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
					RECEIVE PACKET:C104($myDoc; $pageIn; $docLength)
					CLOSE DOCUMENT:C267($myDoc)
					
					// gmgmgm  See if we want to switch the true and false. My copy was reversed.
					// ### jwm ### 20180911_1929
					If (False:C215)  // add header
						$pageout:=WC_jitNum2Name($pageIn; "names")
						
						$myDoc:=Create document:C266($tempFold+aText1{$inc})
						SEND PACKET:C103($myDoc; $pageout)
						CLOSE DOCUMENT:C267($myDoc)
						
					End if 
					
					If (True:C214)  // add header
						
						$p:=Position:C15("<body"; $pageIn)
						If ($p>0)
							$pageIn:=Substring:C12($pageIn; $p+3)
							$p:=Position:C15(">"; $pageIn)
							If ($p>0)
								$pageIn:=Substring:C12($pageIn; $p+1)
								$p:=Position:C15("</body"; $pageIn)
								If ($p>0)
									$pageIn:=Substring:C12($pageIn; 1; $p-1)
									DELETE DOCUMENT:C159($tempFold+aText1{$inc})
									$pageout:=$pageBegin+$pageIn+$pageEnd
									
									$pageout:=WC_jitNum2Name($pageout; "names")
									
									$myDoc:=Create document:C266($tempFold+aText1{$inc})
									SEND PACKET:C103($myDoc; $pageout)
									CLOSE DOCUMENT:C267($myDoc)
								End if 
							End if 
						End if 
					End if 
					// End if 
				End if 
			End if 
		End for 
	End if 
End if 
