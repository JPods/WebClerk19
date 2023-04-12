//%attributes = {"publishedWeb":true}
//<form method="post"name="Pay_Capture"action="!xjit=0;tcSecure!">
//<input type="HIDDEN"name="fulltotal"value="!xjit=3;27!">
//<input type="HIDDEN"name="returnlink"value="!xjit=0;tcDotted!">
//<input type="HIDDEN"name="DocID"value="!xjit=0;vleventID!">
//<input type="HIDDEN"name="customerID"value="!xjit=3;1!">
//<input type="HIDDEN"name="AVS"value="">
//<input type="HIDDEN"name="PayAction"value="">
//<input type="HIDDEN"name="PayType"value="">
//<input type="HIDDEN"name="RefNum"value="">
//<input type="HIDDEN"name="AuthNum"value="">
//<INPUT TYPE="HIDDEN"NAME="ordertotal"VALUE="!xjit=3;27!">//
//
//Method: Http_PayTrap
C_LONGINT:C283($1; $p)
C_POINTER:C301($2)
C_DATE:C307($ccDate)

//
//C_TEXT(<>ccWebNum;<>ccWebDate;<>ccWebName)
//C_TEXT($doSecure;$payType;$creditCard;$exDate$theDotted;$custID
//;$payType;$AuthNum;$avs;$refNum)
//C_TEXT(<>eMailAddr;$cardName)
//
//C_BOOLEAN($gotCC)
//:
//$suffix:=""
//C_TEXT($suffix;lang)
//C_REAL($ordVal)
//TRACE
//$fullTotal:=Num(WCapi_GetParameter(fulltotal;""))
//$theDotted:=WCapi_GetParameter(tcDotted;"")
//
//$custID:=WCapi_GetParameter(customerID;"")
//$payType:=WCapi_GetParameter(PayType;"")
//$refNum:=WCapi_GetParameter(RefNum;"")
//$AuthNum:=WCapi_GetParameter(AuthNum;"")
//$avs:=WCapi_GetParameter(AVS;"")
//
//C_REAL($fullTotal)
//C_TEXT($theDotted;$custID;$payType;$AuthNum;$avs;$refNum)
//
//$err:=WC_PageSendWithTags ($1;Storage.wc.webFolder+"SSLRemote.html"+$suffix+".html"
//;0)