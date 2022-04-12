//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-24T00:00:00, 14:50:46
// ----------------------------------------------------
// Method: SRE_VarByFile
// Description
// Modified: 10/24/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($w)
C_LONGINT:C283($1; $theArea)
If (Count parameters:C259=0)
	$theArea:=0
Else 
	$theArea:=$1
End if 
ARRAY TEXT:C222(SRVarNames; 64)
$w:=1
SRVarNames{$w}:="1;Your Info"
If (Is macOS:C1572)
	SRVarNames{$w+1}:="1;YourCompany;Storage.default.company;1"
	SRVarNames{$w+2}:="1;YourAdd1;<>tcAddress1;1"
	SRVarNames{$w+3}:="1;YourAdd2;<>tcAddress2;1"
	SRVarNames{$w+4}:="1;YourCity;Storage.default.city;1"
	SRVarNames{$w+5}:="1;YourState;Storage.default.state;1"
	SRVarNames{$w+6}:="1;YourFOB;Storage.default.fob;1"
	SRVarNames{$w+7}:="1;YourZip;Storage.default.zip;1"
	SRVarNames{$w+8}:="1;YourCountry;Storage.default.country;1"
	SRVarNames{$w+9}:="1;YourPhone;Storage.default.phone;1"
	SRVarNames{$w+10}:="1;YourFAX;Storage.default.fax;1"
	SRVarNames{$w+11}:="1;YourFullAdd;Storage.default.address;1"
Else 
	SRVarNames{$w+1}:="1;YourCompany;Storage.default.company;1"
	SRVarNames{$w+2}:="1;YourAdd1;<>tcAddress1;1"
	SRVarNames{$w+3}:="1;YourAdd2;<>tcAddress2;1"
	SRVarNames{$w+4}:="1;YourCity;Storage.default.city;1"
	SRVarNames{$w+5}:="1;YourState;Storage.default.state;1"
	SRVarNames{$w+6}:="1;YourFOB;Storage.default.fob;1"
	SRVarNames{$w+7}:="1;YourZip;Storage.default.zip;1"
	SRVarNames{$w+8}:="1;YourCountry;Storage.default.country;1"
	SRVarNames{$w+9}:="1;YourPhone;Storage.default.phone;1"
	SRVarNames{$w+10}:="1;YourFAX;Storage.default.fax;1"
	SRVarNames{$w+11}:="1;YourFullAdd;Storage.default.address;1"
End if 
SRVarNames{$w+12}:="2;Document Vars"
SRVarNames{$w+13}:="2;pvpage;pvPage;1"
SRVarNames{$w+14}:="2;CustAddress;CustAddress;1"
SRVarNames{$w+15}:="2;ShipToAddress;ShipAddress;1"
SRVarNames{$w+16}:="2;BillToAddress;BillAddress;1"
SRVarNames{$w+17}:="2;CustPhone;pvPhone;1"
SRVarNames{$w+18}:="2;CustFAX;pvFAX;1"
SRVarNames{$w+19}:="2;ShipToPhone;pvDocPhone;1"
SRVarNames{$w+20}:="2;Terms;pvTerms;1"
SRVarNames{$w+21}:="2;RepCode;pvRepAcct;1"
SRVarNames{$w+22}:="2;RepCompany;pvRepCo;1"
SRVarNames{$w+23}:="2;Shipper;vShipper;1"
SRVarNames{$w+24}:="2;ShipperID;vShipperID;1"
SRVarNames{$w+25}:="2;FreightType;vFrghtType;1"
SRVarNames{$w+26}:="2;fExExtAmt;fExtExAmt;1"
SRVarNames{$w+27}:="2;fExExtTax;fExtExTax;1"
SRVarNames{$w+28}:="2;fExExtShip;fExExtShip;1"
SRVarNames{$w+29}:="2;fExExtTtl;fExExtTtl;1"


SRVarNames{$w+30}:="2;pvAddressiS;pvAddressiS;1"
SRVarNames{$w+31}:="2;pvAddressiB;pvAddressiB;1"
SRVarNames{$w+32}:="2;pvPhoneiS;pvPhoneiS;1"
SRVarNames{$w+33}:="2;pvPhoneiB;pvPhoneiB;1"
SRVarNames{$w+34}:="2;pvFaxiS;pvFaxiS;1"
SRVarNames{$w+35}:="2;pvFaxiB;pvFaxiB;1"
SRVarNames{$w+36}:="2;pvPhoneDoc;pvPhoneDoc;1"
SRVarNames{$w+37}:="2;pvFaxDoc;pvFaxDoc;1"
SRVarNames{$w+38}:="2;pveMailAddressDoc;pveMailAddressDoc;1"
SRVarNames{$w+39}:="2;pveMailAddressiB;pveMailAddressiB;1"
SRVarNames{$w+40}:="2;pveMailAddressCo;pveMailAddressCo;1"
//
$w:=$w+41  //29
//
SRVarNames{$w+1}:="3;User Defined"
SRVarNames{$w+2}:="3;vR1;vR1;1"
SRVarNames{$w+3}:="3;vR2;vR2;1"
SRVarNames{$w+4}:="3;vR3;vR3;1"
SRVarNames{$w+5}:="3;vR4;vR4;1"
SRVarNames{$w+6}:="3;vR5;vR5;1"
SRVarNames{$w+7}:="3;vR6;vR6;1"
SRVarNames{$w+8}:="3;vR7;vR7;1"
SRVarNames{$w+9}:="3;vR8;vR8;1"
SRVarNames{$w+10}:="3;vR9;vR9;1"
SRVarNames{$w+11}:="3;vR10;vR10;1"
SRVarNames{$w+12}:="3;vR11;vR11;1"
SRVarNames{$w+12}:="3;vR12;vR12;1"
$w:=$w+12  //41
SRVarNames{$w+1}:="3;vText1;vText1;1"
SRVarNames{$w+2}:="3;vText2;vText2;1"
SRVarNames{$w+3}:="3;vText3;vText3;1"
SRVarNames{$w+4}:="3;vText4;vText4;1"
SRVarNames{$w+5}:="3;vText5;vText5;1"
SRVarNames{$w+6}:="3;vText6;vText6;1"
SRVarNames{$w+7}:="3;vText7;vText7;1"
SRVarNames{$w+8}:="3;vText8;vText8;1"
SRVarNames{$w+9}:="3;vText9;vText9;1"
SRVarNames{$w+10}:="3;vText10;vText10;1"
//51
C_POINTER:C301($ptRptFile)
If ((ptCurTable=(->[UserReport:46])) & ([UserReport:46]tableNum:3#0))
	$ptRptFile:=Table:C252([UserReport:46]tableNum:3)
Else 
	$ptRptFile:=ptCurTable
End if 
Case of 
	: ($ptRptFile=(->[Proposal:42]))
		SRE_PpLnVars
	: ($ptRptFile=(->[Invoice:26]))
		SRE_IvcLnVars
	: ($ptRptFile=(->[Order:3]))
		SRE_OrdLnVars
	: ($ptRptFile=(->[PO:39]))
		SRE_PoLnVars
End case 
If ($theArea#0)
	$result:=SR Variables($theArea; "SRVarNames")
End if 