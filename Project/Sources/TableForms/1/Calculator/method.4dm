
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 03/12/18, 15:44:46
// ----------------------------------------------------
// Method: [Control].Calculator
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305(vbClearCalc)

Case of 
		
	: (Before:C29)
		C_REAL:C285(calcNum)
		
		If (vbClearCalc)
			calcString:=""
		End if 
		
		GOTO OBJECT:C206(calcString)
		
End case 