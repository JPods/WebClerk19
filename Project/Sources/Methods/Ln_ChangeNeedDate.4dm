//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/11/10, 13:14:38
// ----------------------------------------------------
// Method: Ln_ChangeNeedDate
// Description
// 11/11/2010 added option for changing all lines or just selected
//
// Parameters
// ----------------------------------------------------


//Method: Ln_ChangeNeedDate
C_POINTER:C301($1)
KeyModifierCurrent
Case of 
	: (CmdKey=1)
		CONFIRM:C162("Change Selected Line Items Need Date and ShipOn Date to Order values?")
		If (OK=1)
			Case of 
				: ($1=(->[PO:39]))
					$k:=Size of array:C274(aRayLines)
					For ($i; 1; $k)
						aPODateExp{aRayLines{$i}}:=[PO:39]dateNeeded:3
					End for 
				: ($1=(->[Order:3]))
					$k:=Size of array:C274(aRayLines)
					For ($i; 1; $k)
						aODateReq{aRayLines{$i}}:=[Order:3]dateNeeded:5
						aoDateShipOn{aRayLines{$i}}:=[Order:3]dateShipOn:31
					End for 
				: ($1=(->[Proposal:42]))
					$k:=Size of array:C274(aPPLnSelect)
					For ($i; 1; $k)
						aPDateExp{aPPLnSelect{$i}}:=[Proposal:42]dateNeeded:4
					End for 
			End case 
		End if 
	: (ShftKey=1)
		CONFIRM:C162("Change Selected Line Items Need Date?")
		If (OK=1)
			Case of 
				: ($1=(->[PO:39]))
					$k:=Size of array:C274(aRayLines)
					For ($i; 1; $k)
						aPODateExp{aRayLines{$i}}:=[PO:39]dateNeeded:3
					End for 
				: ($1=(->[Order:3]))
					$k:=Size of array:C274(aRayLines)
					For ($i; 1; $k)
						aODateReq{aRayLines{$i}}:=[Order:3]dateNeeded:5
						//aoDateShipOn{aRayLines{$i}}:=ShipOnDate (aODateReq{aRayLines{$i}};[Item]LeadTimeSales+[Customer]ShippingDays)
					End for 
				: ($1=(->[Proposal:42]))
					$k:=Size of array:C274(aPPLnSelect)
					For ($i; 1; $k)
						aPDateExp{aPPLnSelect{$i}}:=[Proposal:42]dateNeeded:4
					End for 
			End case 
		End if 
	Else 
		//####_jwm_#### 20101111 added option to change all or just selected Line items
		CONFIRM:C162("Change Need Date for All or Just Selected Items?"; " All Items "; " Selected Items ")
		If (OK=1)
			Case of 
				: ($1=(->[PO:39]))
					$k:=Size of array:C274(aPODateExp)
					For ($i; 1; $k)
						aPODateExp{$i}:=[PO:39]dateNeeded:3
					End for 
					
				: ($1=(->[Order:3]))
					$k:=Size of array:C274(aODateReq)
					For ($i; 1; $k)
						aODateReq{$i}:=[Order:3]dateNeeded:5
						//aoDateShipOn{$i}:=ShipOnDate (aODateReq{$i};[Item]LeadTimeSales+[Customer]ShippingDays)
					End for 
					
				: ($1=(->[Proposal:42]))
					$k:=Size of array:C274(aPDateExp)
					For ($i; 1; $k)
						aPDateExp{$i}:=[Proposal:42]dateNeeded:4
					End for 
					
			End case 
		Else 
			Case of 
				: ($1=(->[PO:39]))
					$k:=Size of array:C274(aRayLines)
					For ($i; 1; $k)
						aPODateExp{aRayLines{$i}}:=[PO:39]dateNeeded:3
					End for 
				: ($1=(->[Order:3]))
					$k:=Size of array:C274(aRayLines)
					For ($i; 1; $k)
						aODateReq{aRayLines{$i}}:=[Order:3]dateNeeded:5
						//aoDateShipOn{aRayLines{$i}}:=ShipOnDate (aODateReq{aRayLines{$i}};[Item]LeadTimeSales+[Customer]ShippingDays)
					End for 
				: ($1=(->[Proposal:42]))
					$k:=Size of array:C274(aPPLnSelect)
					For ($i; 1; $k)
						aPDateExp{aPPLnSelect{$i}}:=[Proposal:42]dateNeeded:4
					End for 
			End case 
		End if 
End case 