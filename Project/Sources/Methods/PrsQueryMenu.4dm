//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PrsQueryNewSelection
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
C_LONGINT:C283($viProcess)
$viProcess:=Current process:C322
SET MENU BAR:C67(1; $viProcess; *)
Process_InitLocal
C_POINTER:C301($ptOrgFile)
myOK:=0
$ptOrgFile:=<>ptCurTable
ptCurTable:=<>ptCurTable
C_POINTER:C301($ptTable; $ptField; $1; $2)
C_TEXT:C284($3)
C_LONGINT:C283($cntPara; $theType)
$theType:=Type:C295($2->)
$cntPara:=Count parameters:C259
Case of 
	: ($cntPara=3)
		Case of 
			: (($theType=Is alpha field:K8:1) | ($theType=24))  //0
				QUERY:C277($1->; $2->=$3)
			: ($theType=Is text:K8:3)  //2
				QUERY:C277($1->; $2->=$3)
			: ($theType=Is date:K8:7)  //4
				QUERY:C277($1->; $2->=Date:C102($3))
			: (($theType=Is real:K8:4) | ($theType=Is integer:K8:5))  //1, 8
				QUERY:C277($1->; $2->=Num:C11($3))
			: ($theType=Is longint:K8:6)  //9)
				QUERY:C277($1->; $2->=Num:C11($3))
			: ($theType=Is boolean:K8:9)  //6)
				QUERY:C277($1->; $2->=($3="1"))
			: ($theType=Is time:K8:8)  //11)
				QUERY:C277($1->; $2->=Time:C179($3))
		End case 
		//
		//
		//    
End case 
TRACE:C157
If (Records in selection:C76($1->)>0)
	CREATE SET:C116($1->; "<>curSelSet")
	<>prcControl:=1
	<>ptCurTable:=$1
	<>processAlt:=New process:C317("Prs_ShowSelection"; <>tcPrsMemory; Table name:C256($1)+String:C10(Count tasks:C335); Current process:C322)  //+"-"+Filename(<>ptCurFile))
Else 
	C_LONGINT:C283($num)
	
	// Modified by: Bill James (2015-12-16T00:00:00 Convert_2_v14)
	KeyWordByAlpha(Table:C252(->[Item:4]); $3+"MenuRef"; True:C214)
	
	
	If (Records in selection:C76([Item:4])>0)
		CREATE SET:C116([Item:4]; "<>curSelSet")
		<>prcControl:=1
		<>ptCurTable:=(->[Item:4])
		<>processAlt:=New process:C317("Prs_ShowSelection"; <>tcPrsMemory; "Item"+String:C10(Count tasks:C335); Current process:C322)  //+"-"+Filename(<>ptCurFile))
	Else 
		ALERT:C41("There are no matching items or children menus")
	End if 
End if 
