//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/18/21, 22:02:33
// ----------------------------------------------------
// Method: STR_GetTableNameList
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $vpatTableNameList)


ARRAY TEXT:C222($atTableNames; 0)
C_TEXT:C284($vtProperty)
C_OBJECT:C1216($obProperty; $obStore; $obClass)
// OB GET PROPERTY NAMES(ds;$atTableNames)
For each ($vtProperty; ds:C1482)
	If ($vtProperty#"zz@")
		APPEND TO ARRAY:C911($atTableNames; $vtProperty)
		If (False:C215)  // for reference
			$obClass:=ds:C1482[$vtProperty]
			For each ($vtPropertyInClass; $obClass)
				$obProperty:=$obClass[$vtPropertyInClass]
			End for each 
		End if 
	End if 
End for each 

COPY ARRAY:C226($atTableNames; $1->)

