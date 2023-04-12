//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/14/18, 13:20:56
// ----------------------------------------------------
// Method: EDI_DupPONum
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Script DupPONum.4d
//Author James W Medlen
//Date 20161025

//<declarations>
//==================================
//  Type variables 
//==================================

// "\r";variable
C_LONGINT:C283($viDupPONum; $viResult; $viTableNum)
C_TEXT:C284($vtComment; $vtDocAlphaID; $vText; $vText1; $vtMycustomerID; $vtMyCustPONum; $vtMyDate)
C_TEXT:C284($vtMyMessage; $vtMyTime; $vtName; $vtValue)

//==================================
//  Initialize variables 
//==================================

$viDupPONum:=0
$viResult:=0
$viTableNum:=0
$vtComment:=""
$vtDocAlphaID:=""
$vText:=""
$vText1:=""
$vtMycustomerID:=""
$vtMyCustPONum:=""
$vtMyDate:=""
$vtMyMessage:=""
$vtMyTime:=""
$vtName:=""
$vtValue:=""
//</declarations>
$vtMycustomerID:=[Order:3]customerID:1
$vtMyCustPONum:=[Order:3]customerPO:3

SET QUERY DESTINATION:C396(Into variable:K19:4; $viDupPONum)

QUERY:C277([Order:3]; [Order:3]customerID:1=$vtMycustomerID; *)
QUERY:C277([Order:3];  & [Order:3]customerPO:3=$vtMyCustPONum; *)
QUERY:C277([Order:3];  & ; [Order:3]terms:23#"VOID"; *)
QUERY:C277([Order:3];  & ; [Order:3]amount:24>=0; *)
QUERY:C277([Order:3])

If ($viDupPONum>0)
	//$vText:="STOP"
	$vText1:=$vtMyCustPONum
	ELog_NewRecMsg(-1; "TIOI Error"; "Error: EDI Duplicate PONumber: "+$vText1+"\r")
	//EDI_OrdCancel
	If ([Order:3]status:59="")  //don't overwrite pre$vious Error Status
		[Order:3]status:59:="DUPLICATE"
	End if 
	If ([Order:3]profile4:103#"@ERR@")
		[Order:3]profile4:103:=[Order:3]profile4:103+"ERR "
	End if 
	
	//Script Sales Order Comment
	$vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
	$vtMyDate:=String:C10(Current date:C33; 4)
	$vtMyMessage:="Error: EDI Duplicate PONumber: "+$vtMyCustPONum
	$vtComment:=$vtMyDate+": "+$vtMyTime+"; "+$vtMyMessage+Char:C90(13)
	[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; $vtComment; 0)
	
	// Create Profile Record
	$viTableNum:=Table:C252(->[Order:3])
	$vtDocAlphaID:=String:C10([Order:3]orderNum:2)
	$vtName:="ERROR"
	$vtValue:="DUPLICATE"
	$viResult:=AddProfile($viTableNum; $vtDocAlphaID; $vtName; $vtValue; $vtComment)
	
End if 

SET QUERY DESTINATION:C396(Into current selection:K19:1)
