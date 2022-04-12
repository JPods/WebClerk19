//%attributes = {"publishedWeb":true}
//Procedure: Http_ServerSale
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
$c:=$1
$suffix:=""
$doThis:=0
//zttp_UserGet 
vResponse:=""
//TRACE
Case of 
	: (voState.url="/Reservation_Search@")  //pay the order"
		Http_ReservationSrch($c; $2)
		//:((voState.url="/sales_SaveLead@")&([EventLog]SecurityLevel>
		//=<>vbLeadMod))
		//Http_SaveLead ($c;$2;1)
		//$doThis:=2
		//$thePage:=<>WebFolder+"Lead"+$suffix+".html"
		////
		//: ((voState.url="/sales_SaveCustomer@")&([EventLog]SecurityLevel>
		//=<>vbCustMod))
		//http_SaveCust ($c;$2;1)
		//$doThis:=2
		//$thePage:=WC_DoPage("Customer"+$suffix+".html";"")
	Else 
		vResponse:="No records found matching search and user level."
		$err:=WC_PageSendWithTags($1; WC_DoPage("Error.html"; ""); 0)
End case 
vResponse:=""
vcustomerID:=""