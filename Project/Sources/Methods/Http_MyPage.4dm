//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/27/07, 05:39:01
// ----------------------------------------------------
// Method: Http_MyPage
// Description
// 
//
// Parameters
// ----------------------------------------------------

//C_LONGINT($1; $3; $c; $doThis; <>vbSaleLevel)
//C_TEXT(vResponse; justMine)
//C_POINTER($2)
//$c:=$1
//$suffix:=""
//$doThis:=0
//$doPage:=WC_DoPage("Error.html"; "")
//vResponse:="Access to this command is not available."
//pvRecordNum:=-3

////zttp_UserGet 
//$postPage:=True
//Case of 
//: ((vWccPrimeRec>-1) & ((vWccTableNum=19) | (vWccTableNum=Table(->[Rep]))))
//WccMyPage($1; $2)
//$postPage:=False
//: (Record number([RemoteUser])>-1)  //Have a record
////$thePage:=RemoteUser_SetEventLog 
//$thePage:=Http_MyPagePageReturn($1; $2)
//$postPage:=False
//$err:=WC_PageSendWithTags($1; $thePage; 0)
//Else 
//$thePage:="Signin.html"
//End case 
//If ($postPage)
//$thePage:=WC_DoPage("Comment.html"; $thePage)
//$err:=WC_PageSendWithTags($1; $thePage; 0)
//End if 
