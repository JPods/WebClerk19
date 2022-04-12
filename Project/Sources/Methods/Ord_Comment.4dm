//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-05-30T00:00:00, 10:17:23
// ----------------------------------------------------
// Method: Ord_Comment
// Description
// Modified: 05/30/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


//Procedure: Ord_Comment

//array TEXT(aLoOrdComme;9)
//aLoOrdComme{1}:="Process"
//aLoOrdComme{2}:="Comment"
//aLoOrdComme{3}:="Alert"
//aLoOrdComme{4}:="ShipInstructions"
//aLoOrdComme{5}:="FAX"
//aLoOrdComme{6}:="eMail"
//aLoOrdComme{7}:="Cust/Vend Comment"
//aLoOrdComme{8}:="Cust/Vend Ship"
//aLoOrdComme{9}:="Cust/Vend Alert"
//    aLoOrdComme:=1
//Method: Ord_Comment
C_LONGINT:C283($1)
If ($1=1)
	Case of 
		: (ptCurTable=(->[Invoice:26]))
			Case of 
				: (aLoOrdComme=1)
					[Invoice:26]commentProcess:73:=vOrdComment
				: (aLoOrdComme=2)
					[Invoice:26]comment:43:=vOrdComment
				: (aLoOrdComme=3)
					[Invoice:26]alertMessage:74:=vOrdComment
				: (aLoOrdComme=4)
					[Invoice:26]shipInstruct:40:=vOrdComment
				: (aLoOrdComme=5)
					[Invoice:26]fax:75:=vOrdComment
				: (aLoOrdComme=6)
					[Invoice:26]email:76:=vOrdComment
				: (aLoOrdComme=7)
					[Customer:2]comment:15:=vOrdComment
				: (aLoOrdComme=8)
					[Customer:2]shipInstruct:24:=vOrdComment
				: (aLoOrdComme=9)
					[Customer:2]alertMessage:79:=vOrdComment
			End case 
		: (ptCurTable=(->[Order:3]))
			Case of 
				: (aLoOrdComme=1)
					[Order:3]commentProcess:12:=vOrdComment
				: (aLoOrdComme=2)
					[Order:3]comment:33:=vOrdComment
				: (aLoOrdComme=3)
					[Order:3]alertMessage:80:=vOrdComment
				: (aLoOrdComme=4)
					[Order:3]shipInstruct:46:=vOrdComment
				: (aLoOrdComme=5)
					[Order:3]fax:81:=vOrdComment
				: (aLoOrdComme=6)
					[Order:3]email:82:=vOrdComment
				: (aLoOrdComme=7)
					[Customer:2]comment:15:=vOrdComment
				: (aLoOrdComme=8)
					[Customer:2]shipInstruct:24:=vOrdComment
				: (aLoOrdComme=9)
					[Customer:2]alertMessage:79:=vOrdComment
			End case 
		: (ptCurTable=(->[Proposal:42]))
			Case of 
				: (aLoOrdComme=1)
					[Proposal:42]commentProcess:64:=vOrdComment
				: (aLoOrdComme=2)
					[Proposal:42]comment:36:=vOrdComment
					//: (aLoOrdComme=3)
					//[Proposal]Comment:=vOrdComment
				: (aLoOrdComme=3)
					[Proposal:42]alertMessage:65:=vOrdComment
				: (aLoOrdComme=4)
					[Proposal:42]shipInstruct:35:=vOrdComment
				: (aLoOrdComme=5)
					[Proposal:42]fax:67:=vOrdComment
				: (aLoOrdComme=6)
					[Proposal:42]email:68:=vOrdComment
				: (aLoOrdComme=7)
					[Customer:2]comment:15:=vOrdComment
				: (aLoOrdComme=8)
					[Customer:2]shipInstruct:24:=vOrdComment
				: (aLoOrdComme=9)
					[Customer:2]alertMessage:79:=vOrdComment
			End case 
		: (ptCurTable=(->[PO:39]))
			Case of 
				: (aLoOrdComme=1)
					[PO:39]commentProcess:63:=vOrdComment
				: (aLoOrdComme=2)
					[PO:39]comment:27:=vOrdComment
				: (aLoOrdComme=3)
					[PO:39]alertMessage:62:=vOrdComment
				: (aLoOrdComme=4)
					[PO:39]shipInstruct:31:=vOrdComment
				: (aLoOrdComme=5)
					[PO:39]vendorFax:78:=vOrdComment
				: (aLoOrdComme=6)
					[PO:39]vendorEmail:79:=vOrdComment
				: (aLoOrdComme=7)
					[PO:39]commentVendor:71:=vOrdComment
				: (aLoOrdComme=8)
					[Vendor:38]comment:54:=vOrdComment
				: (aLoOrdComme=9)
					[Vendor:38]alertMessage:70:=vOrdComment
			End case 
	End case 
