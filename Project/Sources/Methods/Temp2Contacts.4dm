//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/02/08, 14:30:25
// ----------------------------------------------------
// Method: Temp2Contacts
// Description
// 
//
// Parameters
// ----------------------------------------------------
//this fill from customer table seems weak
var $temp_t : Text
$temp_t:=Storage:C1525.default.shipVia
Contact_FillRec(->$temp_t; ->[Lead:48]company:5; ->[Lead:48]address1:6; ->[Lead:48]address2:7; ->[Lead:48]city:8; ->[Lead:48]state:9; ->[Lead:48]zip:10; ->[Lead:48]country:11; ->[Customer:2]taxJuris:65; ->[Customer:2]zone:57; ->[Customer:2]customerID:1; ->[Lead:48]nameFirst:1; ->[Lead:48]nameLast:2; ->[Lead:48]email:33)
Find Ship Zone(->[Contact:13]zip:11; ->[Contact:13]zone:27; ->[Contact:13]shipVia:26; ->[Contact:13]country:12; ->[Contact:13]siteID:55)

[Contact:13]nameFirst:2:=[Lead:48]nameFirst:1
[Contact:13]nameLast:4:=[Lead:48]nameLast:2
[Contact:13]title:5:=[Lead:48]title:3
[Contact:13]letterList:13:=True:C214
[Contact:13]profile1:18:=[Lead:48]profile1:14
[Contact:13]profile2:19:=[Lead:48]profile2:15
[Contact:13]profile3:20:=[Lead:48]profile3:16
[Contact:13]profile4:21:=[Lead:48]profile4:17
[Contact:13]profile5:22:=[Lead:48]profile5:18
[Contact:13]profile6:36:=[Lead:48]profile6:19
[Contact:13]profile7:37:=[Lead:48]profile7:20
[Contact:13]comment:29:=[Lead:48]comment:24
[Contact:13]email:35:=[Lead:48]email:33
[Contact:13]actionDate:33:=[Lead:48]actionDate:23
[Contact:13]actionTime:34:=[Lead:48]actionTime:28
[Contact:13]action:32:=[Lead:48]action:26
[Contact:13]fax:31:=[Lead:48]fax:29
[Contact:13]phone:30:=[Lead:48]phone:4
C_LONGINT:C283($k; $i)
C_TEXT:C284($contactID; $LeadID)
$contactID:=String:C10([Contact:13]idNum:28)
$leadID:=String:C10([Lead:48]idNum:32)
QUERY:C277([CallReport:34]; [CallReport:34]tableNum:2=Table:C252(->[Lead:48]); *)
QUERY:C277([CallReport:34];  & [CallReport:34]customerID:1=$leadID)
$k:=Records in selection:C76([CallReport:34])
If ($k>0)
	ARRAY TEXT:C222(aTmp10Str1; $k)
	ARRAY LONGINT:C221(aTmpInt1; $k)
	For ($i; 1; $k)
		aTmpInt1{$i}:=13
		aTmp10Str1{$i}:=$contactID
	End for 
	// ### bj ### 20181212_2149 fix this
	ARRAY TO SELECTION:C261(aTmpInt1; [CallReport:34]tableNum:2; aTmp10Str1; [CallReport:34]customerID:1)
End if 
//
QUERY:C277([CommunicationDevice:63]; [CommunicationDevice:63]tableNum:2=Table:C252(->[Lead:48]); *)
QUERY:C277([CommunicationDevice:63];  & [CommunicationDevice:63]customerID:1=$leadID)
$k:=Records in selection:C76([CommunicationDevice:63])
If ($k>0)
	ARRAY TEXT:C222(aTmp10Str1; $k)
	ARRAY LONGINT:C221(aTmpInt1; $k)
	For ($i; 1; $k)
		aTmpInt1{$i}:=13
		aTmp10Str1{$i}:=$contactID
	End for 
	ARRAY TO SELECTION:C261(aTmpInt1; [CommunicationDevice:63]tableNum:2; aTmp10Str1; [CommunicationDevice:63]customerID:1)
End if 
//
QUERY:C277([QA:70]; [QA:70]tableNum:11=Table:C252(->[Lead:48]); *)
QUERY:C277([QA:70];  & [QA:70]customerID:1=$leadID)
$k:=Records in selection:C76([QA:70])
If ($k>0)
	ARRAY TEXT:C222(aTmp10Str1; $k)
	ARRAY LONGINT:C221(aTmpInt1; $k)
	For ($i; 1; $k)
		aTmpInt1{$i}:=13
		aTmp10Str1{$i}:=$contactID
	End for 
	ARRAY TO SELECTION:C261(aTmpInt1; [QA:70]tableNum:11; aTmp10Str1; [QA:70]customerID:1)
End if 
//  
ARRAY TEXT:C222(aTmp10Str1; 0)
ARRAY LONGINT:C221(aTmpInt1; 0)