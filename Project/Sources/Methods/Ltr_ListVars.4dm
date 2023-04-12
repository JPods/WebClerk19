//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/10/18, 00:03:30
// ----------------------------------------------------
// Method: Ltr_ListVars
// Description
//
//
// Parameters
// ----------------------------------------------------
var $1; $tableName : Text
var $i; $k; $w : Integer
var ptField : Pointer
var LtrSignedBy : Text
var pvAddressVendor : Text
$k:=1
ARRAY TEXT:C222(SRVarNames; 3)
SRVarNames{1}:="DearContact"
SRVarNames{2}:="LtrAttn"
SRVarNames{3}:="LtrSignedBy"
Case of 
	: (($tableName="Letter") | ($tableName="Service"))
		INSERT IN ARRAY:C227(SRVarNames; (Size of array:C274(SRVarNames)+1); 9)
		SRVarNames{(Size of array:C274(SRVarNames)-8)}:="pvAddressCustomer"
		SRVarNames{(Size of array:C274(SRVarNames)-7)}:="pvAddressRep"
		SRVarNames{(Size of array:C274(SRVarNames)-6)}:="pvFAX"
		SRVarNames{(Size of array:C274(SRVarNames)-5)}:="pvPhone"
		SRVarNames{(Size of array:C274(SRVarNames)-4)}:="pvAddressShip"
		SRVarNames{(Size of array:C274(SRVarNames)-3)}:="pvMfgName"
		SRVarNames{(Size of array:C274(SRVarNames)-2)}:="pvMfgAddress"
		SRVarNames{(Size of array:C274(SRVarNames)-1)}:="pvMfgPhone"
		SRVarNames{(Size of array:C274(SRVarNames)-0)}:="pvMfgFAX"
	: (($tableName="Customer") | ($tableName="Contact") | ($tableName="Order") | ($tableName="Invoice") | ($tableName="Proposal"))
		INSERT IN ARRAY:C227(SRVarNames; (Size of array:C274(SRVarNames)+1); 4)
		SRVarNames{(Size of array:C274(SRVarNames)-3)}:="CustAddress"
		SRVarNames{(Size of array:C274(SRVarNames)-2)}:="pvAddressOnly"
		SRVarNames{(Size of array:C274(SRVarNames)-1)}:="pvPhone"
		SRVarNames{(Size of array:C274(SRVarNames)-0)}:="pvFAX"
		
		If ($tableName="Order")
			
			INSERT IN ARRAY:C227(SRVarNames; (Size of array:C274(SRVarNames)+1); 5)
			SRVarNames{(Size of array:C274(SRVarNames)-4)}:="ShipAddress"
			SRVarNames{(Size of array:C274(SRVarNames)-3)}:="MfgName"
			SRVarNames{(Size of array:C274(SRVarNames)-2)}:="MfgAddress"
			SRVarNames{(Size of array:C274(SRVarNames)-1)}:="MfgPhone"
			SRVarNames{(Size of array:C274(SRVarNames)-0)}:="MfgFAX"
			
		Else   //  : ((<>ptPrintFile=([Invoice")|(<>ptPrintFile=([Proposal"))
			INSERT IN ARRAY:C227(SRVarNames; (Size of array:C274(SRVarNames)+1); 1)
			SRVarNames{Size of array:C274(SRVarNames)}:="ShipAddress"
			
		End if 
	: (($tableName="Rep") | ($tableName="RepContact"))
		INSERT IN ARRAY:C227(SRVarNames; (Size of array:C274(SRVarNames)+1); 4)
		SRVarNames{(Size of array:C274(SRVarNames)-3)}:="RepAddress"
		SRVarNames{(Size of array:C274(SRVarNames)-2)}:="pvAddressOnly"
		SRVarNames{(Size of array:C274(SRVarNames)-1)}:="pvPhone"
		SRVarNames{(Size of array:C274(SRVarNames)-0)}:="pvFAX"
		
	: (($tableName="Vendor") | ($tableName="PO") | ($tableName="POLine"))
		ptField:=->[Vendor:38]vendorID:1
		INSERT IN ARRAY:C227(SRVarNames; (Size of array:C274(SRVarNames)+1); 4)
		SRVarNames{(Size of array:C274(SRVarNames)-3)}:="pvAddressVendor"
		SRVarNames{(Size of array:C274(SRVarNames)-2)}:="pvAddressOnly"
		SRVarNames{(Size of array:C274(SRVarNames)-1)}:="pvPhone"
		SRVarNames{(Size of array:C274(SRVarNames)-0)}:="pvFAX"
		QUERY:C277([Letter:20];  & [Letter:20]tableNum:8=Table:C252(->[Vendor:38]); *)
		
End case 

//
$k:=Size of array:C274(SRVarNames)
$w:=$k+1
INSERT IN ARRAY:C227(SRVarNames; $w; 10)
$k:=$k+10
$i:=1
Repeat 
	SRVarNames{$w}:="vR"+String:C10($i)
	$i:=$i+1
	$w:=$w+1
Until ($w>$k)
INSERT IN ARRAY:C227(SRVarNames; $w; 10)
$k:=$k+10
$i:=1

Repeat 
	SRVarNames{$w}:="vText"+String:C10($i)
	$i:=$i+1
	$w:=$w+1
Until ($w>$k)
$w:=$k
INSERT IN ARRAY:C227(SRVarNames; $w+1; 17)
SRVarNames{$w+1}:="Storage.default.company"
SRVarNames{$w+2}:="Storage.default.address1"
SRVarNames{$w+3}:="Storage.default.address2"
SRVarNames{$w+4}:="Storage.default.city"
SRVarNames{$w+5}:="Storage.default.state"
SRVarNames{$w+6}:="Storage.default.fob"
SRVarNames{$w+7}:="Storage.default.zip"
SRVarNames{$w+8}:="Storage.default.country"
SRVarNames{$w+9}:="Storage.default.phone"
SRVarNames{$w+10}:="Storage.default.fax"
SRVarNames{$w+11}:="Storage.default.address"
SRVarNames{$w+12}:="Storage.default.email"
SRVarNames{$w+13}:="Storage.default.domain"
SRVarNames{$w+14}:="SRDate"
SRVarNames{$w+15}:="SRTime"
SRVarNames{$w+16}:="SRDateLong"
SRVarNames{$w+17}:="SRPage"