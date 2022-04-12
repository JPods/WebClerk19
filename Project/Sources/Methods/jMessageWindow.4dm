//%attributes = {}
// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 09/11/09, 10:42:44
// ----------------------------------------------------
// Method: jMessageWindow
// Description
// 
If (False:C215)  //Alternate display window
	Thermo_Process
End if 

//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1)
C_REAL:C285($2)  //number of seconds to Delay
C_LONGINT:C283($End)

SET DATABASE PARAMETER:C642(Direct2D status:K37:61; Direct2D software:K37:66)  // Enable Direct2D fixes message bug with Windows client

If (Count parameters:C259=2)
	$End:=Tickcount:C458+($2*60)  //$2: wait for $2 seconds, 1 Tick = 1/60th second
Else 
	$End:=Tickcount:C458+(1*60)  //wait for 1 second, 1 Tick=1/60th second
End if 

Open window:C153(200; 200; 800; 500; 8; "Message")  // ### jwm ### 20150710_0936 increased Height and Width by 200 pixels
ERASE WINDOW:C160
GOTO XY:C161(0; 1)  // ### jwm ### decreased indent from  3;3 to 1;1

MESSAGE:C88($1)

Repeat 
	IDLE:C311
Until (Tickcount:C458>$End)  //Time out

CLOSE WINDOW:C154

SET DATABASE PARAMETER:C642(Direct2D status:K37:61; Direct2D disabled:K37:63)  // Disable Direct2D
