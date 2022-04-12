//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WCCQAAnswers
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 


C_LONGINT:C283($1; $err; $userRec)
C_POINTER:C301($2)
//
READ WRITE:C146([QQQRemoteUser:57])
READ WRITE:C146([EventLog:75])
C_LONGINT:C283($w; $h; $t; $TableNum)
C_TEXT:C284($cat; $ser; $val; $suffix; $userName; $recordID)
$pageDo:=<>WebFolder+"Error.html"
//TRACE
//If (Not((<>vbSaleLevel<1)|(<>vMakeSales<1)))
vResponse:="Must be signed in to use this feature"
//Else 
$recordiD:=WCapi_GetParameter("RecordiD"; "")
$tableStr:=WCapi_GetParameter("TableNum"; "")
$TableNum:=Num:C11($tableStr)
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")