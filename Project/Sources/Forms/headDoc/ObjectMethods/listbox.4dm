C_OBJECT:C1216($obFormEvent)
$obFormEvent:=FORM Event:C1606

Case of 
	: ($obFormEvent.code=On Load:K2:1)
		Form:C1466.obSel:=ds:C1482.Document.query("taskID = :1"; [Invoice:26]idNumTask:78)
		C_OBJECT:C1216(obDocSel)
		obDocSel:=New object:C1471
		obDocSel:=Form:C1466.obSel.copy()
		
		
		
		
	: ($obFormEvent.code=On Double Clicked:K2:5)
		$obRec:=Form:C1466.obSel[$obFormEvent.row-1]
		
	: ($obFormEvent.code=On Clicked:K2:4)
		C_TEXT:C284($vtPath)
		C_OBJECT:C1216($obRec)
		If ($obFormEvent.row#Null:C1517)
			$obRec:=Form:C1466.obSel[$obFormEvent.row-1]
			$vtPath:=$obRec.path
			En_ShowImage($vtPath; ->vItemPict)
			
		End if 
		
	: ($obFormEvent.code=On Column Moved:K2:30)
		
		
	: ($obFormEvent.code=On Column Resize:K2:31)
		
		
	: ($obFormEvent.code=On Drop:K2:12)
		C_OBJECT:C1216(obDocRec; obSel)
		ARRAY TEXT:C222($atDocs; 0)
		C_TEXT:C284($vfileArray)
		C_LONGINT:C283($n)
		$n:=1
		Repeat 
			$vfileArray:=Get file from pasteboard:C976($n)
			If ($vfileArray#"")
				APPEND TO ARRAY:C911($atDocs; $vfileArray)
				$n:=$n+1
			End if 
		Until ($vfileArray="")
		
		
		
End case 
