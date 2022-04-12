//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: HTMLPageHeadMake
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($0; $1; $tempName)
If (Count parameters:C259=0)
	$tempName:="StandardTemplate.txt"
Else 
	$tempName:=$1
End if 
If (HFS_Exists(Storage:C1525.folder.jitPrefPath+$tempName)=1)
	sumDoc:=Open document:C264(Storage:C1525.folder.jitPrefPath+$tempName)
	If (OK=1)
		<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
		RECEIVE PACKET:C104(sumDoc; $headerText; <>vEoF)
		CLOSE DOCUMENT:C267(sumDoc)
	End if 
Else 
	$headerText:="<!DOCTYPE HTML PUBLIC "+Txt_Quoted("-//W3C//DTD HTML 4.0//EN")+"\r"+"\t"+"\t"+"\t"
	$headerText:=$headerText+Txt_Quoted("http://www.w3.org/TR/REC-html40/strict.dtd")+">"+"\r"
	$headerText:=$headerText+"<HTML>"+"\r"+"<HEAD>"+"\r"+"_jit_-3_standardHead.txtjj"+"\r"+"</HEAD>"+"\r"+"<BODY class="+Txt_Quoted("MenuBody")+">"+"\r"+"_jit_-3_standardBody.txtjj"+"\r"
End if 
$0:=$headerText