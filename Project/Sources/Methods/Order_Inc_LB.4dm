//%attributes = {}

// Modified by: Bill James (2021-12-18T06:00:00Z)
// Method: Order_Inc_LB
// Description Kirk lesson/2020/06/25/
// 
// Parameters
// ----------------------------------------------------

var $1; $lb_name : Text
var $o : Object
$lb_name:=Current method name:C684

Case of 
	: (Form:C1466=Null:C1517)
		// this method only works in the context of a form
	: (Count parameters:C259=0)  //  
		$o:=Form:C1466[$lb_name]  // get our listbox object from Form
		If ($o.meta#Null:C1517)  // check it's defined
			Case of 
				: (This:C1470.actionBy="")
					$0:=$o.meta[1]
				: (This:C1470.actionBy="D@")
					$0:=$o.meta[2]
				Else   // return our default format
					$0:=$o.meta[0]
			End case 
		End if 
		
	: ($1="doSearch")
		
		$o:=Form:C1466[$lb_name]
		$o.search:=Get edited text:C655
		$o.data:=$o.source.query("actionBy = :1 "; $o.search+"@").orderBy("actionBy asc")
		
	: ($1="init")
		$o:=New object:C1471("name"; "[$lb_name]")
		$o.data:=Null:C1517
		$o.cur:=Null:C1517
		$o.pos:=Null:C1517
		$o.sel:=Null:C1517
		// $o.meta:=New collection
		// this needs to be predefined. Create standards and keep them in the Resources
		// this is overridden if any of the other style features of the property dialog are chosen. 
		
		$o.meta:=New collection:C1472  // meta expression object 
		$o.meta.push(New object:C1471(\
			"stroke"; "automatic"; \
			"fill"; "automatic"; \
			"fontStyle"; "normal"; \
			"fontWeight"; "bold"; \
			"textDecoration"; "normal"))
		
		//  [1] will underline the text
		$o.meta.push(New object:C1471(\
			"stroke"; "dodgerblue"; \
			"fill"; "automatic"; \
			"fontStyle"; "normal"; \
			"fontWeight"; "normal"; \
			"textDecoration"; "underline"))
		
		//[2] will make the text red and italic
		$o.meta.push(New object:C1471(\
			"stroke"; "#ff0000"; \
			"fill"; "automatic"; \
			"fontStyle"; "italic"; \
			"fontWeight"; "normal"; \
			"textDecoration"; "normal"))
		
		
		var $source_o : Object
		$source_o:=ds:C1482.Order.all().orderBy("actionBy asc")
		$o.source:=$source_o
		$o.data:=$source_o
		
		Form:C1466[$lb_name]:=$o
		
		
		If (False:C215)
			If ($o.meta#Null:C1517)  // check it's defined
				
				Case of 
					: (This:C1470.actionBy="")
						$0:=$o.meta[1]
					: (This:C1470.actionBy="D@")
						$0:=$o.meta[2]
					Else   // return our default format
						$0:=$o.meta[0]
				End case 
			End if 
		End if 
End case 


