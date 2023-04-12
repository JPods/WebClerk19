//%attributes = {"publishedWeb":true}
// ### jwm ### 20190228_1319
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/28/19, 13:19:18
// ----------------------------------------------------
// Method: dInventoryImport
// Description
// 
//
// Parameters
// ----------------------------------------------------
//<declarations>
//==================================
//  Type variables 
//==================================

// $atData;$atLine;$atSelect;$curUser;$Doc;$DTCreated;$m;$QtyOnAdjust;$QtyOnHand
// $Site;$UnitCost;vsiteID
C_LONGINT:C283($vi1; $vi2; $viDocID; $viJobID; $viLineNum; $viReceiptID; $viStart; $viTableNum)
C_LONGINT:C283($viTakeAction)
C_REAL:C285($vrQtyOnAdjust; $vrQtyOnHand; $vrQtyOnSO; $vrUnitCost; $vrUnitPrice)
C_TEXT:C284($vtData; $vtItemNum; $vtNote; $vtReason; $vtSource; $vtType)

//==================================
//  Initialize variables 
//==================================

$vi1:=0
$vi2:=0
$viDocID:=0
$viJobID:=0
$viLineNum:=0
$viReceiptID:=0
$viStart:=0
$viTableNum:=0
$viTakeAction:=0
$vrQtyOnAdjust:=0
$vrQtyOnHand:=0
$vrQtyOnSO:=0
$vrUnitCost:=0
$vrUnitPrice:=0
$vtData:=""
$vtItemNum:=""
$vtNote:=""
$vtReason:=""
$vtSource:=""
$vtType:=""
//</declarations>

ptCurtable:=->[Base:1]
IVNT_dRayInit

ARRAY TEXT:C222($atSelect; 0)
ARRAY TEXT:C222($atLine; 0)
ARRAY TEXT:C222($atData; 0)

$Doc:=Select document:C905(""; ".txt"; "Select the data File"; Absolute path:K24:14; $atSelect)
//Console_Log ($Doc)
//Console_Log ($atSelect{1})
$vtData:=Document to text:C1236($atSelect{1})
//Console_Log ($vtData)

$vtData:=Replace string:C233($vtData; "\r\n"; "\r")
$vtData:=Replace string:C233($vtData; "\n"; "\r")

TextToArray($vtData; ->$atLine; "\r"; True:C214)

CONFIRM:C162("Clear Header"; " CLEAR "; " CANCEL ")
If (OK=1)
	$viStart:=2
	$vi2:=Size of array:C274($atLine)-1
Else 
	$viStart:=1
	$vi2:=Size of array:C274($atLine)
End if 

$viProgressID:=Progress New

For ($vi1; $viStart; $vi2)
	ProgressUpdate($viProgressID; $vi1; $vi2; "Importing Inventory Changes...")
	CLEAR VARIABLE:C89($atData)
	TextToArray($atLine{$vi1}; ->$atData; "\t"; True:C214)
	If (Size of array:C274($atData)=3)
		
		$vtItemNum:=$atData{1}
		$vrUnitCost:=Num:C11($atData{2})
		$vrQtyOnHand:=Num:C11($atData{3})
		$vrQtyOnAdjust:=Num:C11($atData{3})
		
		$vtType:="AJ"
		$viDocID:=0
		$viReceiptID:=-2
		$vtSource:=Current user:C182
		$viJobID:=0
		$vtReason:="Full Inventory"
		$viTakeAction:=1
		$viLineNum:=0
		$vrQtyOnSO:=0
		$viTableNum:=0
		$vtNote:="Due Diligence Inventory"
		$DTCreated:=DateTime_DTTo
		$vtsiteID:="Sharpsville"
		$vrUnitPrice:=-5
		
		//Invt_dRecCreate ("AJ";0;-2;$vtSource;0;aLsReason{$m};1;0;aLsItemNum{$m};aLsQtySO{$m};aLsQtySO{$m};aLsCost{$m};"";vsiteID;0)  // ### jwm ### 20160119_1037
		
		Invt_dRecCreate($vtType; $viDocID; $viReceiptID; $vtSource; $viJobID; $vtReason; $viTakeAction; $viLineNum; $vtItemNum; $vrQtyOnHand; $vrQtyOnAdjust; $vrUnitCost; $vtNote; $vtsiteID; $vrUnitPrice)  // ### jwm ### 20160119_1037
		INVT_dInvtApply
		TallyInventory
	Else 
		ConsoleLog("ERROR: Line did not contain three data elements")
	End if 
	
End for 
Progress QUIT($viProgressID)

ALERT:C41("Import complete")