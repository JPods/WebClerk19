//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/09/19, 18:57:17
// ----------------------------------------------------
// Method: ImagePathByVendorItem
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($pathname)
If ($pathname="")
	$pathname:=Select folder:C670("Select a folder to test images")
	If (OK#1)
		$pathname:=""
	End if 
End if 
If ($pathname#"")
	C_TEXT:C284($strDate)
	$strDate:=Date_StrYYYY MM DDTHH MM SS(Current date:C33; Current time:C178; "-"; "-"; "-")
	$pathReport:=$pathname+"ImagePathReport"+$strDate+".txt"
	$myDoc:=Create document:C266($pathReport)  /// ;"Create ImagePath Report")  //manage for macs
	If (OK=1)
		ARRAY TEXT:C222($aImagePaths; 0)
		DOCUMENT LIST:C474($pathname; $aImagePaths; Absolute path:K24:14+Ignore invisible:K24:16+Recursive parsing:K24:13+Recursive parsing:K24:13)
		C_LONGINT:C283($i; $k; $p)
		C_TEXT:C284($itemNum; $suffix)
		$k:=Size of array:C274($aImagePaths)
		For ($i; 1; $k)
			$p:=Position:C15("."; $aImagePaths{$i})
			If ($p>0)
				$itemNum:=Substring:C12($aImagePaths{$i}; 1; $p-1)
				$suffix:=Substring:C12($aImagePaths{$i}; $p+1)
			End if 
			
			If (False:C215)  // check existing
				QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=$itemNum)
				SEND PACKET:C103($myDoc; "ItemSpec"+"\t"+String:C10(Records in selection:C76([ItemSpec:31]))+"\t")
				
				QUERY:C277([Item:4]; [Item:4]imagePath:104=$pathname+$aImagePaths{$i})
				SEND PACKET:C103($myDoc; "count"+"\t"+String:C10(Records in selection:C76([Item:4]))+"\t"+"image"+"\t"+$aImagePaths{$i}+"\t")
				
				QUERY:C277([Item:4]; [Item:4]imagePathTn:114=$pathname+$aImagePaths{$i})
				SEND PACKET:C103($myDoc; "countTN"+"\t"+String:C10(Records in selection:C76([Item:4]))+"\t"+"TN"+"\t"+$aImagePaths{$i}+"\r")
			End if 
			
			QUERY:C277([Item:4]; [Item:4]vendorItemNum:40=$itemNum)
			If (Records in selection:C76([Item:4])=0)
				SEND PACKET:C103($myDoc; $itemNum+"\t"+"No VendorItem"+"\t"+"image"+"\t"+$aImagePaths{$i}+"\r")
			Else 
				C_LONGINT:C283($incItem; $cntItems)
				$cntItems:=Records in selection:C76([Item:4])
				SEND PACKET:C103($myDoc; $itemNum+"\t"+[Item:4]itemNum:1+"\t"+"image"+"\t"+$aImagePaths{$i}+"\t"+String:C10($cntItems)+"\r")
				FIRST RECORD:C50([Item:4])
				For ($incItem; 1; $cntItems)
					[Item:4]imagePath:104:=$pathname+$aImagePaths{$i}
					SAVE RECORD:C53([Item:4])
					NEXT RECORD:C51([Item:4])
				End for 
			End if 
		End for 
	End if 
	CLOSE DOCUMENT:C267($myDoc)
End if 
REDUCE SELECTION:C351([Item:4]; 0)