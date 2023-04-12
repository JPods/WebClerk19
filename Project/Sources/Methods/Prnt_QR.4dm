//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/16/19, 23:27:19
// ----------------------------------------------------
// Method: Prnt_QR
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($error; $fileExist)
C_TEXT:C284($myDocName)

If ((Not:C34([UserReport:46]savedInternal:18)) | (BLOB size:C605([UserReport:46]reportBlob:27)=0) | ([UserReport:46]template:7=""))
	// ### jwm ### 20190109_1447 added this section back to test Quick reports
	PrintControls
	QR REPORT:C197(Table:C252([UserReport:46]tableNum:3)->; ""; False:C215; True:C214; False:C215)
Else 
	$myTempDocName:=[UserReport:46]template:7
	
	$myDocName:=Storage:C1525.folder.jitQRsF+HFS_ShortName($myTempDocName)  //try local drive for format  
	$fileExist:=HFS_Exists($myDocName)  //1 if it exists, 0 if it does not    
	If ($fileExist=1)
		$error:=HFS_Delete($myDocName)
	End if 
	// ### jwm ### 20190109_1447
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	If ($error=0)
		BLOB TO DOCUMENT:C526($myDocName; [UserReport:46]reportBlob:27)
		If ($error=0)
			PrintControls
			
			QR REPORT:C197(Table:C252([UserReport:46]tableNum:3)->; $myDocName; False:C215; True:C214; False:C215)
			
			$error:=HFS_Delete($myDocName)
		Else 
			ConsoleLog("QuickReport Error: "+[UserReport:46]name:2+"; couldn't save locally. Temporary layout provided.")
			PrintControls
			QR REPORT:C197(Table:C252([UserReport:46]tableNum:3)->; ""; False:C215; True:C214; False:C215)
		End if 
		
	Else 
		PrintControls
		
		QR REPORT:C197(Table:C252([UserReport:46]tableNum:3)->; ""; False:C215; True:C214; False:C215)
		
	End if 
End if 

If (<>viDebugMode>410)
	C_LONGINT:C283($cntRecs)
	$cntRecs:=0
	If (([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
		$cntRecs:=Records in selection:C76(Table:C252([UserReport:46]tableNum:3)->)
	End if 
	ConsoleLog("Printed: "+[UserReport:46]name:2+" "+[UserReport:46]tableName:47+" count: "+String:C10($cntRecs))
End if 


