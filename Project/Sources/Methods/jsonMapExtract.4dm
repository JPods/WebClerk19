//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/16/19, 09:01:53
// ----------------------------------------------------
// Method: jsonMapExtract
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tablename)
C_POINTER:C301($2; $ptaFieldNames; $3; $ptaMapNames; $4; $ptaFieldNums)
C_TEXT:C284($5; $vtCommand)
$tablename:=$1
$ptaFieldNames:=$2
$ptaMapNames:=$3
$ptaFieldNums:=$4
// make it so there can be different maps for different commands
C_TEXT:C284($vtMapName)
$vtMapName:=$tablename
// ### bj ### 20190228_2242
// if a command is passed, add it to the map extractor
If (Count parameters:C259>4)
	If ($5="")
		// ignore if empty
	Else 
		If ($vtCommand#"")
			$vtCommand:=$5
			$vtMapName:=$vtCommand
		End if 
	End if 
End if 

C_LONGINT:C283($tableNum)
$tableNum:=STR_GetTableNumber($tableName)

ARRAY TEXT:C222($atFieldNames; 0)  // send this out so it is easier to read is map is not the same
ARRAY TEXT:C222($atMapNames; 0)
ARRAY LONGINT:C221($alFieldNums; 0)

C_BOOLEAN:C305($vbFound)
C_LONGINT:C283($error)
$error:=1
C_OBJECT:C1216($obMap; $obGeneral)
ARRAY OBJECT:C1221($aObTemp; 0)
$obGeneral:=[SyncRelation:103]obGeneral:53
$obMap:=OB Get:C1224($obGeneral; "maps")
// select the map set to use


Case of 
	: ([SyncRelation:103]partnerNumber:14=1)
		// $obPartner:=OB Get($obMap;"Partner1")
		OB GET ARRAY:C1229($obMap; "Partner1"; $aObTemp)
	: ([SyncRelation:103]partnerNumber:14=2)
		OB GET ARRAY:C1229($obMap; "Partner2"; $aObTemp)
	Else 
		ALERT:C41("Partner not 1 or 2")
		$error:=-1
End case 
If ($error>-1)
	// ### bj ### 20190228_1314  read multiple tablename-commands, so items for customers, vendors, partners, etc....
	C_LONGINT:C283($incRay; $cntRay)
	$cntRay:=Size of array:C274($aObTemp)
	If ($cntRay>0)  // loop through to find if there is a matching table map
		For ($incRay; 1; $cntRay)
			OB GET PROPERTY NAMES:C1232($aObTemp{$incRay}; $atNames; $aiTypes)
			$cnt2:=Size of array:C274($atNames)
			If ($cnt2>0)
				// ### bj ### 20190228_1310
				If ($atNames{1}=$vtMapName)
					$obElement:=$aObTemp{$incRay}
					$obMap:=OB Get:C1224($obElement; $vtMapName; Is object:K8:27)
					$vbFound:=True:C214
					$incRay:=$cntRay
				End if 
			End if 
		End for 
	End if 
	
	If (Not:C34($vbFound))  // check if there is a standard map
		C_LONGINT:C283($fia)
		$fia:=Find in array:C230(<>atMapTables; $tableName)
		If ($fia>0)
			$obMap:=<>aobMapFields{$fia}
			$vbFound:=True:C214
		End if 
	End if 
	
	If ($vbFound)  // parse the map
		C_POINTER:C301($ptArrayFields)
		$ptArrayFields:=Get pointer:C304("<>a"+$tableName+"_FL")
		$cntRay:=Size of array:C274($ptArrayFields->)
		C_OBJECT:C1216($obField)
		C_TEXT:C284($vtMappedField)
		C_LONGINT:C283($typeFld; $lenField)
		C_BOOLEAN:C305($indexed; $isUnique; $isInvisible)
		For ($incRay; 1; $cntRay)
			$vtMappedField:=""
			$vtMappedField:=OB Get:C1224($obMap; $ptArrayFields->{$incRay})
			If ($vtMappedField#"")  // check the fields in sequence from the master field array
				GET FIELD PROPERTIES:C258($tableNum; $incRay; $typeFld; $lenField; $indexed; $isUnique; $isInvisible)  // file #, field #, type, length, index
				If (($typeFld=Is picture:K8:10) | ($typeFld=Is BLOB:K8:12))  // no blobs or pictures
					If (<>viDebugMode=411)
						ConsoleMessage("No Picture or Blobs in jsons: "+$atFieldNames{$incRay})
					End if 
				Else 
					APPEND TO ARRAY:C911($atFieldNames; $ptArrayFields->{$incRay})
					APPEND TO ARRAY:C911($atMapNames; $vtMappedField)
					APPEND TO ARRAY:C911($alFieldNums; $incRay)
				End if 
			End if 
		End for 
		If (Size of array:C274($atFieldNames)>0)
			COPY ARRAY:C226($atFieldNames; $ptaFieldNames->)
			COPY ARRAY:C226($atMapNames; $ptaMapNames->)
			COPY ARRAY:C226($alFieldNums; $ptaFieldNums->)
		End if 
	End if 
End if 