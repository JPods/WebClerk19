C_OBJECT:C1216($obFormEvent)
C_OBJECT:C1216(obSel)
C_OBJECT:C1216(docList)
$obFormEvent:=FORM Event:C1606

Case of 
	: ((Form event code:C388=On Load:K2:1) | (FORM Event:C1606.description="On Load"))
		If (process_o.cur.idNumTask=Null:C1517)
			LB_Document.ents:=ds:C1482.Document.query("customerID = :1 & idNumTask < 9"; process_o.cur.customerID)
		Else 
			LB_Document.ents:=ds:C1482.Document.query("idNumTask = :1"; process_o.cur.idNumTask)
		End if 
	: ((Form event code:C388=On Drop:K2:12) | (FORM Event:C1606.description="On Dropped"))
		SFEX_DropDocument
	: (Form event code:C388=-101)
		
		
		//SFEX_DropDocument
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		
	: ((Form event code:C388=On Clicked:K2:4) | (FORM Event:C1606.description="On Clicked"))
		
		
		If (LB_Document.cur=Null:C1517)
			ConsoleMessage("LB_Document.cur: null")
			//LB_Document.cur:=LB_Document.ents[FORM Event.row-1]
			// pathDoc_t:=LB_Document.cur.path
			pathDoc_t:=""
			CLEAR VARIABLE:C89(imageDoc_p)
			//ConsoleMessage("pathBase: "+pathDoc_t)
			//En_ShowImage(pathDoc_t; ->imageDoc_p)
		Else 
			pathDoc_t:=LB_Document.cur.path
			ConsoleMessage("pathBase: "+pathDoc_t)
			pathDoc_t:=Replace string:C233(pathDoc_t; "/Applications/4D v18 R5/"; "")
			var imageDoc_p : Picture
			En_ShowImage(pathDoc_t; ->imageDoc_p)
			
			If (False:C215)
				// if path is empty it requests an image
				IE_GetPict(pathDoc_t; ->vItemPict)
			End if 
			//var $empty_b : Blob
			//BLOB TO PICTURE($empty_b; imageDoc_p)
		End if 
	: (Form event code:C388=On Column Moved:K2:30)
		
		
	: (Form event code:C388=On Column Resize:K2:31)
		
	: (FORM Event:C1606.row>0)
		ConsoleMessage("LB_Document.cur: null")
		LB_Document.cur:=LB_Document.ents[FORM Event:C1606.row-1]
		pathDoc_t:=LB_Document.cur.path
		ConsoleMessage("pathBase: "+pathDoc_t)
		En_ShowImage(pathDoc_t; ->imageDoc_p)
End case 
