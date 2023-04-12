//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/27/12, 23:03:08
// ----------------------------------------------------
// Method: CMA_PaymentOrderInvoice
// Description
// 
//
// Parameters
// ----------------------------------------------------


variable1:="002001"
variable2:="SarLTD"
variable3:="2200307"
variable4:="33"
//variable1 == mfrID
//variable2 == customerID
//variable3 == [Payment]UniqueID
//variable4 == Amount to be applied
//variable5 == Commission Rate
//variable6 == Split
//variable7 == Date of order
//variable8 == Terms
//variable9 == TypeSale
//variable10 == RepID
//variable11 == AdSource
//variable12 == CustomerPO
//variable13 == srMfgOrd
variable5:="15"
variable6:="60"
variable12:="CustPO234"
variable13:="Mfo45345"
If (Date:C102(variable7)=!00-00-00!)
	variable7:=String:C10(Current date:C33)
End if 
vDate3:=Date:C102(variable7)
vDate2:=vDate3
vDate4:=vDate2+180
srCustPo:=variable12
srMfgOrd:=variable13
allowAlerts_boo:=False:C215
//
MfgItemRay
If (Num:C11(variable4)=0)
	response:="No valid Order Amount"
Else 
	If (Num:C11(variable3)<10)
		response:="No valid Payment UniqueID"
	Else 
		QUERY:C277([Payment:28]; [Payment:28]idNum:8=Num:C11(variable3))
		If (Records in selection:C76([Payment:28])#1)
			response:="No valid Payment record for UniqueID = "+variable3
		Else 
			If (variable1#[Payment:28]customerID:4)
				response:="Payment record "+variable3+" does not match ManufactureID "+variable1
			Else 
				QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=variable1)
				If (Records in selection:C76([ManufacturerTerm:111])#1)
					response:="Payment record "+variable3+" does not have a valid  ManufactureID "+variable2
				Else 
					If (variable8="")
						variable8:=[ManufacturerTerm:111]terms:7
					End if 
					v1:=variable8
					<>aMfg:=Find in array:C230(<>aMfg; variable1)
					//
					vPartNum:="Com"+[ManufacturerTerm:111]customerID:1+"1"
					QUERY:C277([Item:4]; [Item:4]itemNum:1=vPartNum)
					If (Records in selection:C76([Item:4])#1)
						response:="No ItemNum "+vPartNum
					Else 
						aMfgParts:=Find in array:C230(aMfgParts; vPartNum)
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=variable2)
						If (Records in selection:C76([Customer:2])#1)
							response:="No Customer identified "+variable2
						Else 
							If (variable9="")
								variable9:=[Customer:2]typeSale:18
							End if 
							v2:=variable9
							If (variable10="")
								variable10:=[Customer:2]repID:58
							End if 
							v5:=variable10
							If (variable11="")
								variable11:=[Order:3]adSource:41
							End if 
							v5:=variable11
							v4:=vPartNum
							vR7:=vR7
							vAmount:=Num:C11(variable4)
							vR2:=Num:C11(variable5)
							If (vR2=0)
								vR2:=15
							End if 
							CMAComOrderOneLine(1)  //create line item with order
							vDate6:=Current date:C33
							v6:=srMfgOrd
							v7:=""
							//FontSrchOrd (2)
							vR6:=Round:C94(vAmount; <>tcDecimalTt)
							vR5:=Round:C94(vR6*vR2*0.01; <>tcDecimalTt)
							aUnPaid:=0
							doNewInv:=True:C214
							CMAComInvoiceOneLine(1)
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
End if 
