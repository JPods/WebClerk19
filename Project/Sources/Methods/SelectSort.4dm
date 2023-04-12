//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/12/18, 10:38:19
// ----------------------------------------------------
// Method: SelectSort
// Description
// 
//
// Parameters Name of Field Object;Name of Header Object
// ----------------------------------------------------

//<declarations>
//==================================
//  Type variables 
//==================================

// $1;$2;$apFields;$atFieldNames;$vpField;valid;variables
C_LONGINT:C283($viChoice; $viDefault; $viField; $vimouseButton; $vimouseX; $vimouseY; $viTableNum)
C_LONGINT:C283(viBestHeight; viBestWidth; viBottom; viLeft; viMoveH; viMoveH_Splitter; viMoveV; viMoveV_Splitter)
C_LONGINT:C283(viResizeH; viResizeH_Splitter; viResizeV; viResizeV_Splitter; viRight; viTop; viWidthOld)
C_TEXT:C284($vtField; $vtFieldName; $vtHeaderName; $vtObjectName; $vtPopup; $vtFormula)
C_TEXT:C284($1; $2; $3; $4; vtAZ; vtZA; vtDiamond; vtDirection)
C_POINTER:C301($vpField)

//==================================
//  Initialize variables 
//==================================

$viChoice:=0
$viDefault:=0
$viField:=0
$vimouseButton:=0
$vimouseX:=0
$vimouseY:=0
$viTableNum:=0
viBestHeight:=0
viBestWidth:=0
viBottom:=0
viLeft:=0
viMoveH:=0
viMoveH_Splitter:=0
viMoveV:=0
viMoveV_Splitter:=0
viResizeH:=0
viResizeH_Splitter:=0
viResizeV:=0
viResizeV_Splitter:=0
viRight:=0
viTop:=0
viWidthOld:=0
$vtField:=""
$vtFieldName:=""
$vtHeaderName:=""
$vtObjectName:=""
$vtPopup:=""
$vtFormula:=""

vtAZ:=Char:C90(0x25B2)  // > ascending a-z
vtZA:=Char:C90(0x25BC)  // < descending z-a
vtDiamond:=Char:C90(0x25C6)
//</declarations>

// ### jwm ### 20171004_1452 changed form mfrID to Flow

$vpTable:=ptCurTable
$viTableNum:=Table:C252($vpTable)
$tableName:=Table name:C256($vpTable)

ARRAY TEXT:C222($atFieldNames; Get last field number:C255($vpTable))
ARRAY POINTER:C280($apFields; Get last field number:C255($vpTable))
For ($viField; Size of array:C274($atFieldNames); 1; -1)
	If (Is field number valid:C1000($viTableNum; $viField))
		$atFieldNames{$viField}:=Field name:C257($viTableNum; $viField)
		$apFields{$viField}:=Field:C253($viTableNum; $viField)
	Else 
		DELETE FROM ARRAY:C228($atFieldNames; $viField)
		DELETE FROM ARRAY:C228($apFields; $viField)
	End if   // field number valid
	
End for 

// sort list a-z
SORT ARRAY:C229($atFieldNames; $apFields; >)

APPEND TO ARRAY:C911($atFieldNames; "-")
APPEND TO ARRAY:C911($atFieldNames; "Reset Form<I")


Case of 
	: ($tableName="RemoteUser")
		// remove userPassword from list
		$viField:=Find in array:C230($atFieldNames; "UserPassword")
		DELETE FROM ARRAY:C228($atFieldNames; $viField)
End case 


// column options

$vtObjectName:=$1
$vtHeaderName:=$2

