// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/16/10, 01:00:30
// ----------------------------------------------------
// Method: Form Method: FlowMap
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		Pict_InputLo(->[Control:1]; 1; 8)  //get PICT resc 21001
		SET WINDOW TITLE:C213("Automating Sales for Time-Profit-Control")
		bNewRec:=0
	: (Outside call:C328)
		If (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
			Quit_Processes
		End if 
	Else 
		
End case 