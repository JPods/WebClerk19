//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/06/08, 09:59:03
// ----------------------------------------------------
// Method: EDI_OutMakeFile
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150306_1517 added Customers to Output Tables

If (False:C215)  // for debug only
	// SET DATABASE PARAMETER(34;2)  // // ### jwm ### 20170309_1059 debug crashing
	// creates a 4d log file
End if 

C_LONGINT:C283($1; $TableNum)
$TableNum:=$1  //was [UserReport]FileID
C_TEXT:C284($2; $DocType)
$DocType:=$2  //was [UserReport]DocumentLoc

C_LONGINT:C283($index; $index2)
TRACE:C157
FIRST RECORD:C50(Table:C252($TableNum)->)
For ($index; 1; Records in selection:C76(Table:C252($TableNum)->))
	QUERY:C277([EDISetID:76]; [EDISetID:76]docType:1=$DocType; *)
	QUERY:C277([EDISetID:76];  & ; [EDISetID:76]inputOutput:2=False:C215; *)
	QUERY:C277([EDISetID:76];  & ; [EDISetID:76]active:13=True:C214)  // ### jwm ### 20180108_1604
	
	For ($index2; 1; Records in selection:C76([EDISetID:76]))
		If ([EDISetID:76]partnerIDAlpha:3#"")
			Case of 
				: ($TableNum=Table:C252(->[PO:39]))
					Case of 
						: ([EDISetID:76]partnerType:5=<>ciEDIPTVend)
							If ([PO:39]vendorid:1=[EDISetID:76]partnerIDAlpha:3)
								TIOO_ReadFile(->[EDISetID:76]textIOContent:7; ->[EDISetID:76]srcDestFolder:8)
							End if 
						: ([EDISetID:76]partnerType:5=<>ciEDIPTCust)
					End case 
				: ($TableNum=Table:C252(->[Invoice:26]))
					Case of 
						: ([EDISetID:76]partnerType:5=<>ciEDIPTVend)
						: ([EDISetID:76]partnerType:5=<>ciEDIPTCust)
							If ([Invoice:26]customerid:3=[EDISetID:76]partnerIDAlpha:3)
								TIOO_ReadFile(->[EDISetID:76]textIOContent:7; ->[EDISetID:76]srcDestFolder:8)
							End if 
					End case 
				: ($TableNum=Table:C252(->[Order:3]))
					Case of 
						: ([EDISetID:76]partnerType:5=<>ciEDIPTVend)
						: ([EDISetID:76]partnerType:5=<>ciEDIPTCust)
							If ([Order:3]customerid:1=[EDISetID:76]partnerIDAlpha:3)
								TIOO_ReadFile(->[EDISetID:76]textIOContent:7; ->[EDISetID:76]srcDestFolder:8)
							End if 
					End case 
				: ($TableNum=Table:C252(->[Customer:2]))  // ### jwm ### 20150306_1517
					Case of 
						: ([EDISetID:76]partnerType:5=<>ciEDIPTVend)
						: ([EDISetID:76]partnerType:5=<>ciEDIPTCust)
							If ([Customer:2]customerID:1=[EDISetID:76]partnerIDAlpha:3)
								TIOO_ReadFile(->[EDISetID:76]textIOContent:7; ->[EDISetID:76]srcDestFolder:8)
							End if 
					End case 
			End case 
		Else 
			TIOO_ReadFile(->[EDISetID:76]textIOContent:7; ->[EDISetID:76]srcDestFolder:8)
		End if 
		NEXT RECORD:C51([EDISetID:76])
	End for 
	NEXT RECORD:C51(Table:C252($TableNum)->)
End for 