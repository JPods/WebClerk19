//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 06/28/17, 13:00:41
// ----------------------------------------------------
// Method: SetUserPassword
// Description
// 
//
// Parameters
// ----------------------------------------------------


// Script Unique Password VII 20170627
//Script Random Password 20110630
//(Random%(End–Start+1))+Start
//start=1  end=26  26-1+1=26
//from vtSet character 1 through 26
//can be adjusted to contain uppercase lowercase numbers and special characters
//Starting string randomized 20110630
//removed letter Q
// 06/15/15 9:13 ; Jim Medlen - updated message window
// 04/22/16 11:50 ; Jim Medlen - increased random delay 1-3 ticks
// 03/13/2017; 17:17 - Jim Medlen - removed delay added numbers
// 06/26/2017 13:31 ; Jim Medlen - changed rendom number generator to mt_rand PHP Mersenne Twister random number generator cleaned up the method
// 06/27/2017 13:01 ; Jim Medlen - new Dice Words Password

//vi1:=Set user properties ( -29 ; "MLowry" ; "" ; "2156lifeboatargument" ; 0 ; !00/00/00! )


//<declarations>
//==================================
//  Type variables 
//==================================

C_BOOLEAN:C305(vbOK; vbUnique)
C_LONGINT:C283(vi1; vi2; vi3; viCount; viRecords; viUniqueID)
C_TEXT:C284(vtDice; vText; vtPassword; vtSet; vtOldPassword)

//==================================
//  Initialize variables 
//==================================

vbOK:=False:C215
vbUnique:=False:C215
vi1:=0
vi2:=0
vi3:=0
viCount:=0
viRecords:=0
vtDice:=""
vText:=""
vtPassword:=""
vtOldPassword:=""
vtSet:=""
viUniqueID:=0
//</declarations>


If (Current user:C182#"Admin")
	ALERT:C41("Error: Admin User Only")
Else 
	If (<>ConsoleProcess=0)  // launch Console if not open
		ConsoleLaunch
	End if 
	
	COPY NAMED SELECTION:C331([RemoteUser:57]; "Original")
	
	Open window:C153(100; 200; 500; 300; 8; "Progress")
	ERASE WINDOW:C160
	GOTO XY:C161(6; 3)
	
	MESSAGE:C88("Building Password...")
	
	If (Records in selection:C76([RemoteUser:57])>0)
		viUniqueID:=[RemoteUser:57]idNum:1
	End if 
	
	vbUnique:=False:C215
	While (vbUnique=False:C215)
		
		ARRAY TEXT:C222(atDiceWords; 0)
		vtPassword:=""
		vText:=""
		viCount:=3
		
		For (vi1; 1; viCount)
			vtDice:=""
			For (vi2; 1; 4)
				vbOK:=PHP Execute:C1058(""; "mt_rand"; vi3; 1; 6)  // Mersenne Twister
				vtDice:=vtDice+String:C10(vi3)
			End for 
			
			QUERY:C277([GenericChild2:91]; [GenericChild2:91]name:3="DiceWord"; *)
			QUERY:C277([GenericChild2:91]; [GenericChild2:91]purpose:4="Password"; *)
			QUERY:C277([GenericChild2:91]; [GenericChild2:91]a01:28=vtDice; *)
			QUERY:C277([GenericChild2:91])
			
			If (vi1<viCount)
				APPEND TO ARRAY:C911(atDiceWords; [GenericChild2:91]a05:27)
			End if 
		End for 
		
		vbOK:=PHP Execute:C1058(""; "mt_rand"; vi3; 1; 3)  // Mersenne Twister
		
		Case of 
			: (vi3=1)
				vtPassword:=atDiceWords{1}+atDiceWords{2}+vtDice
				vText:=atDiceWords{1}+" "+atDiceWords{2}+" "+vtDice
				
			: (vi3=2)
				vtPassword:=atDiceWords{1}+vtDice+atDiceWords{2}
				vText:=atDiceWords{1}+" "+vtDice+" "+atDiceWords{2}
				
			: (vi3=3)
				vtPassword:=vtDice+atDiceWords{1}+atDiceWords{2}
				vText:=vtDice+" "+atDiceWords{1}+" "+atDiceWords{2}
				
		End case 
		
		//ConsoleLog(vtPassword)
		ConsoleLog(vText)
		
		QUERY:C277([RemoteUser:57]; [RemoteUser:57]userPassword:3=vtPassword)
		viRecords:=Records in selection:C76([RemoteUser:57])
		If (viRecords>0)
			vbUnique:=False:C215
			ConsoleLog("Duplicate Password")
		Else 
			vbUnique:=True:C214
		End if 
		
		// ### jwm ### 20170627_1304 REMOVE THIS AFTER INSTALLING NEW STRUCTURE WITH PASSWORD LENGTH 255
		If (Length:C16(vtPassword)>255)
			vbUnique:=False:C215
			ConsoleLog("Length Password > 255")
		End if 
		
	End while 
	//ALERT("Unique Password "+vtPassword)
	//SET TEXT TO PASTEBOARD(vtPassword)
	
	QUERY:C277([RemoteUser:57]; [RemoteUser:57]idNum:1=viUniqueID)
	LOAD RECORD:C52([RemoteUser:57])
	vtOldPassword:=[RemoteUser:57]userPassword:3
	
	CLOSE WINDOW:C154  // message window
	REDRAW WINDOW:C456  // main Window
	
	vtPassword:=Request:C163("Reset User Password"; vtPassword; " Reset Password "; " Cancel ")
	
	If (ok=1)
		
		vtUserName:=[RemoteUser:57]customerID:10
		
		ARRAY TEXT:C222(atUserName; 0)
		ARRAY LONGINT:C221(aiUserNum; 0)
		GET USER LIST:C609(atUserName; aiUserNum)
		viIndex:=Find in array:C230(atUserName; vtUserName)
		
		If (viIndex>0)
			viUserNum:=aiUserNum{viIndex}
			
			GET USER PROPERTIES:C611(viUserNum; vtUserName; vtStartUp; vText1; viLogins; vdLastLogin)
			vi1:=Set user properties:C612(viUserNum; vtUserName; ""; vtPassword; viLogins; vdLastLogin)
			If (vi1<0)
				If ([RemoteUser:57]obGeneral:31=Null:C1517)
					[RemoteUser:57]obGeneral:31:=New object:C1471
				End if 
				If ([RemoteUser:57]obGeneral:31.passwordOld=Null:C1517)
					[RemoteUser:57]obGeneral:31.passwordOld:=New object:C1471
				End if 
				[RemoteUser:57]obGeneral:31.passwordOld[String:C10(DateTime_DTTo)]:=vtOldPassword
				[RemoteUser:57]userPassword:3:=vtPassword
				iLoText1:=vtPassword
				[RemoteUser:57]key:21:=vText
				
				//ALERT("Password Set")
				//SAVE RECORD([RemoteUser])
				//ALERT("RemoteUser Saved")
				ConsoleLog("Password Updated - "+vtPassword)
			Else 
				ALERT:C41("Error: Password Not Set")
			End if 
		Else 
			ALERT:C41("Error: "+vtUserName+" Not Found In 4D Users List")
		End if 
	End if 
	
	USE NAMED SELECTION:C332("Original")
	CLEAR NAMED SELECTION:C333("Original")
	
End if 
