//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/31/11, 06:50:27
// ----------------------------------------------------
// Method: XMLFillFieldValue
// Description
// 
//
// Parameters
// ----------------------------------------------------
//C_TEXT($1;$2)
//C_LONGINT($foundelement;$3;$theTableNum)
//$theTableNum:=$3
//$foundfield:=Find in array(theFields;$2)//"CustomerName")
//$foundelement:=Find in array(theFields;$1)//"CustomerName")
//If ($foundelement>0)
//UtFillifNotEmpty (Field($theTableNum;theFldNum{$foundelement})->;aXMLValue{$foundelement};1)//fill if empty
//End if 


// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/31/11, 06:50:27
// ----------------------------------------------------
// Method: XMLFillFieldValue
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_LONGINT:C283($foundelement)
$foundelement:=Find in array:C230(aXMLTag; $1)  //"CustomerName")
If ($foundelement>0)
	UtFillifNotEmpty($2; aXMLValue{$foundelement}; 1)  //fill if empty
End if 


