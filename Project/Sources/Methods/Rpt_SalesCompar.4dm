//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 05:55:29
// ----------------------------------------------------
// Method: Rpt_SalesCompar
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Archive"))
	C_LONGINT:C283($k; $i; $w)
	If (<>prcControl=1)
		<>prcControl:=0
		Process_InitLocal
		WindowOpenTaskOffSets
		ptCurTable:=(->[Customer:2])
	End if 
	$k:=40
	$w:=1
	ARRAY TEXT:C222(aBullets; $k)
	For ($i; 1; $k)
		// Modified by: Bill James (2017-08-21T00:00:00 - missing specialCharacter to x)
		aBullets{$i}:="x"
	End for 
	ARRAY TEXT:C222(aCustSales; $k)
	aCustSales{1}:="Values/Headers"
	aCustSales{2}:="New Leads"
	aCustSales{3}:="New Customers"
	aCustSales{4}:="$ New Customers"
	aCustSales{5}:="$ Those Customers"
	aCustSales{6}:="Sales Cycle Days"
	aCustSales{7}:="# Calls"
	aCustSales{8}:="# Letters"
	aCustSales{9}:="# Visits"
	aCustSales{10}:="Time Recorded"
	aCustSales{11}:="Pp Count"
	aCustSales{12}:="Pp Value"
	aCustSales{13}:="Pp Avg"
	aCustSales{14}:="Pp x %"
	aCustSales{15}:="Pp 'Won'"
	aCustSales{16}:="Pp Offered $ 'Won'"
	aCustSales{17}:="Pp Offered % 'Won'"
	aCustSales{18}:="Pp Offered $ other"
	aCustSales{19}:="Pp Offered % other"
	//
	aCustSales{20}:="Pp Expect #"
	aCustSales{21}:="Pp Expect $"
	aCustSales{22}:="Pp Closed #"
	aCustSales{23}:="Pp Closed $"
	//
	aCustSales{24}:="Ord Count"
	aCustSales{25}:="Ord Value"
	aCustSales{26}:="Ord Avg"
	aCustSales{27}:="Ord CoGS"
	aCustSales{28}:="Ord Gross $"
	aCustSales{29}:="Ord Gross %"
	aCustSales{30}:="Ord Count BL"
	aCustSales{31}:="Ord Value BL"
	aCustSales{32}:="Ord Cancel $"
	aCustSales{33}:="Inv Count"
	aCustSales{34}:="Inv Value"
	aCustSales{35}:="Inv Avg"
	aCustSales{36}:="Inv CoGS"
	aCustSales{37}:="Inv Gross $"
	aCustSales{38}:="Inv Gross %"
	aCustSales{39}:="Inv Count Recv"
	aCustSales{40}:="Inv Recv $"
	ARRAY TEXT:C222(a20Str1; $k)
	ARRAY TEXT:C222(a20Str2; $k)
	ARRAY TEXT:C222(a20Str3; $k)
	ARRAY TEXT:C222(a20Str4; $k)
	ARRAY TEXT:C222(a20Str5; $k)
	ARRAY TEXT:C222(a20Str6; $k)
	ARRAY TEXT:C222(a20Str7; $k)
	ARRAY TEXT:C222(a20Str8; $k)
	ARRAY TEXT:C222(a20Str9; $k)
	ARRAY TEXT:C222(a20Str10; $k)
	a20Str1{1}:="Period1"
	a20Str2{1}:="Period2"
	a20Str3{1}:="Diff"
	//
	ARRAY TEXT:C222(aCustAcct; 8)
	aCustAcct{1}:="Canceled"
	aCustAcct{2}:="Customer"
	aCustAcct{3}:="Mfgs"
	aCustAcct{4}:="Order"
	aCustAcct{5}:="Proposal"
	aCustAcct{6}:="Rep"
	aCustAcct{7}:="Invoice"
	aCustAcct{8}:="SalesNames"
	
	vDate3:=Date:C102(String:C10(Month of:C24(Current date:C33))+"/1/"+String:C10(Year of:C25(Current date:C33)))
	vDate4:=Current date:C33
	vDate1:=vDate3-15
	vDate1:=Date:C102(String:C10(Month of:C24(vDate1))+"/1/"+String:C10(Year of:C25(vDate1)))
	Case of 
		: ((Month of:C24(vDate1)=2) & (Day of:C23(vDate4)>28))
			vDate2:=vDate3-1
		: (Day of:C23(vDate4)>=30)
			vDate2:=vDate3-1
		Else 
			vDate2:=Date:C102(String:C10(Month of:C24(vDate1))+"/"+String:C10(Day of:C23(vDate4))+"/"+String:C10(Year of:C25(vDate1)))
	End case 
	v20Str5:=""
	v20Str1:="Period1"
	v20Str2:="Period2"
	v20Str3:=""
	v20Str4:=""
	
	ControlRecCheck
	DISABLE MENU ITEM:C150(1; 4)
	FORM SET INPUT:C55([Control:1]; "SalesReport")
	ProcessTableOpen(->[Control:1])
	//
	$k:=0
	ARRAY TEXT:C222(a20Str1; $k)
	ARRAY TEXT:C222(a20Str2; $k)
	ARRAY TEXT:C222(a20Str3; $k)
	ARRAY TEXT:C222(a20Str4; $k)
	ARRAY TEXT:C222(a20Str5; $k)
	ARRAY TEXT:C222(a20Str6; $k)
	ARRAY TEXT:C222(a20Str7; $k)
	ARRAY TEXT:C222(a20Str8; $k)
	ARRAY TEXT:C222(a20Str9; $k)
	ARRAY TEXT:C222(a20Str10; $k)
	
	ARRAY TEXT:C222(aCustAcct; 0)
	ARRAY TEXT:C222(aBullets; $k)
	ARRAY TEXT:C222(aCustSales; $k)
	
End if 