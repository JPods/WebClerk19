//%attributes = {"shared":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/12/21, 02:06:13
// ----------------------------------------------------
// Method: 00_Orderlines_LB
// Description
// https://4dmethod.com/2020/06/25/june-30-meeting-modularizing-collection-and-entity-selection-list-boxes-kirk-brooks-guy-algot/
// Parameters
// ----------------------------------------------------
If (False:C215)
	// use thisinthe form method
	// minute 45
	Case of 
		: (Form event code:C388=On Load:K2:1)
			00_Orderlines_LB("init")
	End case 
End if 

var $1; $lb_name : Text
var $o : Object
$lb_name:=Current method name:C684
Case of 
	: (Form:C1466=Null:C1517)
		// this method only works in the context of a form
	: (Count parameters:C259=0)
		$o:=Form:C1466[$lb_name]  // get our listbox from the Form
		
		If ($o.meta=Null:C1517)
			Case of 
				: (This:C1470.name="Kirk")
					$0:=$o.meta[1]
				: (This:C1470.name="J@")
					$0:=$o.meta[2]
				Else 
					$0:=$o.meta[0]  //set default
			End case 
		End if 
		
	: ($1="init")
		
		If (False:C215)  // progressed from to $o
			Form:C1466.Orderlines_LB:=New object:C1471("name"; "Orderlines_LB")
			Form:C1466.Orderlines_LB.date:=Null:C1517
			Form:C1466.Orderlines_LB.curItem:=Null:C1517
			Form:C1466.Orderlines_LB.pos:=Null:C1517
			Form:C1466.Orderlines_LB.selected:=Null:C1517
			Form:C1466.Orderlines_LB.meta:=New object:C1471
			
			Form:C1466[$lb_name]:=New object:C1471("name"; "Orderlines_LB")
			Form:C1466[$lb_name].date:=Null:C1517
			Form:C1466[$lb_name].curItem:=Null:C1517
			Form:C1466[$lb_name].pos:=Null:C1517
			Form:C1466[$lb_name].selected:=Null:C1517
			Form:C1466[$lb_name].meta:=New object:C1471
		End if 
		
		$o:=New object:C1471("name"; "Orderlines_LB")
		$o.date:=Null:C1517
		$o.curItem:=Null:C1517
		$o.pos:=Null:C1517
		$o.selected:=Null:C1517
		$o.meta:=New object:C1471
		
		
		
End case 


// minute 48:  Define styles within an object