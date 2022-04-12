//%attributes = {"publishedWeb":true}
C_LONGINT:C283($e; $r)
C_POINTER:C301($1)
prntTypeDoc:="Lead Sheet"
[Customer:2]dateResponse:25:=Current date:C33+<>tcLeadDue
//      SAVE RECORD([Customer])
CustAddress:=PVars_AddressFull("Customer")
prntAcct:=[Customer:2]customerID:1
pvPhone:=Format_Phone([Customer:2]phone:13)
pvFAX:=Format_Phone([Customer:2]fax:66)
v1:=[Customer:2]profile1:26
v2:=[Customer:2]profile2:27
v3:=[Customer:2]profile3:28
v4:=[Customer:2]profile4:29
v5:=[Customer:2]profile5:30
v6:=[Customer:2]prospect:17
v7:=[Customer:2]need:21
prntDateOut:=String:C10([Customer:2]lastSaleDate:49)
prntDateIn:=String:C10([Customer:2]dateResponse:25)

prntRep:=[Customer:2]repID:58
prntSaleID:=[Customer:2]salesNameID:59
prntTypeSal:=[Customer:2]typeSale:18
prntAmt:=String:C10([Customer:2]budget:19; "###,###")  //est yearly sales
prntTax:=String:C10([Customer:2]salesLastYr:48; "###,###")  //Sales last year
prntTotal:=String:C10([Customer:2]salesYTD:47; "###,###")  //Sales YTD      
b68:=Num:C11([Customer:2]profile6:31)
b69:=Num:C11([Customer:2]profile7:32)
prntComment:=[Customer:2]comment:15
If ([Customer:2]individual:72)
	InitContactArra(1)
	aContFName{1}:=[Customer:2]nameFirst:73
	aContLName{1}:=[Customer:2]nameLast:23
	aContTitle{1}:=""
	aContKeyWor{1}:=""
Else 
	If ([Customer:2]customerID:1#[Contact:13]customerID:1)
		QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1; *)
		QUERY:C277([Contact:13];  & [Contact:13]shipToOnly:38=False:C215)
	End if 
	ORDER BY:C49([Contact:13]; [Contact:13]letterList:13; <)
	$r:=Records in selection:C76([Contact:13])
	If (Records in selection:C76([Contact:13])>4)
		$r:=5
	End if 
	InitContactArra($r)
	FIRST RECORD:C50([Contact:13])
	For ($e; 1; $r)
		aContFName{$e}:=[Contact:13]nameFirst:2
		aContLName{$e}:=[Contact:13]nameLast:4
		aContTitle{$e}:=[Contact:13]title:5
		aContKeyWor{$e}:=Substring:C12([Contact:13]keyTags:14; 1; 20)
		NEXT RECORD:C51([Contact:13])
	End for 
End if 
If ($1=(->[Service:6]))
	initStrArray5(2)
	a20Str1{1}:=String:C10([Customer:2]actionTime:71; 5)
	a20Str2{1}:=String:C10([Customer:2]actionDate:61; 1)
	a20Str3{1}:=Substring:C12([Customer:2]salesNameID:59; 1; 20)
	a20Str4{1}:=[Customer:2]action:60
	a20Str5{1}:=[Customer:2]repID:58
	a20Str1{2}:=String:C10(jDateTimeRTime([Service:6]dtAction:35); 5)  //[Service]RS_ActionTime
	a20Str2{2}:=String:C10(jDateTimeRDate([Service:6]dtAction:35); 1)  //
	a20Str3{2}:=Substring:C12([Service:6]actionBy:12; 1; 20)
	a20Str4{2}:=[Service:6]action:20
	a20Str5{2}:=[Service:6]noteType:21
Else 
	QUERY:C277([Service:6]; [Service:6]customerID:1=[Customer:2]customerID:1)
	ORDER BY:C49([Service:6]; [Service:6]dtAction:35; <)
	FIRST RECORD:C50([Service:6])
	$r:=Records in selection:C76([Service:6])+1
	If ($r>4)
		$r:=5
	End if 
	initStrArray5($r)
	a20Str1{1}:=String:C10([Customer:2]actionTime:71; 5)
	a20Str2{1}:=String:C10([Customer:2]actionDate:61; 1)
	a20Str3{1}:=Substring:C12([Customer:2]salesNameID:59; 1; 20)
	a20Str4{1}:=[Customer:2]action:60
	a20Str5{1}:=[Customer:2]repID:58
	FIRST RECORD:C50([Service:6])
	For ($e; 2; $r)
		a20Str1{$e}:=String:C10(jDateTimeRTime([Service:6]dtAction:35); 5)
		a20Str2{$e}:=String:C10(jDateTimeRDate([Service:6]dtAction:35); 1)
		a20Str3{$e}:=Substring:C12([Service:6]actionBy:12; 1; 20)
		a20Str4{$e}:=[Service:6]action:20
		a20Str5{$e}:=[Service:6]noteType:21
		NEXT RECORD:C51([Service:6])
	End for 
End if 