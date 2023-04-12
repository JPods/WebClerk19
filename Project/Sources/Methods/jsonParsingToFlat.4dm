//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/07/18, 01:49:11
// ----------------------------------------------------
// Method: jsonParsingToFlat
// Description
// 
//  json stringify(json;*)
// Parameters
// ----------------------------------------------------


C_OBJECT:C1216($1)
C_TEXT:C284($2; $firstLevel)
If (Count parameters:C259=2)
	vlObjLevel:=0
End if 
C_LONGINT:C283(vlObjLevel)
If (vlObjLevel=0)
	ARRAY TEXT:C222(atHeaders; 0)  // accumulate in this array
	ARRAY TEXT:C222(avValue; 0)
	ARRAY LONGINT:C221(alLevel; 0)
End if 
vlObjLevel:=vlObjLevel+1

C_OBJECT:C1216($voBatch; $voHeader; $voOrders; $voInvoices; $voCustomers)
C_TEXT:C284($vtTest; $vtValue)
C_LONGINT:C283($vi1)

C_TEXT:C284($vtOutput)
C_OBJECT:C1216($voBatch)
$voBatch:=$1

ARRAY OBJECT:C1221($aoObjectsTemp; 0)
ARRAY TEXT:C222($atNames; 0)
ARRAY LONGINT:C221($aiTypes; 0)
C_TEXT:C284($vtValue)

OB GET PROPERTY NAMES:C1232($voBatch; $atNames; $aiTypes)

// Console_Log ($atNames{1})

For ($vi1; 1; Size of array:C274($atNames))
	// Console_Log ($atNames{$vi1})
	$viType:=OB Get type:C1230($voBatch; $atNames{$vi1})
	If ($viType=Object array:K8:28)  //  39) 
		OB GET ARRAY:C1229($voBatch; $atNames{$vi1}; $aoObjectsTemp)
		APPEND TO ARRAY:C911(avValue; "")  //  Put name but no values in at the level 
		APPEND TO ARRAY:C911(atHeaders; $atNames{$vi1})
		APPEND TO ARRAY:C911(alLevel; -vlObjLevel)
		//  jsonParsingToFlat ($aoObjectsTemp)
		
		
		APPEND TO ARRAY:C911(avValue; "")
		APPEND TO ARRAY:C911(atHeaders; "")
		APPEND TO ARRAY:C911(alLevel; -2222)
	Else 
		Case of 
			: (($viType=Is real:K8:4) | ($viType=Is longint:K8:6) | ($viType=Is integer 64 bits:K8:25) | ($viType=_o_Is float:K8:26) | ($viType=Is date:K8:7) | ($viType=Is time:K8:8))
				$vtValue:=String:C10(OB Get:C1224($voBatch; $atNames{$vi1}; $viType))
			: ($viType=Is boolean:K8:9)
				$vtValue:=String:C10(Num:C11(OB Get:C1224($voBatch; $atNames{$vi1}; $viType)))
			Else 
				$vtValue:=OB Get:C1224($voBatch; $atNames{$vi1}; $viType)  // get the actual value
		End case 
		APPEND TO ARRAY:C911(avValue; $vtValue)
		APPEND TO ARRAY:C911(atHeaders; $atNames{$vi1})
		APPEND TO ARRAY:C911(alLevel; vlObjLevel)
		
		// $vtOutput:=$vtOutput+"\r"+("\t"*vLevel)+$atNames{$vi1}
	End if 
End for 



vlObjLevel:=vlObjLevel-1

If (vlObjLevel=0)
	C_TEXT:C284($vtDump)
	C_LONGINT:C283($incRay; $cntRay)
	$cntRay:=Size of array:C274(avValue)
	For ($incRay; 1; $cntRay)
		Case of 
			: (alLevel{$incRay}=-2222)
				$vtDump:=$vtDump+"\r"
			: (alLevel{$incRay}<0)
				alLevel{$incRay}:=Abs:C99(alLevel{$incRay})
				$vtDump:=$vtDump+"\r"+("\t"*alLevel{$incRay})+atHeaders{$incRay}+"       "+String:C10(alLevel{$incRay})
			Else 
				$vtDump:=$vtDump+"\r"+("\t"*alLevel{$incRay})+atHeaders{$incRay}+" :-: "+avValue{$incRay}+" :-: "+String:C10(alLevel{$incRay})
		End case 
	End for 
	ARRAY TEXT:C222(atHeaders; 0)  // accumulate in this array
	ARRAY TEXT:C222(avValue; 0)
	ARRAY LONGINT:C221(alLevel; 0)
	allowAlerts_boo:=False:C215
	ConsoleLog($vtDump)
	If (allowAlerts_boo)
		ALERT:C41("json parsed to Console")
	End if 
End if 



