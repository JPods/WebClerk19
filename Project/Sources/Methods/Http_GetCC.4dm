//%attributes = {"publishedWeb":true}
//Procedure: Http_GetCC
C_LONGINT:C283($1)
C_POINTER:C301($2)

If ([EventLog:75]id:54#vleventID)
	If ([EventLog:75]value:7>0)
		$err:=WC_PageSendWithTags($c; WC_DoPage(<>webSecure; ""); 0)
	Else 
		$err:=WC_PageSendWithTags($c; WC_DoPage("UnAuthorized.html"; ""); 0)
	End if 
Else 
	$err:=WC_PageSendWithTags($c; WC_DoPage("UnAuthorized.html"; ""); 0)
End if 
//
//
//<form method=post action="https://www.anacom.com/order/username
///default.htm">
//<input type=hidden name=fulltotal value="payment_amount">
//<input type=hidden name=returnlink value="http://www.mysite.com
///index.htm">
//<input type=hidden name=ordernumber value=###>
//<input type=submit value="Click Here for Secure Credit Card Payment">
//</form>
//


//test location, https://www.anacom.com/order/demosecurepay/default.htm