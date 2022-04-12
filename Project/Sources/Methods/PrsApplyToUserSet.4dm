//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PrsApplyToUserSet
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
DELAY PROCESS:C323(Current process:C322; <>delayProcessUnload)  // Give calling process time to unlock at the server
C_LONGINT:C283($viProcess)
$viProcess:=Current process:C322
SET MENU BAR:C67(1; $viProcess; *)
Process_InitLocal
C_POINTER:C301($ptOrgFile)
myOK:=0
$ptOrgFile:=<>ptCurTable
ptCurTable:=<>ptCurTable
C_LONGINT:C283($tableNum; $theField; $theType)
C_LONGINT:C283($1; $2)
$tableNum:=$1
$theField:=$2
C_TEXT:C284($3; $theValue)
$theValue:=$3
USE SET:C118("<>curSelSet")
CLEAR SET:C117("<>curSelSet")
myOK:=1
$theType:=Type:C295(Field:C253($tableNum; $theField)->)
If (myOK=1)
	$k:=Records in selection:C76(Table:C252($1)->)
	FIRST RECORD:C50(Table:C252($1)->)
	For ($i; 1; $k)
		Case of 
			: (($theType=Is alpha field:K8:1) | ($theType=24))  //0
				Field:C253($tableNum; $theField)->:=$theValue
			: ($theType=Is text:K8:3)  //2
				Field:C253($tableNum; $theField)->:=WC_FieldTagToValue(0; $theValue; $theFormat)
			: ($theType=Is date:K8:7)  //4
				Field:C253($tableNum; $theField)->:=Date_GoFigure($theValue)
			: (($theType=1) | ($theType=8))
				Field:C253($tableNum; $theField)->:=Num:C11($theValue)
			: ($theType=Is longint:K8:6)  //9)
				DT_ParseImport(Field:C253($tableNum; $theField); $theValue)
			: ($theType=Is boolean:K8:9)  //6)
				Field:C253($tableNum; $theField)->:=(($theValue="1") | ($theValue="T") | ($theValue="True") | ($theValue="Y") | ($theValue="Yes"))
			: ($theType=Is time:K8:8)  //11)
				Field:C253($tableNum; $theField)->:=Time:C179($theValue)
		End case 
		SAVE RECORD:C53(Table:C252($1)->)
		NEXT RECORD:C51(Table:C252($1)->)
	End for 
End if 
<>prcControl:=0