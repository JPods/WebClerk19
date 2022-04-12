//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/19/12, 17:55:32
// ----------------------------------------------------
// Method: Method: KeyStrokeHandle
// Description
// 
//
// Parameters
// ----------------------------------------------------


// Handle keystroke project method
// Handle keystroke ( Pointer ; Pointer) -> Boolean
// Handle keystroke ( -> srcArea ; -> curValue) -> Is new value

C_POINTER:C301($1; $2)
C_TEXT:C284($vtNewValue)
C_LONGINT:C283($vlStart; $vlEnd)
// Get the text selection range within the enterable area
GET HIGHLIGHT:C209($1->; $vlStart; $vlEnd)
// Start working with the current value
$vtNewValue:=$2->
// Depending on the key pressed or the character entered,
// Perform the appropriate actions
Case of 
		
		// The Backspace (Delete) key has been pressed
	: (Character code:C91(Keystroke:C390)=Backspace:K15:36)
		// Delete the selected characters or the character at the left of the text cursor
		$vtNewValue:=Substring:C12($vtNewValue; 1; $vlStart-1-Num:C11($vlStart=$vlEnd))+Substring:C12($vtNewValue; $vlEnd)
		
		// An acceptable character has been entered
	: (Position:C15(Keystroke:C390; "abcdefghjiklmnopqrstuvwxyz -0123456789")>0)
		If ($vlStart#$vlEnd)
			// One or several characters are selected, the keystroke is going to override them
			$vtNewValue:=Substring:C12($vtNewValue; 1; $vlStart-1)+Keystroke:C390+Substring:C12($vtNewValue; $vlEnd)
		Else 
			// The text selection is the text cursor
			Case of 
					// The text cursor is currently at the begining of the text
				: ($vlStart<=1)
					// Insert the character at the begining of the text
					$vtNewValue:=Keystroke:C390+$vtNewValue
					// The text cursor is currently at the end of the text
				: ($vlStart>=Length:C16($vtNewValue))
					// Append the character at the end of the text
					$vtNewValue:=$vtNewValue+Keystroke:C390
				Else 
					// The text cursor is somewhere in the text, insert the new character
					$vtNewValue:=Substring:C12($vtNewValue; 1; $vlStart-1)+Keystroke:C390+Substring:C12($vtNewValue; $vlStart)
			End case 
		End if 
		
		// An Arrow key has been pressed
		// Do nothing, but accept the keystroke
	: (Character code:C91(Keystroke:C390)=Left arrow key:K12:16)
	: (Character code:C91(Keystroke:C390)=Right arrow key:K12:17)
	: (Character code:C91(Keystroke:C390)=Up arrow key:K12:18)
	: (Character code:C91(Keystroke:C390)=Down arrow key:K12:19)
		//
	Else 
		// Do not accept characters other than letters, digits, space and dash
		FILTER KEYSTROKE:C389("")
End case 
// Is the value now different?
$0:=($vtNewValue#$2->)
// Return the value for the next keystroke handling
$2->:=$vtNewValue