// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/01/11, 23:22:19
// ----------------------------------------------------
// Method: Object Method: bLink
// Description
// 
//
// Parameters
// ----------------------------------------------------
$securityLevel:=1  //
Case of 
	: (Storage:C1525.user.securityLevel>$securityLevel)
		$securityLevel:=Storage:C1525.user.securityLevel
	: (allowAlerts_boo)
		$securityLevel:=Storage:C1525.user.securityLevel
	: (viEndUserSecurityLevel=0)
		$securityLevel:=1
	Else 
		$securityLevel:=viEndUserSecurityLevel
End case 
READ ONLY:C145([TallyMaster:60])
QUERY:C277([TallyMaster:60]; [TallyMaster:60]publish:25>0; *)  // Modified by: williamjames (110516)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=$securityLevel; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8="InvoiceSync"; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="Execute_Tally")

iLoText10:=[TallyMaster:60]build:6  //used to get the records to export
iLoText11:=[TallyMaster:60]script:9  //executes in each record loop
iLoText12:=[TallyMaster:60]after:7  //

NTK_DeleteRequest
HTTPClient_URL:="http://"+vLink
NTK_SetURL(HTTPClient_URL)
SET BLOB SIZE:C606(HTTP_Data; 0)
SET BLOB SIZE:C606(HTTP_Data; 0)
HTTP_TimeOut:=10  //seconds

HTTPSendText:=iLoText10  //[TallyMaster]Build

SET BLOB SIZE:C606(HTTP_Data; 0)
TEXT TO BLOB:C554(HTTPSendText; HTTP_Data; UTF8 text without length:K22:17; *)

//  ?????
//$error:=NTK_Request ("Get")   // ### jwm ### 20181217_1550 compiler error


