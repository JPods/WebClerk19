//%attributes = {"publishedWeb":true}
//Method: Http_ReservationSrch
C_LONGINT:C283($w; $h; $t; $1; $thisLibrary)
C_TEXT:C284($cat; $ser; $val)
C_POINTER:C301($2)
C_LONGINT:C283($recNum; $dtBegin; $dtEnd)
C_TEXT:C284($strDateBegin; $strDateEnd)
//zttp_UserGet 
$recNum:=Num:C11(WCapi_GetParameter("RecordID"; ""))
//$strDateBegin:=WCapi_GetParameter("DateBegin";"")
//$strDateEnd:=WCapi_GetParameter("DateEnd";"")
//
$jitPageList:=WCapi_GetParameter("jitPageList"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
REDUCE SELECTION:C351([Reservation:79]; 0)
Case of 
	: ($recNum>0)
		QUERY:C277([Reservation:79]; [Reservation:79]idNum:16=$recNum; *)
		QUERY:C277([Reservation:79];  & [Reservation:79]customerid:3=[Customer:2]customerID:1; *)
		//: (($strDateBegin#"")|($strDateEnd#""))
		//Case of 
		//: (($strDateBegin#"")&($strDateEnd#""))
		//
		//
		//
		//End case 
	Else 
		QUERY:C277([Reservation:79]; [Reservation:79]active:10=True:C214; *)
		QUERY:C277([Reservation:79];  & [Reservation:79]customerid:3=[Customer:2]customerID:1; *)
End case 
QUERY:C277([Reservation:79];  & [Reservation:79]publish:15>0; *)
QUERY:C277([Reservation:79];  & [Reservation:79]publish:15<=viEndUserSecurityLevel)
//
$num:=Records in selection:C76([Reservation:79])
If ($num>1)
	ORDER BY:C49([Reservation:79]; [Reservation:79]dtReservation:18)
End if 
//
Case of 
	: ($num>1)
		$err:=WC_PageSendWithTags($1; WC_DoPage("ReservationsList.html"; $jitPageList); 0)
	: ($num=1)
		$err:=WC_PageSendWithTags($1; WC_DoPage("ReservationsOne.html"; $jitPageOne); 0)
	Else 
		vResponse:="No reservation found at authority level "+String:C10(viEndUserSecurityLevel)
		$err:=WC_PageSendWithTags($1; WC_DoPage("Error"+$suffix+".html"; ""); 0)
End case 

READ WRITE:C146([TallyResult:73])