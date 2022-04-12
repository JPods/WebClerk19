//%attributes = {}


// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 07/18/19, 12:45:10
// ----------------------------------------------------
// Method: DistinctValues
// Description
// 
//
// Parameters
// ----------------------------------------------------


// Execute_TallyMaster("DistinctValues";"Scripts";3)


//<declarations>
//==================================
//  Type variables 
//==================================

// $abValues;$adValues;$ahValues;$aiCount;$aiFields;$aiValues;$arValues;$atFields
// $atValues;valid;variables
C_LONGINT:C283($vi1; $vi2; $vi3; $viField; $viTable; $viType; $viUserChoice)
C_TEXT:C284($vtClipboard; $vtFieldName; $vtMessage; $vtOptions)
C_POINTER:C301($vpField)

//==================================
//  Initialize variables 
//==================================

$vi1:=0
$vi2:=0
$vi3:=0
$viField:=0
$viTable:=0
$viType:=0
$viUserChoice:=0
$vtClipboard:=""
$vtFieldName:=""
$vtMessage:=""
$vtOptions:=""
//</declarations>

READ ONLY:C145(Current form table:C627->)
//ALL RECORDS(Current form table->)

ARRAY TEXT:C222($atFields; 0)
ARRAY LONGINT:C221($aiFields; 0)

$viTable:=Table:C252(Current form table:C627)

$vi2:=Get last field number:C255(Current form table:C627)
For ($viField; 1; $vi2)
	If (Is field number valid:C1000($viTable; $viField))
		$vtFieldName:=Field name:C257($viTable; $viField)
		APPEND TO ARRAY:C911($atFields; $vtFieldName)
		APPEND TO ARRAY:C911($aiFields; $viField)
	End if 
End for 

SORT ARRAY:C229($atFields; $aiFields; >)

$vtOptions:=""
For ($vi1; 1; Size of array:C274($atFields))
	$vtOptions:=$vtOptions+$atFields{$vi1}+";"
End for 

CONFIRM:C162("Get Distinct Values"; "Get Values"; "Cancel")

If (OK=1)
	
	// Open window behind popup menu
	GET MOUSE:C468(viMouseX; viMouseY; viMouseButton; *)
	viLeft:=viMousex-350
	viTop:=viMousey-180
	viRight:=viMousex+200
	viBottom:=viMousey+(60)
	Open window:C153(viLeft; viTop; viRight; viBottom; 8; "Select Field for Distinct Values")
	
	$viUserChoice:=Pop up menu:C542($vtOptions)
	
	CLOSE WINDOW:C154
	
	If ($viUserChoice>0)
		//ALERT($atFields{$viUserChoice})
		$viField:=$aiFields{$viUserChoice}
		$vpField:=Field:C253($viTable; $viField)
		GET FIELD PROPERTIES:C258($vpField; $viType)
		
		ARRAY TEXT:C222($atValues; 0)
		ARRAY LONGINT:C221($aiCount; 0)
		
		Case of 
				
			: ($viType=Is alpha field:K8:1)
				DISTINCT VALUES:C339($vpField->; $atValues; $aiCount)
				
			: ($viType=Is BLOB:K8:12)
				ALERT:C41("Can't Get Distinct Values for BLOBs")
				
			: ($viType=Is boolean:K8:9)
				ARRAY BOOLEAN:C223($abValues; 0)
				DISTINCT VALUES:C339($vpField->; $abValues; $aiCount)
				For ($vi3; 1; Size of array:C274($abValues))
					APPEND TO ARRAY:C911($atValues; String:C10($abValues{$vi3}))
				End for 
				
			: ($viType=Is date:K8:7)
				ARRAY DATE:C224($adValues; 0)
				DISTINCT VALUES:C339($vpField->; $adValues; $aiCount)
				For ($vi3; 1; Size of array:C274($adValues))
					APPEND TO ARRAY:C911($atValues; String:C10($adValues{$vi3}))
				End for 
				
			: ($viType=_o_Is float:K8:26)
				ARRAY REAL:C219($arValues; 0)
				DISTINCT VALUES:C339($vpField->; $arValues; $aiCount)
				For ($vi3; 1; Size of array:C274($arValues))
					APPEND TO ARRAY:C911($atValues; String:C10($adValues{$vi3}))
				End for 
				
			: ($viType=Is integer:K8:5)
				ARRAY LONGINT:C221($aiValues; 0)
				DISTINCT VALUES:C339($vpField->; $aiValues; $aiCount)
				For ($vi3; 1; Size of array:C274($aiValues))
					APPEND TO ARRAY:C911($atValues; String:C10($aiValues{$vi3}))
				End for 
				
			: ($viType=Is integer 64 bits:K8:25)
				ARRAY LONGINT:C221($aiValues; 0)
				DISTINCT VALUES:C339($vpField->; $aiValues; $aiCount)
				For ($vi3; 1; Size of array:C274($aiValues))
					APPEND TO ARRAY:C911($atValues; String:C10($aiValues{$vi3}))
				End for 
				
			: ($viType=Is longint:K8:6)
				ARRAY LONGINT:C221($aiValues; 0)
				DISTINCT VALUES:C339($vpField->; $aiValues; $aiCount)
				For ($vi3; 1; Size of array:C274($aiValues))
					APPEND TO ARRAY:C911($atValues; String:C10($aiValues{$vi3}))
				End for 
				
			: ($viType=Is object:K8:27)
				ALERT:C41("Can't Get Distinct Values for Objects")
				
			: ($viType=Is picture:K8:10)
				ALERT:C41("Can't Get Distinct Values for Pictures")
				
			: ($viType=Is real:K8:4)
				ARRAY REAL:C219($arValues; 0)
				DISTINCT VALUES:C339($vpField->; $arValues; $aiCount)
				For ($vi3; 1; Size of array:C274($arValues))
					APPEND TO ARRAY:C911($atValues; String:C10($arValues{$vi3}))
				End for 
				
			: ($viType=Is subtable:K8:11)
				ALERT:C41("Can't Get Distinct Values for subTables")
				
			: ($viType=Is text:K8:3)
				DISTINCT VALUES:C339($vpField->; $atValues; $aiCount)
				
			: ($viType=Is time:K8:8)
				ARRAY TIME:C1223($ahValues; 0)
				DISTINCT VALUES:C339($vpField->; $ahValues; $aiCount)
				For ($vi3; 1; Size of array:C274($ahValues))
					APPEND TO ARRAY:C911($atValues; String:C10($ahValues{$vi3}))
				End for 
				
		End case 
		
		$vtClipboard:=Field name:C257($vpField)+"\t"+"Count"+"\r"
		For ($vi3; 1; Size of array:C274($atValues))
			$vtMessage:=""
			$vtMessage:=$atValues{$vi3}+"\t"+String:C10($aiCount{$vi3})
			ConsoleMessage($vtMessage)
			$vtClipboard:=$vtClipboard+$vtMessage+"\r"
		End for 
		
		SET TEXT TO PASTEBOARD:C523($vtClipboard)
		ALERT:C41("Results copied to Clipboard and Console")
		
	Else 
		ALERT:C41("Selection Cancelled")
	End if 
End if 

READ WRITE:C146(Current form table:C627->)
