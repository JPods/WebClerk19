//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/07/18, 10:38:25
// ----------------------------------------------------
// Method: jsonObjectToRecord
// Description
// This is based on WebClerk standard header and tables objects
//
// Parameters
// ----------------------------------------------------

//  If a json is coming in, first convert it to an object and pass in the object
//  $voBatch:=JSON Parse($1)

C_BOOLEAN:C305(<>vbSyncUpdates)
<>vbSyncUpdates:=True:C214

C_TEXT:C284($1; $tableName)
C_POINTER:C301($2; $ptObject)
$tableName:=$1
C_OBJECT:C1216($obData)
$obData:=$2->
// ### bj ### 20190228_2255
// account for various differences in sending data
If (Count parameters:C259>2)
	// get the command that was passed
	$vtCommand:=$3
End if 


C_POINTER:C301($ptTable)
C_LONGINT:C283($incRay; $cntRay; $fia; $tableNum)
C_LONGINT:C283($viFieldType)

C_LONGINT:C283($tableNum)
$tableNum:=STR_GetTableNumber($tableName)
$ptTable:=Table:C252($tableNum)


ARRAY TEXT:C222($atFieldNames; 0)  // will be rezeroed in jsonMapExtract list here for clarity 
ARRAY TEXT:C222($atMapNames; 0)
ARRAY LONGINT:C221($alFieldNums; 0)
jsonMapExtract($tableName; ->$atFieldNames; ->$atMapNames; ->$alFieldNums; $vtCommand)

ARRAY TEXT:C222($atNames; 0)
ARRAY LONGINT:C221($alTypes; 0)
OB GET PROPERTY NAMES:C1232($obData; $atNames; $alTypes)

C_BOOLEAN:C305($vbOK)
$vbOK:=False:C215

$fia:=Find in array:C230($atFieldNames; "id")
If ($fia<1)
	vResponse:="No id identified"
Else 
	C_TEXT:C284($vtUUIDkey)
	$vtUUIDkey:=OB Get:C1224($obData; $atMapNames{$fia})
	If ($vtUUIDkey="")
		vResponse:="id is empty."
	Else 
		QUERY:C277($ptTable->; Field:C253($tableNum; $alFieldNums{$fia})->=$vtUUIDkey)
		Case of 
			: (Records in selection:C76($ptTable->)=0)
				jsonObjectToRecord(Txt_Quoted($tableName); ->$obData)
				[SyncRecord:109]packingNotes:14:=[SyncRecord:109]packingNotes:14+"\r"+$tableName+" New record: id"+$vtUUIDkey
				$vbOK:=True:C214
			: (Records in selection:C76($ptTable->)=1)
				If (<>vbSyncUpdates)
					[SyncRecord:109]packingNotes:14:=[SyncRecord:109]packingNotes:14+"\r"+$tableName+" Updated record: id"+$vtUUIDkey
					$vbOK:=True:C214
				Else 
					vResponse:="Found existing record without permission to update."
				End if 
			Else 
				vResponse:="Found multiple id's: "+$vtUUIDkey
		End case 
	End if 
	If ($vbOK)
		$cntRay:=Size of array:C274($atNames)
		For ($incRay; 1; $cntRay)
			$fia:=Find in array:C230($atMapNames; $atNames{$incRay})
			If ($fia>0)
				$ptTable:=Field:C253($tableNum; $alFieldNums{$fia})
				$viFieldType:=Type:C295($ptTable->)
				$ptTable->:=OB Get:C1224($obData; $atNames{$incRay}; $viFieldType)
			End if 
		End for 
		SAVE RECORD:C53($ptTable->)
	End if 
End if 
