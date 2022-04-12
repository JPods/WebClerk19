//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 15:54:18
// ----------------------------------------------------
// Method: EmployeesiLo
// Description
// Modified: 03/28/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// ### jwm ### 20181214_1543 check this or restore old procedure
// ### bj ### 20181201_1040

If (Form event code:C388=On Load:K2:1)
	If ([Employee:19]obGeneral:79=Null:C1517)
		[Employee:19]obGeneral:79:=New object:C1471
	End if 
	If ([Employee:19]objective:80=Null:C1517)
		[Employee:19]objective:80:=New object:C1471
	End if 
	If ([Employee:19]preference:29=Null:C1517)
		[Employee:19]preference:29:=New object:C1471
	End if 
	SAVE RECORD:C53([Employee:19])
	C_BOOLEAN:C305(passwordPass)
	passwordPass:=(UserInPassWordGroup("Employee"))
End if 

If (passwordPass)
	//
	C_LONGINT:C283($formEvent)
	$formEvent:=iLoProcedure(->[Employee:19])
	//
	// Modified by: Bill James (2016-08-10T00:00:00)
	
	$doMore:=False:C215
	Case of 
		: (iLoRecordNew)  //set in iLoProcedure only once
			OBJECT SET ENTERABLE:C238([Employee:19]nameID:1; True:C214)
			If ([Employee:19]nameID:1="")
				[Employee:19]nameID:1:="Change"+String:C10([Employee:19]idNum:71)
			End if 
			
			$doMore:=True:C214
		: (iLoRecordChange)  //set in iLoProcedure only once
			
			$doMore:=True:C214
		: (iLoReturningToLayout)
			
			$doMore:=True:C214
	End case 
	
	If ($doMore)  // do one time per record tasks
		
		//  CHOPPED QA_LoOnEntry(eAnsListEmployees; Table(->[Employee]); [Employee]nameID; 0; 0)
		
		// form calculations
		var $oDocs : Object
		$oDocs:=ds:C1482.Document.query("customerID  = :1 & tableNum = :2"; [Employee:19]nameID:1; Table:C252(->[Employee:19]))
		// Add Documents
		// MustFixQQQZZZ: Bill James (2022-01-22T06:00:00Z)
		
		
		
		EmployeesNameID
		
		REDUCE SELECTION:C351([Territory:25]; 0)
		COPY ARRAY:C226(<>aColorNames; aTmp20Str1)
		INSERT IN ARRAY:C227(aTmp20Str1; 1; 1)
		aTmp20Str1{1}:="Name Color"
		aTmp20Str1:=1
		COPY ARRAY:C226(<>aColorNames; aTmp20Str2)
		INSERT IN ARRAY:C227(aTmp20Str2; 1; 1)
		aTmp20Str2{1}:="Back Color"
		aTmp20Str2:=1
		//  Put  the formating in the form  jFormatPhone(->[Employee]phone1)
		//  Put  the formating in the form  jFormatPhone(->[Employee]phone2)
		//  Put  the formating in the form  jFormatPhone(->[Employee]fax)
		
		iLo35String1:=[Employee:19]nameID:1
		If (([Employee:19]colorForeGround:54=0) & ([Employee:19]colorBackground:55=0))
			aTmp20Str1:=1
			aTmp20Str2:=1
			ColorSetForeBack(->iLo35String1; 15; 0)
		Else 
			aTmp20Str1:=[Employee:19]colorForeGround:54+2
			aTmp20Str2:=[Employee:19]colorBackground:55+2
			ColorSetForeBack(->iLo35String1; [Employee:19]colorForeGround:54; [Employee:19]colorBackground:55)
		End if 
		
		//  RelatedRelease  in the iLoProcedure
		srDisplayEmail:=[Employee:19]email:16
		Before_New(ptCurTable)  //last thing to do clear all one time variables
	End if 
	
	// tasks to execute with every form event
	
	booAccept:=([Employee:19]nameID:1#"")
	
End if 



