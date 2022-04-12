//%attributes = {"publishedWeb":true}
//Procedure: Dup_CustDetail

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/02/14, 14:01:27
// ----------------------------------------------------
// Method: Dup_CustDetail
// Description
// 
// If using -1 By Record Number must have record to keep loaded when calling this procedure.
// Parameters
// $1 = Record to Delete: By Record Num, Previous, or Next
// $2 = Record to Delete
// $3 = Record to Keep
// ----------------------------------------------------

C_LONGINT:C283($1; $2; $3)

srAcct:=[Customer:2]customerID:1

Case of 
	: ($1=-1)
		GOTO RECORD:C242([Customer:2]; $3)  // keep record
		srAcct:=[Customer:2]customerID:1
		GOTO RECORD:C242([Customer:2]; $2)  // Duplicate record
	: ($1=1)  //pull info from previous record into this record
		PREVIOUS RECORD:C110([Customer:2])
	: ($1=0)  //pull info from next record into this record
		NEXT RECORD:C51([Customer:2])
End case 

$thePhone:=[Customer:2]phone:13
$theEmail:=[Customer:2]email:81
$firstName:=[Customer:2]nameFirst:73
$lastName:=[Customer:2]nameLast:23
$comments:=[Customer:2]comment:15
$theFAX:=[Customer:2]fax:66
[Customer:2]action:60:="delete dup"
[Customer:2]dateRetired:111:=Current date:C33  // ### jwm ### 20141002_1403
[Customer:2]actionDate:61:=Current date:C33  // ### jwm ### 20141002_1405
[Customer:2]actionTime:71:=Current time:C178  // ### jwm ### 20141002_1405
SAVE RECORD:C53([Customer:2])
$doCombine:=ConsolidateRecs(->[Customer:2]; ->[Customer:2]customerID:1; ->srAcct; False:C215)
Case of 
	: ($1=-1)
		GOTO RECORD:C242([Customer:2]; $3)
	: ($1=1)
		NEXT RECORD:C51([Customer:2])
	Else 
		PREVIOUS RECORD:C110([Customer:2])
End case 
If ([Customer:2]phone:13="")
	[Customer:2]phone:13:=$thePhone
End if 
If ([Customer:2]email:81="")
	[Customer:2]email:81:=$theEmail
End if 
Case of 
	: (([Customer:2]nameFirst:73="") & ([Customer:2]nameLast:23=""))
		[Customer:2]nameFirst:73:=$firstName
		[Customer:2]nameLast:23:=$lastName
	: ((([Customer:2]nameLast:23#"") & ([Customer:2]nameLast:23#$lastName)) | (([Customer:2]nameFirst:73="") | ([Customer:2]nameFirst:73#$firstName)))
		QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1; *)
		QUERY:C277([Contact:13];  & [Contact:13]nameFirst:2=$firstName; *)
		QUERY:C277([Contact:13];  & [Contact:13]nameLast:4=$lastName)
		If (Records in selection:C76([Contact:13])=0)
			CREATE RECORD:C68([Contact:13])
			
			[Contact:13]customerID:1:=[Customer:2]customerID:1
			Contact_FillRec(->[Customer:2]shipVia:12; ->[Customer:2]company:2; ->[Customer:2]address1:4; ->[Customer:2]address2:5; ->[Customer:2]city:6; ->[Customer:2]state:7; ->[Customer:2]zip:8; ->[Customer:2]country:9; ->[Customer:2]taxJuris:65; ->[Customer:2]zone:57; ->[Customer:2]customerID:1; ->[Customer:2]nameFirst:73; ->[Customer:2]nameLast:23; ->[Customer:2]email:81)
			[Contact:13]nameFirst:2:=$firstName
			[Contact:13]nameLast:4:=$lastName
			SAVE RECORD:C53([Contact:13])
		End if 
End case 
If ([Customer:2]fax:66="")
	[Customer:2]fax:66:=$theFAX
End if 
[Customer:2]comment:15:=[Customer:2]comment:15+"\r"+"  "+"\r"+$comments
SAVE RECORD:C53([Customer:2])
