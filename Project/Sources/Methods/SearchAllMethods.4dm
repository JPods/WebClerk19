//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/24/17, 16:07:33
// ----------------------------------------------------
// Method: SearchAllMethods
// Description
// 
//
// Parameters
// ----------------------------------------------------

ARRAY TEXT:C222(vfileNames_at; 0)
ARRAY TEXT:C222(vcode_at; 0)
C_TEXT:C284(vtCode; vText; vText1; vtLine; vtRequest)
C_LONGINT:C283($vi1; $vi2)
C_REAL:C285(vrPercent)


If (<>consoleprocess=0)
	ConsoleLaunch
End if 

SET DATABASE PARAMETER:C642(Direct2D status:K37:61; Direct2D software:K37:66)  // Enable Direct2D fixes message bug with Windows client

Open window:C153(100; 200; 500; 300; 8; "Progress")

//CONFIRM("Import or export methods?";"Import";"Export")
vText:=""
vText1:=""
vtRequest:=Request:C163("Enter Text To search For")

If (vtRequest#"")
	ConsoleLog(vtRequest+": Query Structure")
	vText:="@"+vtRequest+"@"
	//METHOD GET PATHS(Path Project method;vfileNames_at)
	METHOD GET PATHS:C1163(Path all objects:K72:16; vfileNames_at)  //Path project form
	METHOD GET CODE:C1190(vfileNames_at; vcode_at)
	For (vloop_l; 1; Size of array:C274(vfileNames_at))
		
		$vi1:=vloop_l
		$vi2:=Size of array:C274(vfileNames_at)
		vrPercent:=Round:C94(($vi1/$vi2*100); 0)
		ERASE WINDOW:C160
		GOTO XY:C161(3; 3)
		MESSAGE:C88(" Record "+String:C10($vi1)+" of "+String:C10($vi2)+"  "+String:C10(vrPercent)+" %")
		
		vfilename_t:=vfileNames_at{vloop_l}
		vCode_t:=vcode_at{vloop_l}
		ARRAY TEXT:C222(atLines; 0)
		TextToArray(vCode_t; ->atLines; "\r"; True:C214)
		
		For (vi2; 1; Size of array:C274(atLines))
			If (atLines{vi2}=vText)
				vtLine:=String:C10((vi2-1))  // adjust line number for Attribute comment added to method
				vText1:=vText1+Storage:C1525.char.comment+"  "+vfilename_t+"  Line: "+vtLine+" \r"
			End if 
		End for 
		
	End for 
	
	ERASE WINDOW:C160
	CLOSE WINDOW:C154
	
	SET DATABASE PARAMETER:C642(Direct2D status:K37:61; Direct2D hardware:K37:64)
	
	If (vText1#"")
		//SET TEXT TO PASTEBOARD(vText1)
		ConsoleLog(vText1)
		METHOD SET CODE:C1194("SearchAllMethodResults"; vText1)
		//ALERT("Results copied to Clipboard")
	Else 
		ALERT:C41(vtRequest+" - Not Found")
	End if 
	
End if   // End Confirm

