// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/29/06, 15:19:31
// ----------------------------------------------------
// Method: Object Method: iLoInteger1
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (Record number:C243([Customer:2])#-1)
	PUSH RECORD:C176([Customer:2])
	$doPopCustomer:=True:C214
End if 
REDUCE SELECTION:C351([Customer:2]; 0)
REDUCE SELECTION:C351([Contact:13]; 0)
REDUCE SELECTION:C351([Lead:48]; 0)
REDUCE SELECTION:C351([Vendor:38]; 0)
ARRAY LONGINT:C221(iLoaLongInt1; 4)
iLoaLongInt1{1}:=0  //customers
iLoaLongInt1{2}:=0  //leads
iLoaLongInt1{3}:=0  //vendors
iLoaLongInt1{4}:=1  //contac
iLoInteger1:=0
ptPrime:=(->[Control:1])  //deactivate the New button
jCenterWindow(472; 359; 1)
DIALOG:C40([Customer:2]; "FindCustConLead")
//diaFindCusPayme
CLOSE WINDOW:C154
If ((myOK>0) | (Size of array:C274(aRecNum)>0))
	GOTO RECORD:C242([Contact:13]; aRecNum{aRecNum})
	[Service:6]contactid:52:=[Contact:13]idNum:28
	[Service:6]attentionContact:55:=[Contact:13]nameFirst:2+(" "*(Num:C11([Contact:13]nameFirst:2#"")))+[Contact:13]nameLast:4
	[Service:6]companyContact:73:=[Contact:13]company:23
	[Service:6]address1:56:=[Contact:13]address1:6
	[Service:6]address2:57:=[Contact:13]address2:7
	[Service:6]city:58:=[Contact:13]city:8
	[Service:6]state:59:=[Contact:13]state:9
	[Service:6]zip:60:=[Contact:13]zip:11
	[Service:6]country:61:=[Contact:13]country:12
	[Service:6]phone:62:=[Contact:13]phone:30
	[Service:6]phoneCell:63:=[Contact:13]phoneCell:52
	[Service:6]profile1:65:=[Contact:13]profile1:18
	[Service:6]profile2:66:=[Contact:13]profile2:19
	[Service:6]email:64:=[Contact:13]email:35
	If ([Service:6]attention:30="")
		[Service:6]attention:30:=[Service:6]attentionContact:55
	End if 
End if 
If ($doPopCustomer=True:C214)
	POP RECORD:C177([Customer:2])
	srCustomer:=[Customer:2]company:2
	srPhone:=[Customer:2]phone:13
	srZip:=[Customer:2]zip:8
	srAcct:=[Customer:2]customerID:1
End if 
