//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/29/18, 01:54:10
// ----------------------------------------------------
// Method: AE_LaunchDoc
// Description
// 
//
// Parameters
// ----------------------------------------------------





C_TEXT:C284($1; $thePath)
$thePath:=$1
C_BOOLEAN:C305($doLaunch)
C_LONGINT:C283($w)
Case of 
	: (($thePath="http:@") | ($thePath="https:@"))
		Web_LaunchURL($thePath)
		
	: (($thePath="vnc:@") | ($thePath="ssh:@"))
		Web_LaunchURL($thePath)
		
	: (($thePath="ftp:@") | ($thePath="sftp:@"))
		Web_LaunchURL($thePath)
		
	: (False:C215)  //   should add after some research
		// catch all for the above
		//  (Position("://";$thePath)>0)  // 
		// ### bj ### 20181029_1150
		// I think this is always true
		// Web_LaunchURL ($thePath)
	Else 
		$doLaunch:=True:C214
		$thePath:=PathToSystem($thePath)
		//  $thePath:="file://"+Convert path system to POSIX($thePath)
		OPEN URL:C673($thePath)
		
		// LAUNCH EXTERNAL PROCESS($myDocName)
End case 