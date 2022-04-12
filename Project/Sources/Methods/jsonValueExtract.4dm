//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/04/18, 11:01:23
// ----------------------------------------------------
// Method: jsonValueExtract
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($1; $voBatch)


$voBatch:=$1

C_OBJECT:C1216($voBatch)
// originally passed in a json
// $voBatch:=JSON Parse($1)

ARRAY OBJECT:C1221(aObCluster; 0)
ARRAY OBJECT:C1221(aObHeader; 0)
ARRAY OBJECT:C1221(aObTable1; 0)
ARRAY OBJECT:C1221(aObTable2; 0)
ARRAY OBJECT:C1221(aObTable3; 0)
ARRAY OBJECT:C1221(aObTable4; 0)
ARRAY OBJECT:C1221(aObTable5; 0)
ARRAY OBJECT:C1221(aObTable6; 0)
ARRAY OBJECT:C1221(aObTable7; 0)



OB GET ARRAY:C1229($voBatch; "Cluster"; aObCluster)
OB GET ARRAY:C1229(aObCluster{1}; "header"; aObHeader)
C_TEXT:C284($vtTableNames)
ARRAY TEXT:C222(aTableNames; 0)
$vtTableNames:=OB Get:C1224(aObHeader{1}; "Tables")
TextToArray($vtTableNames; ->aTableNames; "_")
C_LONGINT:C283($incRay; $cntRay)
$cntRay:=Size of array:C274(aTableNames)
If ($cntRay>7)
	$cntRay:=7
End if 
C_POINTER:C301($ptPointArray)
For ($incRay; 1; $cntRay)
	$ptPointArray:=Get pointer:C304("aObTable"+String:C10($incRay))
	OB GET ARRAY:C1229(aObCluster{$incRay+1}; aTableNames{$incRay}; $ptPointArray->)
End for 






If (False:C215)  // example strings only values have changed
	
	C_LONGINT:C283($cntOrdersFields; $cntCustomersFields; $cntOrderLinesFields)
	//$cntOrdersFields:=Size of array(aObDetails)
	//$cntCustomersFields:=Size of array(aObCustDetails)
	//$cntOrderLinesFields:=Size of array(aObLineDetails)
	
	C_LONGINT:C283($viOrderNum)
	C_TEXT:C284($vtcustomerID; $vtCustPO)
	
	//$viOrderNum:=OB Get(aObTable1{1};"OrderNum")
	//$vtcustomerID:=OB Get(aObTable1{1};"customerID")
	//$vtCustPO:=OB Get(aObTable1{1};"CustPONum")
	
End if 