//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 16:12:40
// ----------------------------------------------------
// Method: EventLogsiLo
// Description
// Modified: 03/28/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// ### bj ### 20200123_1052
// Removed Page 4 it was a repeat of page one with less information

If (Form event code:C388=On Load:K2:1)  // if not in the password group kill the window
	If (UserInPassWordGroup("AdminControl"))
		ARRAY TEXT:C222(iLoaText1; 10)
		iLoaText1{1}:="AddressIPLocal"
		iLoaText1{2}:="CarryOverText"
		iLoaText1{3}:="LastQueryScript"
		iLoaText1{4}:="LastSortScript"
		iLoaText1{5}:="Message"
		iLoaText1{6}:="MessageHistory"
		iLoaText1{7}:="Path"
		iLoaText1{8}:="RemoteOS"
		iLoaText1{9}:="UserAgent"
		iLoaText1{10}:="WebClerkPath"
		iLoaText1:=5
		vOrdComment:=[EventLog:75]message:4
		iLoInteger1:=5  // used to keep track of the current selected tab
	Else 
		CANCEL:C270
	End if 
End if 

// ### bj ### 20181201_1040
C_LONGINT:C283($formEvent)
// $formEvent:=form event
$formEvent:=iLoProcedure(->[EventLog:75])
$doMore:=False:C215

Case of 
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		$doMore:=True:C214
		
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		$doMore:=True:C214
		
		
	: (iLoRecordChange)  //set in iLoProcedure only once, existing record
		$doMore:=True:C214
		
End case 

If ($doMore)  //action for the form regardless of new or existing record
	
	// related records not addressed by (P) RelatedGet
	// form calculations
	
	// ### bj ### 20210912_1208  should be by obEventLog.id
	QUERY:C277([WebTempRec:101]; [WebTempRec:101]idEventLog:1=[EventLog:75]id:54)
	
	DateTime_DTFrom([EventLog:75]dtEvent:1; ->vdDate; ->vtTime)
	$doClear:=False:C215
	If (([EventLog:75]remoteUserRec:10>0) & (Record number:C243([EventLog:75])>-3))
		// ### bj ### 20181227_1733 creates a zero record problem 
		// but is easier for users working with data to clear a Remote User from Eventlogs
		GOTO RECORD:C242([RemoteUser:57]; [EventLog:75]remoteUserRec:10)
		Case of 
			: ([RemoteUser:57]tableNum:9=2)
				READ ONLY:C145([Customer:2])
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[RemoteUser:57]customerID:10)
				//SerFillCustDtl 
				READ WRITE:C146([Customer:2])
				
			Else 
				$doClear:=True:C214
		End case 
	Else 
		REDUCE SELECTION:C351([RemoteUser:57]; 0)
		$doClear:=True:C214
	End if 
	If ($doClear)
		v1:=""
		v2:=""
		v3:=""
		v4:=""
		v5:=""
		v6:=""
		v7:=""
		v8:=""
		v9:=""
		v10:=""
		v11:=""
		v12:=""
		v13:=""
		vAction:=""
		v1Date:=!00-00-00!
		v1Time:=?00:00:00?
		vTextServ:=""
	End if 
	DateTime_DTFrom([RemoteUser:57]dtCreated:8; ->vDate1; ->vTime1)
	DateTime_DTFrom([RemoteUser:57]dtLastVisit:5; ->vDate2; ->vTime2)
	
End if 


booAccept:=True:C214  // no madatory fields





