//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-01T00:00:00, 21:13:05
// ----------------------------------------------------
// Method: WC_ErrorPageMaster
// Description
// Modified: 09/01/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(<>vHTTPErrorPage)
If (Test path name:C476(Storage:C1525.wc.webFolder+"Error.html")=1)
	// open document ReadOnly
	$docRef:=Open document:C264(Storage:C1525.wc.webFolder+"Error.html"; "*"; Read mode:K24:5)
	If (OK=1)
		C_TEXT:C284($docText)
		<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
		RECEIVE PACKET:C104($docRef; <>vHTTPErrorPage; <>vEoF)
		CLOSE DOCUMENT:C267($docRef)
	End if 
Else 
	<>vHTTPErrorPage:="<!DOCTYPE HTML PUBLIC "+Txt_Quoted("-//W3C//DTD HTML 4.0//EN")+" "+Txt_Quoted("http://www.w3.org/TR/REC-html40/strict.dtd")+">"
	<>vHTTPErrorPage:=<>vHTTPErrorPage+"\r"+"<HTML>"+"\r"+"<HEAD>"+"\r"+"_jit_-3_StandardHead.txtjj"+"\r"+"</HEAD>"+"\r"+"<BODY>"
	<>vHTTPErrorPage:=<>vHTTPErrorPage+"\r"+"_jit_-3_StandardBody.txtjj"+"\r"+"_jit_0_vResponsejj"+"\r"+"</BODY>"+"\r"+"</HTML>"
End if 
UNLOAD RECORD:C212([TallyResult:73])