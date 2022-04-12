//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-27T06:00:00Z)
// Method: P_FillVars
// Description 
// Parameters
// ----------------------------------------------------

P_ClearVars
var $data_o; print_o : Object
If (Count parameters:C259=1)
	$data_o:=$1
Else 
	$data_o:=process_o
End if 
If ($data_o.ents=Null:C1517)
	$data_o.ents:=New object:C1471
End if 
print_o:=New object:C1471

SRDate:=Current date:C33
SRDateLong:=<>arrmonth{Month of:C24(Current date:C33)}+" "+String:C10(Day of:C23(Current date:C33))+", "+String:C10(Year of:C25(Current date:C33))
SRTime:=Current time:C178*1
print_o.SRDate:=SRDate
print_o.SRDateLong:=SRDateLong
print_o.SRTime:=SRTime



If ($data_o.currentRecord.customerID=Null:C1517)
	$data_o.ents.Customer:=Null:C1517
Else 
	$data_o.ents.Customer:=ds:C1482.Customer.query("customerID = :1"; $data_o.currentRecord.customerID).first()
	CustAddress:=PVars_AddressFull($data_o.ents.Customer)
End if 
print_o.CustAddress:=CustAddress


If ($data_o.currentRecord.mfrID=Null:C1517)
	$data_o.ents.Manufacturer:=Null:C1517
Else 
	$data_o.ents.Manufacturer:=ds:C1482.Customer.query("customerID = :1"; $data_o.currentRecord.customerID).first()
	PVars_Manufacturer($data_o.ents.Manufacturer)
End if 



If ($data_o.currentRecord.repID#"")
	$data_o.ents.Rep:=ds:C1482.Rep.query("repID = :1"; $data_o.currentRecord.repID).first()
	AddressRep:=PVars_AddressFull($data_o.ents.Rep)
	RepAddress:=AddressRep
	print_o.AddressRep:=AddressRep
	print_o.RepAddress:=RepAddress
	
End if 
If ($data_o.currentRecord.addressBillTo#Null:C1517)
	AddressBillTo:=$data_o.currentRecord.addressBillTo
	print_o.AddressBillTo:=AddressBillTo
End if 


If ($data_o.currentRecord.addressShipFrom#Null:C1517)
	print_o.addressShipFrom:=$data_o.currentRecord.addressShipFrom
End if 

If ($data_o.currentRecord.addressBillTo#Null:C1517)
	AddressBillTo:=$data_o.currentRecord.addressBillTo
	print_o.AddressBillTo:=AddressBillTo
End if 

Case of 
	: ($data_o.attention#Null:C1517)
		LtrAttn:=$data_o.attention
		print_o.LtrAttn:=LtrAttn
		
	: ($data_o.nameFirst#Null:C1517)
		LtrAttn:=$data_o.nameFirst+" "+$data_o.nameLast
		print_o.LtrAttn:=LtrAttn
End case 

$data_o.ents.Employee:=PVar_EmployeeSignedBy($data_o.currentRecord.actionBy)
LtrSignedBy:=$data_o.ents.Employee.LtrSignedBy
pvEmailEmployee:=$data_o.ents.Employee.email

print_o.LtrSignedBy:=LtrSignedBy
print_o.pvEmailEmployee:=pvEmailEmployee


AddressPrimary:=PVars_AddressFull($data_o.currentRecord)

print_o.AddressPrimary:=AddressPrimary
