//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/15/19, 13:02:10
// ----------------------------------------------------
// Method: jsonListToMapObject
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_POINTER:C301($1; $ptObject)

C_TEXT:C284($2; $tableName)
C_TEXT:C284($3; $fieldlist)


$ptObject:=$1
$tableName:=$2
$fieldlist:=$3

ARRAY TEXT:C222($atFieldNames; 0)
ARRAY TEXT:C222($atNamesFound; 0)
ARRAY TEXT:C222($atMapNames; 0)
ARRAY POINTER:C280($atPtFields; 0)
C_LONGINT:C283($p)

C_OBJECT:C1216($voTemplate)

GET TEXT KEYWORDS:C1141($fieldlist; $atFieldNames)

// ### bj ### 20190109_0909 not sure if this is a good idea
// may be best to do it where mapping is the sole purpose
$cntRay:=Size of array:C274($atFieldNames)  // for mapping names in jsons
For ($incRay; 1; $cntRay)
	$p:=Position:C15(":"; $atFieldNames{$incRay})
	If ($p>1)
		APPEND TO ARRAY:C911($atMapNames; Substring:C12($atFieldNames{$incRay}; $p+1))
		$atFieldNames{$incRay}:=Substring:C12($atFieldNames{$incRay}; 1; $p-1)
	Else 
		APPEND TO ARRAY:C911($atMapNames; $atFieldNames{$incRay})
	End if 
	OB SET:C1220($voTemplate; $atFieldNames{$incRay}; $atMapNames{$incRay})  // build name:pointer to field into template
End for 

OB SET:C1220($ptObject->; $tableName; $voTemplate)
