//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-02T00:00:00, 00:41:35
// ----------------------------------------------------
// Method: vCardOut
// Description
// Modified: 01/02/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $tableNum; $cntRecords; $2)
C_POINTER:C301($ptTable)
$doOne:=False:C215
If ($2=1)
	$doOne:=True:C214
End if 
$cntRecords:=$2
$ptTable:=Table:C252($1)
$vCard:=""
For ($i; 1; $cntRecords)
	Case of 
		: ($ptTable=(->[Customer:2]))  //customers
			$vCard:="BEGIN:VCARD"+Storage:C1525.char.crlf
			$vCard:=$vCard+"VERSION:3.0"+Storage:C1525.char.crlf
			$vCard:=$vCard+"N:"+[Customer:2]nameLast:23+";"+[Customer:2]nameFirst:73+";;;"+Storage:C1525.char.crlf
			$vCard:=$vCard+"FN:"+[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23+Storage:C1525.char.crlf
			$vCard:=$vCard+"TITLE:"+[Customer:2]title:3+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=work;Type=pref:"+[Customer:2]phone:13+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=cell:"+[Customer:2]phoneCell:99+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=work;Type=fax:"+[Customer:2]fax:66+Storage:C1525.char.crlf
			$vCard:=$vCard+"ADR;Type=work;Type=pref:;"+[Customer:2]address1:4+";"+[Customer:2]address2:5+";"+[Customer:2]city:6+";"+[Customer:2]state:7+";"+[Customer:2]zip:8+";"+[Customer:2]country:9+Storage:C1525.char.crlf
			$vCard:=$vCard+"END:VCARD"
			//
			If ($cntRecords>1)
				NEXT RECORD:C51([Customer:2])
			End if 
		: ($ptTable=(->[Contact:13]))  //customers
			$vCard:="BEGIN:VCARD"+Storage:C1525.char.crlf
			$vCard:=$vCard+"VERSION:3.0"+Storage:C1525.char.crlf
			$vCard:=$vCard+"N:"+[Contact:13]nameLast:4+";"+[Contact:13]nameFirst:2+";;;"+Storage:C1525.char.crlf
			$vCard:=$vCard+"FN:"+[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4+Storage:C1525.char.crlf
			$vCard:=$vCard+"TITLE:"+[Contact:13]title:5+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=work;Type=pref:"+[Contact:13]phone:30+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=cell:"+[Contact:13]phoneCell:52+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=work;Type=fax:"+[Contact:13]fax:31+Storage:C1525.char.crlf
			$vCard:=$vCard+"ADR;Type=work;Type=pref:;"+[Contact:13]address1:6+";"+[Contact:13]address2:7+";"+[Contact:13]city:8+";"+[Contact:13]state:9+";"+[Contact:13]zip:11+";"+[Contact:13]country:12+Storage:C1525.char.crlf
			$vCard:=$vCard+"END:VCARD"
			//
			If ($cntRecords>1)
				NEXT RECORD:C51([Contact:13])
			End if 
			
		: ($ptTable=(->[Employee:19]))  //customers
			$vCard:="BEGIN:VCARD"+Storage:C1525.char.crlf
			$vCard:=$vCard+"VERSION:3.0"+Storage:C1525.char.crlf
			$vCard:=$vCard+"N:"+[Employee:19]nameLast:2+";"+[Employee:19]nameFirst:3+";;;"+Storage:C1525.char.crlf
			$vCard:=$vCard+"FN:"+[Employee:19]nameFirst:3+" "+[Employee:19]nameLast:2+Storage:C1525.char.crlf
			$vCard:=$vCard+"TITLE:"+[Employee:19]title:22+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=work;Type=pref:"+[Employee:19]phone1:13+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=cell:"+[Employee:19]phone2:14+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=work;Type=fax:"+[Employee:19]fax:15+Storage:C1525.char.crlf
			$vCard:=$vCard+"ADR;Type=work;Type=pref:;"+[Employee:19]address1:17+";"+[Employee:19]address2:18+";"+[Employee:19]city:19+";"+[Employee:19]state:20+";"+[Employee:19]zip:21+";"+[Employee:19]country:37+Storage:C1525.char.crlf
			$vCard:=$vCard+"END:VCARD"
			//
			If ($cntRecords>1)
				NEXT RECORD:C51([Employee:19])
			End if 
			
		: ($ptTable=(->[Rep:8]))  //customers
			$vCard:="BEGIN:VCARD"+Storage:C1525.char.crlf
			$vCard:=$vCard+"VERSION:3.0"+Storage:C1525.char.crlf
			$vCard:=$vCard+"N:"+[Rep:8]nameLast:27+";"+[Rep:8]nameFirst:25+";;;"+Storage:C1525.char.crlf
			$vCard:=$vCard+"FN:"+[Rep:8]nameFirst:25+" "+[Rep:8]nameLast:27+Storage:C1525.char.crlf
			$vCard:=$vCard+"TITLE:"+[Rep:8]title:43+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=work;Type=pref:"+[Rep:8]phone:10+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=cell:"+[Rep:8]phoneCell:41+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=work;Type=fax:"+[Rep:8]fax:20+Storage:C1525.char.crlf
			$vCard:=$vCard+"ADR;Type=work;Type=pref:;"+[Rep:8]address1:4+";"+[Rep:8]address2:5+";"+[Rep:8]city:6+";"+[Rep:8]state:7+";"+[Rep:8]zip:8+";"+[Rep:8]country:9+Storage:C1525.char.crlf
			$vCard:=$vCard+"END:VCARD"
			//
			If ($cntRecords>1)
				NEXT RECORD:C51([Rep:8])
			End if 
			
			
		: ($ptTable=(->[RepContact:10]))  //customers
			$vCard:="BEGIN:VCARD"+Storage:C1525.char.crlf
			$vCard:=$vCard+"VERSION:3.0"+Storage:C1525.char.crlf
			$vCard:=$vCard+"N:"+[RepContact:10]nameLast:5+";"+[RepContact:10]nameFirst:3+";;;"+Storage:C1525.char.crlf
			$vCard:=$vCard+"FN:"+[RepContact:10]nameFirst:3+" "+[RepContact:10]nameLast:5+Storage:C1525.char.crlf
			$vCard:=$vCard+"TITLE:"+[RepContact:10]title:6+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=work;Type=pref:"+[RepContact:10]phone:22+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=cell:"+[RepContact:10]phoneCell:20+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=work;Type=fax:"+[RepContact:10]fax:18+Storage:C1525.char.crlf
			$vCard:=$vCard+"ADR;Type=work;Type=pref:;"+[RepContact:10]address1:7+";"+[RepContact:10]address2:8+";"+[RepContact:10]city:9+";"+[RepContact:10]state:10+";"+[RepContact:10]zip:11+";"+[RepContact:10]country:12+Storage:C1525.char.crlf
			$vCard:=$vCard+"END:VCARD"
			//
			If ($cntRecords>1)
				NEXT RECORD:C51([RepContact:10])
			End if 
			
		: ($ptTable=(->[Vendor:38]))  //customers
			$vCard:="BEGIN:VCARD"+Storage:C1525.char.crlf
			$vCard:=$vCard+"VERSION:3.0"+Storage:C1525.char.crlf
			$vCard:=$vCard+"N:"+[Vendor:38]nameLast:86+";"+[Vendor:38]nameFirst:85+";;;"+Storage:C1525.char.crlf
			$vCard:=$vCard+"FN:"+[Vendor:38]nameFirst:85+" "+[Vendor:38]nameLast:86+Storage:C1525.char.crlf
			$vCard:=$vCard+"TITLE:"+[Vendor:38]title:87+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=work;Type=pref:"+[Vendor:38]phone:10+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=cell:"+[Vendor:38]phoneCell:82+Storage:C1525.char.crlf
			$vCard:=$vCard+"TEL;Type=work;Type=fax:"+[Vendor:38]fax:13+Storage:C1525.char.crlf
			$vCard:=$vCard+"ADR;Type=work;Type=pref:;"+[Vendor:38]address1:4+";"+[Vendor:38]address2:5+";"+[Vendor:38]city:6+";"+[Vendor:38]state:7+";"+[Vendor:38]zip:8+";"+[Vendor:38]country:9+Storage:C1525.char.crlf
			$vCard:=$vCard+"END:VCARD"
			//
			If ($cntRecords>1)
				NEXT RECORD:C51([Vendor:38])
			End if 
	End case 
End for 
If ($vCard#"")
	SET TEXT TO PASTEBOARD:C523($vCard)
End if 
