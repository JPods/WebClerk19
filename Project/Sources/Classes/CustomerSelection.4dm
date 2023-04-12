Class extends EntitySelection

//https://vimeo.com/724419680  min 50:38
// use 
// if it were to a query for selection, it is better to run on the server
//     see the CustomerSelection extention
// use local to run only on the local machine

Function get actionToday()->$sel : cs:C1710.CustomerSelection
	$sel:=This:C1470.query("actionDate = :1"; Current date:C33)
	
Function get actionDate($date : Date)->$sel : cs:C1710.CustomerSelection
	If ($date=!00-00-00!)
		$date:=Current date:C33
	End if 
	$sel:=This:C1470.query("actionDate = :1"; $date)
	
Function get actionDateRange($date1 : Date; $date2 : Date)->$sel : cs:C1710.CustomerSelection
	Case of 
		: (Count parameters:C259=0)
			$date1:=Current date:C33
			$date2:=Current date:C33
		: (Count parameters:C259=1)
			$date2:=$date1
	End case 
	If ($date2<$date1)
		$date2:=$date1
	End if 
	$sel:=This:C1470.query("actionDate >= :1 and  actionDate <= :2"; $date1; $date2)
	
	// switch to event object field
	// setup how to call an orderBy
	//Function orderBy year($event : Object)->$result : Text
	//If ($event.descending)
	//$result:="Creation_Date desc"
	//Else 
	//$result:="Creation_Date asc"
	//End if 
	
	