Else 
	If (Before:C29)
		vOrdComment:=""
		C_LONGINT:C283($w)
		aLoOrdComme:=2
		If (Size of array:C274(<>aEmpPref)>0)
			If ((Num:C11(<>aEmpPref{3})>0) & (Num:C11(<>aEmpPref{3})<=9))
				aLoOrdComme:=Num:C11(<>aEmpPref{3})
			End if 
		End if 
	End if 
	Case of 
		: (ptCurTable=(->[Invoice:26]))
			Case of 
				: (aLoOrdComme=1)
					vOrdComment:=[Invoice:26]commentProcess:73
				: (aLoOrdComme=2)
					vOrdComment:=[Invoice:26]comment:43
				: (aLoOrdComme=3)
					vOrdComment:=[Invoice:26]alertMessage:74
				: (aLoOrdComme=4)
					vOrdComment:=[Invoice:26]shipInstruct:40
				: (aLoOrdComme=5)
					vOrdComment:=[Invoice:26]fax:75
				: (aLoOrdComme=6)
					vOrdComment:=[Invoice:26]email:76
				: (aLoOrdComme=7)
					vOrdComment:=[Customer:2]comment:15
				: (aLoOrdComme=8)
					vOrdComment:=[Customer:2]shipInstruct:24
				: (aLoOrdComme=9)
					vOrdComment:=[Customer:2]alertMessage:79
				Else 
					ALERT:C41("Command Click on tab to set default")
			End case 
		: (ptCurTable=(->[Order:3]))
			Case of 
				: (aLoOrdComme=1)
					vOrdComment:=[Order:3]commentProcess:12
				: (aLoOrdComme=2)
					vOrdComment:=[Order:3]comment:33
				: (aLoOrdComme=3)
					vOrdComment:=[Order:3]alertMessage:80
				: (aLoOrdComme=4)
					vOrdComment:=[Order:3]shipInstruct:46
				: (aLoOrdComme=5)
					vOrdComment:=[Order:3]fax:81
				: (aLoOrdComme=6)
					vOrdComment:=[Order:3]email:82
				: (aLoOrdComme=7)
					vOrdComment:=[Customer:2]comment:15
				: (aLoOrdComme=8)
					vOrdComment:=[Customer:2]shipInstruct:24
				: (aLoOrdComme=9)
					vOrdComment:=[Customer:2]alertMessage:79
				Else 
					ALERT:C41("Command Click on tab to set default")
			End case 
		: (ptCurTable=(->[Proposal:42]))
			Case of 
				: (aLoOrdComme=1)
					vOrdComment:=[Proposal:42]commentProcess:64
				: (aLoOrdComme=2)
					vOrdComment:=[Proposal:42]comment:36
				: (aLoOrdComme=3)
					vOrdComment:=[Proposal:42]alertMessage:65
				: (aLoOrdComme=4)
					vOrdComment:=[Proposal:42]shipInstruct:35
				: (aLoOrdComme=5)
					vOrdComment:=[Proposal:42]fax:67
				: (aLoOrdComme=6)
					vOrdComment:=[Proposal:42]email:68
				: (aLoOrdComme=7)
					vOrdComment:=[Customer:2]comment:15
				: (aLoOrdComme=8)
					vOrdComment:=[Customer:2]shipInstruct:24
				: (aLoOrdComme=9)
					vOrdComment:=[Customer:2]alertMessage:79
				Else 
					ALERT:C41("Command Click on tab to set default")
			End case 
		: (ptCurTable=(->[PO:39]))
			Case of 
				: (aLoOrdComme=1)
					vOrdComment:=[PO:39]commentProcess:63
				: (aLoOrdComme=2)
					vOrdComment:=[PO:39]comment:27
				: (aLoOrdComme=3)
					vOrdComment:=[PO:39]alertMessage:62
				: (aLoOrdComme=4)
					vOrdComment:=[PO:39]shipInstruct:31
				: (aLoOrdComme=5)
					vOrdComment:=[PO:39]vendorFax:78
				: (aLoOrdComme=6)
					vOrdComment:=[PO:39]vendorEmail:79
				: (aLoOrdComme=7)
					vOrdComment:=[PO:39]commentVendor:71
				: (aLoOrdComme=8)
					vOrdComment:=[Vendor:38]comment:54
				: (aLoOrdComme=9)
					vOrdComment:=[Vendor:38]alertMessage:70
				Else 
					ALERT:C41("Command Click on tab to set default")
			End case 
	End case 
End if 
//