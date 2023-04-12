//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/07/11, 16:32:02
// ----------------------------------------------------
// Method: ImportMaps
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $2; $sendData; $direction)
If (Count parameters:C259=2)
	$sendData:=$1
	$direction:=$2
End if 

C_TEXT:C284($myTextVar; $textBulk; $textWorking)
C_TIME:C306(myDoc)
C_TEXT:C284($xml_Struct_Ref)
C_LONGINT:C283($error)
CREATE RECORD:C68([TallyResult:73])

$resetbEDIPass:=allowAlerts_boo
allowAlerts_boo:=False:C215
$dtItemImport:=DateTime_DTTo(Current date:C33; Current time:C178)
$myOK:=UTLoadDoc2Array(""; ->aText1)
If (Size of array:C274(aText1)>0)
	XMLArrayManagement(0)
	ARRAY TEXT:C222($aFieldName; 0)
	ARRAY TEXT:C222($aXTag; 0)
	ARRAY LONGINT:C221($aTableNum; 0)
	ARRAY LONGINT:C221($aFieldNum; 0)
	ARRAY TEXT:C222($aValues; 0)
	$mapName:="OSAImport"
	QUERY:C277([Map:84]; [Map:84]name:6=$mapName)
	SELECTION TO ARRAY:C260([Map:84]controllingTag:1; aXMLTag; [Map:84]fieldName:17; aXMLField; [Map:84]fieldNum:16; aXMLFieldNum; [Map:84]tableNum:15; aXMLTableNum; [Map:84]script:4; aXMLAction)
	$cntFields:=Size of array:C274(aXMLTag)
	XMLArrayManagement($cntFields)
	For ($incFields; 1; $cntFields)
		aXMLTable{$incFields}:=WccTableName(aXMLTableNum{$incFields})
	End for 
	ARRAY TEXT:C222($aValues; $cntFields)
	
	C_LONGINT:C283($incFields; $cntFields; $inArray)
	C_LONGINT:C283($incValues; $cntValues)
	//
	UTWorkingTextFromArray(->vText1; ->aText1; 15050)
	$tagName:="\r"
	$tagLength:=Length:C16($tagName)
	$foundTagBegin:=Position:C15($tagName; vText1)
	$textWorking:=Substring:C12(vText1; 1; $foundTagBegin-1)
	vText1:=Substring:C12(vText1; $foundTagBegin+1)
	//
	TextToArray($textWorking; ->aText10; "\t")  //list of headers
	$cntValues:=Size of array:C274(aText10)
	ARRAY LONGINT:C221($aElementNum; $cntValues)
	For ($incValues; 1; $cntValues)
		$w:=Find in array:C230(aXMLTag; aText10{$incValues})
		$aElementNum{$incValues}:=$w
		If ($w<1)
			$w:=Size of array:C274(aXMLTag)+1
			XMLArrayManagement(-3; $w; 1)
		End if 
		aXMLTag{$w}:=aText10{$incValues}
	End for 
	//
	$foundTagBegin:=Position:C15($tagName; vText1)
	//
	//  --  CHOPPED  AL_UpdateArrays(eHttpEdit; -2)
	
	
	
End if 