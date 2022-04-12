//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
C_TEXT:C284($0; $2)
C_LONGINT:C283($3)
//
C_POINTER:C301($ptFile)
C_TEXT:C284($theProfile)
C_LONGINT:C283($theAddress)
Case of 
	: (Count parameters:C259=0)
		$ptFile:=(->[Contact:13]profile1:18)
		$theProfile:="Primary"
		$theAddress:=0
	: (Count parameters:C259=1)
		$ptFile:=$1
		$theProfile:="Primary"
		$theAddress:=0
	: (Count parameters:C259=2)
		$ptFile:=$1
		$theProfile:=$2
		$theAddress:=0
	: (Count parameters:C259=3)
		$ptFile:=$1
		$theProfile:=$2
		$theAddress:=$3
End case 
$0:=""
QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1; *)
QUERY:C277([Contact:13];  & $ptFile->=$theProfile)
If ([Contact:13]fax:31#"")
	pvFAX:=Format_Phone([Contact:13]fax:31)
Else 
	pvFAX:=Format_Phone([Customer:2]fax:66)
End if 
If ([Contact:13]phone:30#"")
	pvPhone:=Format_Phone([Contact:13]phone:30)
Else 
	pvPhone:=Format_Phone([Customer:2]phone:13)
End if 
CustAddress:=PVars_AddressFull("Contact")
Case of 
	: ($theAddress=0)
		$0:=CustAddress
	: ($theAddress=1)
		$0:=JustAddress
	Else 
		$0:=MainAddress
End case 
