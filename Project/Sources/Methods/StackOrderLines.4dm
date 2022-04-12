//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-09-28T00:00:00, 18:24:23
// ----------------------------------------------------
// Method: StackOrderLines
// Description
// Modified: 09/28/13
// 
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $action)
$action:=$1
Case of 
	: ($action=1)
		APPEND TO ARRAY:C911(aOrderLineStack; Record number:C243([OrderLine:49]))
		PUSH RECORD:C176([OrderLine:49])
		
	: ($action=2)
		
		$cntOrderStack:=Size of array:C274(aOrderLineStack)
		If ($cntOrderStack>0)
			For ($incOrderStack; 1; $cntOrderStack)
				POP RECORD:C177([OrderLine:49])
			End for 
			ARRAY LONGINT:C221(aOrderLineStack; 0)
		End if 
	: ($action=3)
		
		
End case 