Case of 
		
	: (Count parameters:C259=3)  // loading Custom Fields
		
		// set style to underline to show select sort feature
		OBJECT SET FONT STYLE:C166(*; $vtHeaderName; Underline:K14:4)
		
		$vtField:=$3
		$viChoice:=Find in array:C230($atFieldNames; $vtField)
		$vtField:=$atFieldNames{$viChoice}
		$vpField:=$apFields{$viChoice}
		
		OBJECT SET TITLE:C194(*; $vtHeaderName; $vtField)
		OBJECT SET DATA SOURCE:C1264(*; $vtObjectName; $vpField)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align default:K42:1)
		
		// set format
		SelectSortFormat($vtField; $vtObjectName; $vpField)
		
	Else 
		
		KeyModifierCurrent
		
		GET MOUSE:C468($vimouseX; $vimouseY; $vimouseButton; *)
		
		If ($vimouseButton=2)  // right click
			
			// save current selection of GenericChild1
			If (Records in selection:C76([GenericChild1:90])>0)
				COPY NAMED SELECTION:C331([GenericChild1:90]; "SelectSort")
			End if 
			
			// build Choice List
			$vtPopup:=""
			For ($viField; 1; Size of array:C274($atFieldNames))
				If ($viField=1)
					$vtPopup:=$atFieldNames{$viField}
				Else 
					$vtPopup:=$vtPopup+";"+$atFieldNames{$viField}
				End if 
			End for 
			
			// Get default choice
			$vtFieldName:=Field name:C257($vpField)
			$viDefault:=Find in array:C230($atFieldNames; $vtFieldName)
			
			$viChoice:=Pop up menu:C542($vtPopup; $viDefault)
			
			// check for valid choice
			If ($viChoice>0)
				
				If ($atFieldNames{$viChoice}="Reset Form<I")
					
					COPY NAMED SELECTION:C331(ptCurtable->; "Current")
					jCancelMenu
					
					QUERY:C277([GenericChild1:90]; [GenericChild1:90]name:3=Table name:C256(ptCurtable); *)
					QUERY:C277([GenericChild1:90];  & ; [GenericChild1:90]purpose:4=Current form name:C1298; *)
					QUERY:C277([GenericChild1:90];  & ; [GenericChild1:90]a01:40=Current user:C182; *)
					QUERY:C277([GenericChild1:90])
					DELETE SELECTION:C66([GenericChild1:90])
					
					USE NAMED SELECTION:C332("Current")
					CLEAR NAMED SELECTION:C333("Current")
					ProcessTableOpen(Table:C252(ptCurtable); ""; "")
					
				Else   // set and save custom field
					
					// set style to underline to show select sort feature
					OBJECT SET FONT STYLE:C166(*; $vtHeaderName; Underline:K14:4)
					
					$vtField:=$atFieldNames{$viChoice}
					$vpField:=$apFields{$viChoice}
					
					OBJECT SET TITLE:C194(*; $vtHeaderName; $vtField)
					OBJECT SET DATA SOURCE:C1264(*; $vtObjectName; $vpField)
					OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtObjectName; Align default:K42:1)
					
					// set format
					SelectSortFormat($vtField; $vtObjectName; $vpField)
					
					QUERY:C277([GenericChild1:90]; [GenericChild1:90]name:3=Table name:C256(ptCurtable); *)
					QUERY:C277([GenericChild1:90];  & ; [GenericChild1:90]purpose:4=Current form name:C1298; *)
					QUERY:C277([GenericChild1:90];  & ; [GenericChild1:90]a01:40=Current user:C182; *)
					QUERY:C277([GenericChild1:90];  & ; [GenericChild1:90]a02:41=$vtObjectName; *)
					QUERY:C277([GenericChild1:90])
					
					// save choice
					Case of 
							
						: (Records in selection:C76([GenericChild1:90])=0)
							CREATE RECORD:C68([GenericChild1:90])
							
						: (Records in selection:C76([GenericChild1:90])>1)
							DELETE SELECTION:C66([GenericChild1:90])
							CREATE RECORD:C68([GenericChild1:90])
							
						: (Records in selection:C76([GenericChild1:90])=1)
							// update and save record
							
					End case 
					
					[GenericChild1:90]name:3:=Table name:C256(ptCurtable)
					[GenericChild1:90]purpose:4:=Current form name:C1298
					[GenericChild1:90]a01:40:=Current user:C182
					[GenericChild1:90]a02:41:=$vtObjectName
					[GenericChild1:90]a03:42:=$vtHeaderName
					[GenericChild1:90]a04:43:=$vtField
					[GenericChild1:90]d01:24:=Current date:C33
					[GenericChild1:90]h01:30:=Current time:C178
					[GenericChild1:90]dt01:34:=DateTime_DTTo
					[GenericChild1:90]templateName:57:="CustomField"
					
					SAVE RECORD:C53([GenericChild1:90])
					UNLOAD RECORD:C212([GenericChild1:90])
					
				End if 
				
			End if 
			
			// restore current selection of GenericChild1
			$viResult:=RECORDS IN NAMED SELECTION(->[GenericChild1:90]; "SelectSort")
			If ($viResult>0)
				USE NAMED SELECTION:C332("SelectSort")
				CLEAR NAMED SELECTION:C333("SelectSort")
			End if 
			
		Else   // left click
			
			$vpField:=OBJECT Get data source:C1265(*; $vtObjectName)
			
			If ((vHere=1) & ($vimouseButton=1))  // only sort output layouts on left click // 
				
				RESOLVE POINTER:C394($vpField; $vtVariableName; $viTableNum; $viFieldNum)
				
				//Sort Column
				//If (Count parameters>=4)  // Sort By Formula
				If ($vtVariableName#"")  // Sorting by variables
					Case of 
						: ($vtVariableName="vtDT@")
							
							$vtFieldName:=Substring:C12($vtVariableName; 3)
							$vtFormula:="["+$tableName+"]"+$vtFieldName
							
						: (Count parameters:C259>=4)
							
							$vtFormula:=$4  //example: vtFormula:=([ItemDiscount]BasePrice*(1-([ItemDiscount]PerCentDiscount*0.01)))
							
					End case 
					
					If ((OptKey=1) | (vtDirection=vtZA))  // sort descending
						$vtFormula:="ORDER BY FORMULA(["+$tableName+"];"+$vtFormula+";<)"
						EXECUTE FORMULA:C63($vtFormula)
					Else   // sort ascending
						$vtFormula:="ORDER BY FORMULA(["+$tableName+"];"+$vtFormula+";>)"
						EXECUTE FORMULA:C63($vtFormula)
					End if 
					
				Else   // count parameters not = 4
					
					If ((OptKey=1) | (vtDirection=vtZA))  // sort descending
						ORDER BY:C49($vpTable->; $vpField->; <)
					Else   // sort ascending
						ORDER BY:C49($vpTable->; $vpField->; >)
					End if 
					
				End if 
				
			End if   // only sort output layouts
			
		End if 
		
End case 
