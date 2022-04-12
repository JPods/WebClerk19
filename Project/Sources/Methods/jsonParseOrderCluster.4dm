//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/03/18, 14:39:30
// ----------------------------------------------------
// Method: jsonParseOrderCluster
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1)

C_OBJECT:C1216($voBatch; $voHeader; $voOrders; $voInvoices; $voCustomers)
C_TEXT:C284($vtTest; $vtValue)
C_LONGINT:C283($vi1)

ARRAY OBJECT:C1221($aoObjects; 0)
ARRAY OBJECT:C1221($aoObjectsTemp; 0)

$voBatch:=JSON Parse:C1218($1)

ARRAY TEXT:C222($atNames; 0)
ARRAY TEXT:C222($atHeaders; 0)
ARRAY LONGINT:C221($aiTypes; 0)

OB GET PROPERTY NAMES:C1232($voBatch; $atNames; $aiTypes)

ConsoleMessage($atNames{1})

$voBatch:=OB Get:C1224($voBatch; $atNames{1}; Is object:K8:27)


//$voHeader:=OB Get($voBatch;"Header";Is object)
//$voOrders:=OB Get($voBatch;"Order";Is object)
//$voInvoices:=OB Get($voBatch;"Invoice";Is object)
//$voCustomers:=OB Get($voBatch;"Customer";Is object)

ARRAY TEXT:C222($atNames; 0)
ARRAY LONGINT:C221($aiTypes; 0)

OB GET PROPERTY NAMES:C1232($voBatch; $atNames; $aiTypes)

vi2:=Size of array:C274($atNames)
If (vi2>0)
	For ($vi1; 1; vi2)
		ConsoleMessage($atNames{$vi1})
		$viType:=OB Get type:C1230($voBatch; $atNames{$vi1})
		If ($viType=39)
			OB GET ARRAY:C1229($voBatch; $atNames{$vi1}; $aoObjectsTemp)
			
			For ($vi3; 1; Size of array:C274($aoObjectsTemp))
				APPEND TO ARRAY:C911($aoObjects; $aoObjectsTemp{$vi3})
				APPEND TO ARRAY:C911($atHeaders; $atNames{$vi1})
			End for 
			
		Else 
			
			APPEND TO ARRAY:C911($aoObjects; OB Get:C1224($voBatch; $atNames{$vi1}; $viType))
			APPEND TO ARRAY:C911($atHeaders; $atNames{$vi1})
		End if 
	End for 
	
	$viIndex:=Find in array:C230($atHeaders; "Order")
	
	ARRAY TEXT:C222($atNames; 0)
	ARRAY LONGINT:C221($aiTypes; 0)
	OB GET PROPERTY NAMES:C1232($aoObjects{$viIndex}; $atNames; $aiTypes)
	For (vi5; 1; Size of array:C274($atNames))
		ConsoleMessage($atNames{vi5}+" - "+String:C10($aiTypes{$vi5}))
	End for 
	C_LONGINT:C283($viUniqueID)
	$viUniqueID:=OB Get:C1224($aoObjects{$viIndex}; "OrderNum"; Is longint:K8:6)
	
	$vtTest:=JSON Stringify:C1217($voBatch; *)
	
	ConsoleMessage($vtTest)
	
End if 
