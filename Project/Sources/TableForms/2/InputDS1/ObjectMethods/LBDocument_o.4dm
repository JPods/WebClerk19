C_OBJECT:C1216($obFormEvent)
C_OBJECT:C1216(obSel)
C_OBJECT:C1216(docList)
$obFormEvent:=FORM Event:C1606

If (<>viDebugMode>410)
	ConsoleMessage("evt_description: "+$obFormEvent.description+", row: "+String:C10($obFormEvent.row))
End if 

Case of 
	: ($obFormEvent.code=On Load:K2:1)
		
		
	: ($obFormEvent.code=On Drop:K2:12)
		
		ARRAY TEXT:C222($atDocs; 0)
		$n:=1
		Repeat 
			$vfileArray:=Get file from pasteboard:C976($n)
			If ($vfileArray#"")
				APPEND TO ARRAY:C911($atDocs; $vfileArray)
				$n:=$n+1
			End if 
		Until ($vfileArray="")
		C_OBJECT:C1216($obRec)
		// ent_LBDocument:=Form.obSel.copy()
		
		// should already be loaded
		// ent_LBDocument:=ds.Document.query("customerID = :1 and tableNum = :2"; entryEntity.customerID; 2)
		
		If ((<>pathServer="") & (<>vtShareName#""))
			PathSetServer
			If (<>pathServer="")
				ALERT:C41("ShareName "+<>vtShareName+" is not available. Saving local only.")
			End if 
		End if 
		C_TEXT:C284($theFolder)  //get the desired folder
		$theFolder:=Path_CustomerTask
		
		
		C_TEXT:C284($vtPathToUse)
		C_LONGINT:C283($inc; $cnt; $viNum)
		$cnt:=Size of array:C274($atDocs)
		For ($inc; 1; $cnt)
			$viNum:=$viNum+1
			$obRec:=ds:C1482.Document.new()
			
			$vtPathToUse:=""
			ARRAY TEXT:C222($atPath; 0)
			TextToArray($atDocs{$inc}; ->$atPath; <>VFOLDERDELIMITER)
			If (<>pathServer#"")
				$vtPathToUse:=$theFolder+$atPath{Size of array:C274($atPath)}
				$obRec.path:=PathtoUniversal($vtPathToUse)
				COPY DOCUMENT:C541($atDocs{$inc}; $vtPathToUse; *)
			Else 
				$obRec.path:=PathtoUniversal($atDocs{$inc})
			End if 
			$obRec.dateEntered:=Current date:C33
			$obRec.dtEvent:=jDateTimeEnter
			$obRec.idNumTask:=0
			$obRec.customerID:=[Customer:2]customerID:1
			$obRec.tableNum:=2
			
			$obRec.title:=$atPath{Size of array:C274($atPath)}
			$obRec.description:=$obRec.title+"-"+String:C10($viCnt)+"-"+[Customer:2]company:2
			$result_o:=$obRec.save()
		End for 
		// Form.obSel:=ds.Document.query("customerID = :1 and tableNum = :2"; entryEntity.customerID; 2)
		ent_LBDocument:=ds:C1482.Document.query("customerID = :1 and tableNum = :2"; [Customer:2]customerID:1; 2)
		C_OBJECT:C1216(obDocSel)
		
		
		
	: ($obFormEvent.code=On Double Clicked:K2:5)
		
		
		
		
	: ($obFormEvent.code=On Clicked:K2:4)
		If (ent_LBDocument_cur#Null:C1517)
			$vtPath:=ent_LBDocument_cur.path
			En_ShowImage($vtPath; ->vItemPict)
		Else 
			CLEAR VARIABLE:C89(vItemPict)
		End if 
	: ($obFormEvent.code=On Column Moved:K2:30)
		
		
	: ($obFormEvent.code=On Column Resize:K2:31)
		
End case 
