//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-12-01T00:00:00, 16:19:22
// ----------------------------------------------------
// Method: UserGroupScript
// Description
// Modified: 12/01/16
// 
// 
//
// Parameters
// ----------------------------------------------------


//Script Users & Groups CSV Export 20091230
vC:=Char:C90(44)
vDQ:=Char:C90(34)  //DoubleQuote
vDQC:=Char:C90(34)+Char:C90(44)
vCRLF:=Char:C90(13)+Char:C90(10)
vCR:=Char:C90(13)
vi1:=0
vi3:=0

ARRAY TEXT:C222(atGroupName; 0)
ARRAY LONGINT:C221(aiGroupNum; 0)
ARRAY TEXT:C222(atUserName; 0)
ARRAY LONGINT:C221(aiUserNum; 0)
ARRAY TEXT:C222(atRptUserName; 0)
ARRAY TEXT:C222(atRptGroupName; 0)

APPEND TO ARRAY:C911(atRptUserName; "UserName")
APPEND TO ARRAY:C911(atRptGroupName; "GroupName")

GET USER LIST:C609(atUserName; aiUserNum)
GET GROUP LIST:C610(atGroupName; aiGroupNum)

vi2:=Size of array:C274(atGroupName)
vi4:=Size of array:C274(atUserName)

For (vi3; 1; vi4)
	For (vi1; 1; vi2)
		If (User in group:C338(atUserName{vi3}; atGroupName{vi1}))
			APPEND TO ARRAY:C911(atRptUserName; atUserName{vi3})
			APPEND TO ARRAY:C911(atRptGroupName; atGroupName{vi1})
		End if 
	End for 
End for 

myDoc:=Create document:C266("")
vi2:=Size of array:C274(atRptUserName)
For (vi1; 1; vi2)
	
	SEND PACKET:C103(myDoc; vDQ+atRptUserName{vi1}+vDQ+vC)
	SEND PACKET:C103(myDoc; vDQ+atRptGroupName{vi1}+vDQ+vCRLF)
	
End for 

CLOSE DOCUMENT:C267(myDoc)
