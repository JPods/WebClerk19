C_OBJECT:C1216($obFormEvent)
C_OBJECT:C1216(obSel)
C_OBJECT:C1216(docList)
$obFormEvent:=FORM Event:C1606

If (<>viDebugMode>410)
	ConsoleMessage("evt_description: "+$obFormEvent.description+", row: "+String:C10($obFormEvent.row))
End if 

Case of 
	: ($obFormEvent.code=On Load:K2:1)
		
		LBDocument_ent:=ds:C1482.Document.query("customerID = :1 & tableNum = :2"; [Customer:2]customerID:1; 2)
		
	: ($obFormEvent.code=On Drop:K2:12)
		If ((<>pathServer="") & (<>vtShareName#""))
			PathSetServer
			If (<>pathServer="")
				ALERT:C41("ShareName "+<>vtShareName+" is not available. Saving local only.")
			End if 
		End if 
		ARRAY TEXT:C222($atDocs; 0)
		C_TEXT:C284($theFolder)  //get the desired folder
		$theFolder:=Path_CustomerTask
		
		$n:=1
		Repeat 
			$vfileArray:=Get file from pasteboard:C976($n)
			$n:=$n+1
			If ($vfileArray#"")
				APPEND TO ARRAY:C911($atDocs; $vfileArray)
			End if 
		Until ($vfileArray="")
		C_OBJECT:C1216($obSel; $obRec)
		// $obSel:=Form.obSel.copy()
		
		$obSel:=ds:C1482.Document.query("customerID = :1 and tableNum = :2"; [Customer:2]customerID:1; 2)
		
		For each ($obRec; $obSel)  // loop thru existing and eliminate duplicates
			If ($obRec.path#"")
				$path:=PathToSystem($obRec.path)
				$found:=Find in array:C230($atDocs; $path)
				If ($found>0)
					// exists
					DELETE FROM ARRAY:C228($atDocs; $found; 1)
				End if 
			End if 
		End for each 
		//$viNum:=$obSel.length()
		
		
		C_TEXT:C284($vtPathToUse)
		C_LONGINT:C283($inc; $cnt; $viNum)
		$cnt:=Size of array:C274($atDocs)
		For ($inc; 1; $cnt)
			$viNum:=$viNum+1
			$obRec:=ds:C1482.Document.new()
			
			$vtPathToUse:=""
			ARRAY TEXT:C222($atPath; 0)
			TextToArray($atDocs{$inc}; ->$atPath; Folder separator:K24:12)
			If (<>pathServer#"")
				$vtPathToUse:=$theFolder+$atPath{Size of array:C274($atPath)}
				$obRec.path:=PathtoUniversal($vtPathToUse)
				COPY DOCUMENT:C541($atDocs{$inc}; $vtPathToUse; *)
			Else 
				$obRec.path:=PathtoUniversal($atDocs{$inc})
			End if 
			$obRec.dateEntered:=Current date:C33
			$obRec.dtEvent:=DateTime_Enter
			$obRec.idNumTask:=0
			$obRec.customerID:=[Customer:2]customerID:1
			$obRec.tableNum:=2
			
			$obRec.title:=$atPath{Size of array:C274($atPath)}
			$obRec.description:=$obRec.title+"-"+String:C10($viCnt)+"-"+[Customer:2]company:2
			$result_o:=$obRec.save()
		End for 
		// Form.obSel:=ds.Document.query("customerID = :1 and tableNum = :2"; [Customer]customerID; 2)
		$obSel:=ds:C1482.Document.query("customerID = :1 and tableNum = :2"; [Customer:2]customerID:1; 2)
		C_OBJECT:C1216(obDocSel)
		//obDocSel:=New object
		//obDocSel:=Form.obSel.copy()
		
		
	: ($obFormEvent.code=On Double Clicked:K2:5)
		C_LONGINT:C283($viRow)
		LISTBOX SELECT ROW:C912(DocRecordList; $viRow)
		
		
	: ($obFormEvent.code=On Clicked:K2:4)
		C_LONGINT:C283($viRow)
		$viRow:=$obFormEvent.row
		
		$vtPath:=LB_Document_cur.path
		En_ShowImage($vtPath; ->vItemPict)
		
		
	: ($obFormEvent.code=On Column Moved:K2:30)
		
		
	: ($obFormEvent.code=On Column Resize:K2:31)
		
End case 
