Class extends Entity

//https://vimeo.com/724419680 50:33
// min 54:00  should these be in CustomerSelection class extension???
// use 
// if it were to a query for selection, it is better to run on the server
//     see the CustomerSelection extention
// use local to run only on the local machine
//   see CustomerEntity

local Function get addressString->$addressMail : Text
	$addressMail:=This:C1470.company+", "+((This:C1470.address1+", ")*(Num:C11(This:C1470.address1#"")))\
		+((This:C1470.address2+", ")*(Num:C11(This:C1470.address2#"")))\
		+This:C1470.city+", "+This:C1470.state+"  "+This:C1470.zip\
		+((", "+This:C1470.country)*(Num:C11(This:C1470.country#"")))
	
local Function get addressOnly->$addressOnly : Text
	$addressOnly:=((This:C1470.address1+Char:C90(Carriage return:K15:38))*(Num:C11(This:C1470.address1#"")))\
		+((This:C1470.address2+Char:C90(Carriage return:K15:38))*(Num:C11(This:C1470.address2#"")))\
		+This:C1470.city+", "+This:C1470.state+"  "+This:C1470.zip\
		+((Char:C90(Carriage return:K15:38)+This:C1470.country)*(Num:C11(This:C1470.country#"")))
	
	
local Function get addressMail->$addressMail : Text
	$addressMail:=This:C1470.company+Char:C90(Carriage return:K15:38)+((This:C1470.address1+Char:C90(Carriage return:K15:38))*(Num:C11(This:C1470.address1#"")))\
		+((This:C1470.address2+Char:C90(Carriage return:K15:38))*(Num:C11(This:C1470.address2#"")))\
		+This:C1470.city+", "+This:C1470.state+"  "+This:C1470.zip\
		+((Char:C90(Carriage return:K15:38)+This:C1470.country)*(Num:C11(This:C1470.country#"")))
	
	
	// Alias attention Customer.company
	
	
	// HOWTO:Alias  minute 1:02
	
local Function get year->$year : Integer
	$year:=Year of:C25(This:C1470.actionDate)
	
	
/*
Example code to use the following was
		$invoice:=ds.Invoice.query("Customer.company = "a@" and year= 2018"; \
				new object("queryPlan"; true))
*/
Function query year($event : Object)->$result : Object
	var $operator : Text
	var $year : Integer
	var $from : Date
	var $to : Date
	var $query : Text
	
	$operator:=$event.operator
	$year:=Num:C11($event.value)
	$from:=Add to date:C393(!00-00-00!; $year; 1; 1)
	$to:=Add to date:C393(!00-00-00!; $year; 12; 31)
	
	Case of 
		: ($operator="==")
			$query:="dateOpened >= :1 and dateOpened <= :2"
		: ($operator=">")
			$query:="dateOpened > :2"
		: ($operator=">=")
			$query:="dateOpened >= :1"
		: ($operator="<")
			$query:="dateOpened < :1"
		: ($operator="<=")
			$query:="dateOpened <= :2"
	End case 
	$parameters:=New collection:C1472($from; $to)
	$result:=New object:C1471("query"; $query; "parameters"; $parameters)
	
	
	