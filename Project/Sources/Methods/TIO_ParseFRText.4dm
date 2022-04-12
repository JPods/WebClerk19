//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/28/09, 03:19:51
// ----------------------------------------------------
// Method: TIO_ParseFRText
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($0)  //Resulting pointer to a picture w/ tokenized FR
C_POINTER:C301($1)  //pointer to Info from a FR Text Row of a TextOut Doc
$0:=<>cptNilPoint
C_LONGINT:C283($error)
C_TEXT:C284($FRText)
$FRText:=$1->

If ($error=0)
	C_LONGINT:C283($soa)
	$soa:=Size of array:C274(aTIOPicture)+1
	INSERT IN ARRAY:C227(aTIOPicture; $soa)  //     verion 11
	aTIOPicture{$soa}:=$FRText  //    verion 11
	$0:=->aTIOPicture{$soa}  //    verion 11
End if 
