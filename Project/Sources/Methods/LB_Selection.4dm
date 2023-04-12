//%attributes = {}

// Modified by: Bill James (2022-07-19T05:00:00Z)
// Method: LB_Selection
// Description 
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $lb_name)
C_OBJECT:C1216($0; $o)
// this is the same as the listbox
$lb_name:=Current method name:C684

Case of 
	: (Form:C1466=Null:C1517)
		// this method only works in the context of a form
	: (Count parameters:C259=0)  //  
		$o:=Form:C1466[$lb_name]  // get our listbox object from Form
		
		If ($o.meta#Null:C1517)  // check it's defined
			
			Case of 
				: (This:C1470.actionBy="Omie@")
					$0:=$o.meta[1]
				: (This:C1470.actionBy="Ced@")
					$0:=$o.meta[2]
				: (This:C1470.actionBy="Mat@")
					$0:=$o.meta[3]
				: (This:C1470.actionBy="Dal@")
					$0:=$o.meta[4]
				: (This:C1470.actionBy="Cam@")
					$0:=$o.meta[5]
				: (This:C1470.actionBy="Daw@")
					$0:=$o.meta[6]
				Else   // return our default format
					$0:=$o.meta[0]
			End case 
		End if 
		
	: ($1="init")
		//https://doc.4d.com/4Dv19R5/4D/19-R5/Colors.302-5831645.en.html
		//$o:=New object("name"; $lb_name)
		$o:=New object:C1471("meta"; New collection:C1472)
		
		
		$o.meta:=New collection:C1472  // meta expression object 
		$o.meta.push(New object:C1471(\
			"stroke"; "automatic"; \
			"fill"; "automatic"; \
			"fontStyle"; "normal"; \
			"fontWeight"; "normal"; \
			"textDecoration"; "normal"))
		
		//  [1] will underline the text
		$o.meta.push(New object:C1471(\
			"stroke"; "red"; \
			"fill"; "automatic"; \
			"fontStyle"; "normal"; \
			"fontWeight"; "normal"; \
			"textDecoration"; "underline"))
		
		//[2] will make the text red and italic
		$o.meta.push(New object:C1471(\
			"stroke"; "automatic"; \
			"fill"; "yellow"; \
			"fontStyle"; "normal"; \
			"fontWeight"; "normal"; \
			"textDecoration"; "normal"))
		
		//[3] will make the text red and italic
		$o.meta.push(New object:C1471(\
			"stroke"; "dark gray"; \
			"fill"; "automatic"; \
			"fontStyle"; "normal"; \
			"fontWeight"; "normal"; \
			"textDecoration"; "normal"))
		
		//[4] will make the text red and italic
		$o.meta.push(New object:C1471(\
			"stroke"; "blue"; \
			"fill"; "automatic"; \
			"fontStyle"; "normal"; \
			"fontWeight"; "normal"; \
			"textDecoration"; "normal"))
		
		//[5] will make the text red and italic
		$o.meta.push(New object:C1471(\
			"stroke"; "green"; \
			"fill"; "automatic"; \
			"fontStyle"; "normal"; \
			"fontWeight"; "normal"; \
			"textDecoration"; "normal"))
		
		//[6] will make the text red and italic -- Dawn
		$o.meta.push(New object:C1471(\
			"stroke"; "brown"; \
			"fill"; "automatic"; \
			"fontStyle"; "normal"; \
			"fontWeight"; "normal"; \
			"textDecoration"; "normal"))
		
		Form:C1466[$lb_name].meta:=$o.meta
		
		//$o.source:=ds.Customer.all().orderBy("nameLast asc")
		
		//$o.ents:=$o.source  // populate the entity list 
		
		
	: ($1="doSearch")
		$o:=Form:C1466[$lb_name]
		
		$o.search:=Get edited text:C655
		
		$o.ents:=$o.source.query("nameLast = :1 "; $o.search+"@").orderBy("nameLast asc")
		
		
		
End case 
