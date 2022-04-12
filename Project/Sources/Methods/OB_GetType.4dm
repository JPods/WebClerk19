//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/20/19, 16:24:52
// ----------------------------------------------------
// Method: OB_GetType
// Description
// 
//
// Parameters
// ----------------------------------------------------


// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_LONGINT:C283($0; $viType)

C_OBJECT:C1216($1; $voObject)
$voObject:=$1

C_TEXT:C284($2; $vtKey)
$vtKey:=$2

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_LONGINT:C283($viCounter)
C_TEXT:C284($vtKey)
ARRAY TEXT:C222($atValue; 0)
ARRAY REAL:C219($arValue; 0)
C_TEXT:C284($vtJSON)
$vtJSON:=JSON Stringify:C1217($voObject)


// ******************************************************************************************** //
// ** LOOP THROUGH KEYS AND MERGE EACH ONE DOWN INTO BASE, OVERWRITING IF DUPLICATE *********** //
// ******************************************************************************************** //

$viType:=OB Get type:C1230($voObject; $vtKey)

If ($viType=Object array:K8:28)
	
	$viKeyPos:=Position:C15($vtKey; $vtJSON)+Length:C16($vtKey)+3
	
	Case of 
			
		: (Substring:C12($vtJSON; $viKeyPos; 1)="]")
			
			// EMPTY, UNKNOWN
			
		: (Substring:C12($vtJSON; $viKeyPos; 4)="null")
			
			$viType:=Pointer array:K8:23
			
		: (Substring:C12($vtJSON; $viKeyPos; 1)="\"")
			
			OB GET ARRAY:C1229($voObject; $vtKey; $atValue)
			
			Case of 
					
				: ($atValue{1}="[object Object]")
					
					// POINTER
					
					$viType:=Pointer array:K8:23
					
				: ((Substring:C12($atValue{1}; 5; 1)="-") & (Substring:C12($atValue{1}; 8; 1)="-") & (Substring:C12($atValue{1}; 11; 1)="T"))
					
					// DATE
					
					$viType:=Date array:K8:20
					
				Else 
					
					// TEXT
					
					$viType:=Text array:K8:16
					
			End case 
			
		: (Substring:C12($vtJSON; $viKeyPos; 1)="{")
			
			// OBJECT
			
			$viType:=Object array:K8:28
			
		: ((Substring:C12($vtJSON; $viKeyPos; 4)="true") | (Substring:C12($vtJSON; $viKeyPos; 5)="false"))
			
			// BOOLEAN
			
			$viType:=Boolean array:K8:21
			
		Else 
			
			// REAL OR INT
			
			OB GET ARRAY:C1229($voObject; $vtKey; $arValue)
			
			For ($viCounter; 1; Size of array:C274($arValue))
				
				$viType:=LongInt array:K8:19
				
				If (Round:C94($arValue{$viCounter}; 0)#$arValue{$viCounter})
					
					$viType:=Real array:K8:17
					
				End if 
				
			End for 
			
	End case 
	
End if 


// ******************************************************************************************** //
// ** RETURN THE MERGED OBJECT **************************************************************** //
// ******************************************************************************************** //

$0:=$viType