//%attributes = {}

// Modified by: Bill James (2022-05-11T05:00:00Z)
// Method: ConsolePost
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($message : Text)

// HOWTO:Undefined HOWTO:defined
If (Undefined:C82(iLoaText1))
	ARRAY TEXT:C222(iLoaText1; 1)
	iLoaText1{1}:=""
	iLoaText1:=1
	$message:="launch"
End if 
var $limit : Integer
$limit:=2222000
Case of 
	: ($message="ConsoleClose")
		CANCEL:C270
	: ($message="launch")
		var $obWindows : Object
		$obWindows:=WindowCountToShow
		$win_l:=Open form window:C675([Admin:1]; "Console"; Plain form window:K39:10+On the right:K39:3; Screen width:C187-400; 53+$obWindows.topOffset)
		DIALOG:C40([Admin:1]; "Console")
		CLOSE WINDOW:C154($win_l)
		KILL WORKER:C1390("Console")
		POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
	: (Size of array:C274(<>aMessage)>0)
		var $i; $c : Integer
		$c:=Size of array:C274(<>aMessage)
		For ($i; 1; $c)
			APPEND TO ARRAY:C911(atConsoleStack; <>aMessage{$i})
		End for 
		ARRAY TEXT:C222(<>aMessage; 0)
		If ($message#"")
			//APPEND TO ARRAY(atConsoleStack; $message)
		End if 
		//If (Not(Semaphore("$ConsoleBusy"; 300)))  // wait 5 seconds if array is busy, set busy when ready
		Case of 
			: (Size of array:C274(atConsoleStack)=0)
				
			: (iLoaText1=1)  // new at top
				Repeat 
					vMessage:=atConsoleStack{1}+"\r"+vMessage
					DELETE FROM ARRAY:C228(atConsoleStack; 1; 1)
				Until (Size of array:C274(atConsoleStack)=0)
				
				// ### jwm ### 20170207_1354 limit size of text protect against overflow
				
				$length:=Length:C16(vmessage)
				If ($length>$limit)
					vMessage:=Substring:C12(vMessage; 1; $limit)  // get first characters up to limit
				End if 
				
			: (iLoaText1=2)  // new at bottom
				Repeat 
					vMessage:=vMessage+"\r"+atConsoleStack{1}
					$viPos:=Length:C16(vMessage)+1
					HIGHLIGHT TEXT:C210(vMessage; $viPos; $viPos)  // put cursor at end // ### jwm ### 20160912_2113
					// ### bj ### 20200122_1335
					If (Size of array:C274(atConsoleStack)>0)
						DELETE FROM ARRAY:C228(atConsoleStack; 1; 1)
					End if 
				Until (Size of array:C274(atConsoleStack)=0)
				
				// ### jwm ### 20170207_1354 limit size of text protect against overflow
				$length:=Length:C16(vmessage)
				If ($length>$limit)
					vMessage:=Substring:C12(vMessage; ($length-$limit))  // get last characters up to limit
				End if 
				
			: (iLoaText1=3)  // replace
				Repeat 
					vMessage:=atConsoleStack{1}
					DELETE FROM ARRAY:C228(atConsoleStack; 1; 1)
				Until (Size of array:C274(atConsoleStack)=0)
			Else 
				vMessage:=""
		End case 
		//CLEAR SEMAPHORE("$ConsoleBusy")  // clear busy status
		//End if 
End case 